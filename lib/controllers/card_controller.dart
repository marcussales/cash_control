import 'package:cash_control/api/card_api.dart';
import 'package:cash_control/controllers/user_controller.dart';
import 'package:cash_control/models/BankModel.dart';
import 'package:cash_control/models/CardModel.dart';
import 'package:cash_control/models/SpentModel.dart';
import 'package:cash_control/models/UserSavingsModel.dart';
import 'package:cash_control/shared/global.dart';
import 'package:mobx/mobx.dart';
import 'dart:math';
part 'card_controller.g.dart';

enum CardTypesEnum { CREDIT, DEBT }
enum BanksEnum {
  NUBANK,
  INTER,
  SANTANDER,
  BANCO_DO_BRASIL,
  BRADESCO,
  ITAU,
  CAIXA
}
class CardController = _CardController with _$CardController;

abstract class _CardController with Store {
  _CardController() {
    reaction((_) => updateCards, (updateCards) => getCards());
  }
  CardApi _cardApi = CardApi();
  UserController _userController = UserController();

  List<CardModel> typeCards = [
    CardModel(cardType: 'CRÉDITO', cardTypeId: CardTypesEnum.CREDIT.index),
    CardModel(cardType: 'DÉBITO', cardTypeId: CardTypesEnum.DEBT.index)
  ];

  List<BankModel> banks = [
    BankModel(bankName: 'NUBANK', bankId: BanksEnum.NUBANK.index),
    BankModel(bankName: 'INTER', bankId: BanksEnum.INTER.index),
    BankModel(bankName: 'SANTANDER', bankId: BanksEnum.SANTANDER.index),
    BankModel(
        bankName: 'BANCO DO BRASIL', bankId: BanksEnum.BANCO_DO_BRASIL.index),
    BankModel(bankName: 'BRADESCO', bankId: BanksEnum.BRADESCO.index),
    BankModel(bankName: 'ITÁU', bankId: BanksEnum.ITAU.index),
    BankModel(bankName: 'CAIXA', bankId: BanksEnum.CAIXA.index),
  ];

  @observable
  CardModel selectedCard = CardModel();

  @observable
  bool updateCards = false;

  ObservableList<CardModel> cards = ObservableList();

  @observable
  double totalCardSpents = 0.0;

  @action
  CardModel selectCard(value) => selectedCard = value;

  @action
  bool isUpdatingCards(value) => updateCards = value;

  @action
  bool isSelectedCard(card) => selectedCard.cardTypeId != null
      ? selectedCard.cardTypeId == card.cardTypeId
      : false;

  @observable
  BankModel selectedBank = BankModel();

  @action
  BankModel selectBank(value) => selectedBank = value;

  @observable
  double averageValue = 0.0;

  @action
  double updateAverageValue(value) => averageValue = value;

  @action
  resetSelecteds() {
    selectedBank = BankModel();
    selectedCard = CardModel();
  }

  bool isSelectedBank(bank) =>
      selectedBank.bankId == mapToBankModel(bank).bankId;

  mapToCardModel(item) {
    return CardModel(
        cardType: item.title, cardTypeId: int.parse(item.objectId));
  }

  mapToBankModel(item) {
    return BankModel(bankName: item.title, bankId: int.parse(item.objectId));
  }

  Future saveCard(String name, int typeId, int bankId, String spentGoal,
      Function callback) async {
    var cardName = '${typeCards[typeId].cardType} - ${banks[bankId].bankName}';
    await _cardApi.saveCard(
        name, typeId, bankId, cardName.toUpperCase(), spentGoal);
    callback.call();
    isUpdatingCards(true);
  }

  Future updateCardSpents(
      {String cardId,
      double spentValue,
      int spentMonth,
      bool resetSpentsValue = false}) async {
    await _cardApi.updateCardMonthSpents(
        cardObjectId: cardId,
        spentValue: spentValue,
        spentMonth: spentMonth,
        resetSpentsValue: resetSpentsValue);
  }

  @action
  Future getCards() async {
    loading.updateLoading(true);
    var myCards = await _cardApi.getUserCards();
    cards.clear();
    cards.addAll(myCards);
    loading.updateLoading(false);
  }

  Future getSavingsData() async {
    await sumCardsSpents(cards: cards);
    await updateSavingsValue();
  }

  @observable
  double savingsValue = 0.0;

  @action
  updateSavingsValue() {
    savingsValue = auth.user.monthIncome - totalCardSpents;
    int currentMonthSavingsIdx =
        auth.user.savings.indexWhere((s) => (s.month) == DateTime.now().month);
    if (currentMonthSavingsIdx != -1) {
      auth.user.savings[currentMonthSavingsIdx] =
          UserSavingsModel(month: DateTime.now().month, savings: savingsValue);
      _userController.saveUser();
    }
    auth.user.savings
        .add(UserSavingsModel(month: DateTime.now().month, savings: 0.0));
  }

  @action
  sumCardsSpents({List<CardModel> cards}) {
    totalCardSpents = 0.0;
    savingsValue = 0.0;
    cards.forEach((c) {
      totalCardSpents += c.monthSpents.totalValue;
    });
  }

  CardModel moreEconomicCard() {
    List<num> spentsByCards = [];
    cards.forEach((c) => spentsByCards.add(c.monthSpents.totalValue));
    var moreEconomic = cards.firstWhere((CardModel card) =>
        card.monthSpents.totalValue == spentsByCards.reduce(min));
    return moreEconomic;
  }
}
