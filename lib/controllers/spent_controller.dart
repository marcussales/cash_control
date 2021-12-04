import 'package:cash_control/api/card_api.dart';
import 'package:cash_control/api/spent_api.dart';
import 'package:cash_control/controllers/category_controller.dart';
import 'package:cash_control/models/CardModel.dart';
import 'package:cash_control/models/CategoryModel.dart';
import 'package:cash_control/models/MonthModel.dart';
import 'package:cash_control/models/SpentModel.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/shared/dialog_message.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:mobx/mobx.dart';
import 'package:cash_control/util/extensions.dart';
part 'spent_controller.g.dart';

class SpentController = _SpentController with _$SpentController;

enum MonthsEnum {
  JANEIRO,
  FEVEREIRO,
  MARCO,
  ABRIL,
  MAIO,
  JUNHO,
  JULHO,
  AGOSTO,
  SETEMBRO,
  OUTUBRO,
  NOVEMBRO,
  DEZEMBRO
}

abstract class _SpentController with Store {
  _SpentController() {
    reaction(
        (_) => updateSpentsStatus,
        (updateSpents) => {
              if (currentCard != null)
                {
                  getSpents(cardId: currentCard.cardId),
                  updateCurrentCard(null),
                }
              else
                {getSpents()},
              cardController.getCards(),
            });
  }

  SpentApi _api = SpentApi();
  CardApi _cardApi = CardApi();
  ObservableList<SpentModel> mySpents = ObservableList();
  ObservableList<SpentModel> categorySpents = ObservableList();

  List<MonthModel> months = <MonthModel>[
    MonthModel(month: 'JANEIRO', id: MonthsEnum.JANEIRO.index + 1),
    MonthModel(month: 'FEVEREIRO', id: MonthsEnum.FEVEREIRO.index + 1),
    MonthModel(month: 'MARÇO', id: MonthsEnum.MARCO.index + 1),
    MonthModel(month: 'ABRIL', id: MonthsEnum.ABRIL.index + 1),
    MonthModel(month: 'MAIO', id: MonthsEnum.MAIO.index + 1),
    MonthModel(month: 'JUNHO', id: MonthsEnum.JUNHO.index + 1),
    MonthModel(month: 'JULHO', id: MonthsEnum.JULHO.index + 1),
    MonthModel(month: 'AGOSTO', id: MonthsEnum.AGOSTO.index + 1),
    MonthModel(month: 'SETEMBRO', id: MonthsEnum.SETEMBRO.index + 1),
    MonthModel(month: 'OUTUBRO', id: MonthsEnum.OUTUBRO.index + 1),
    MonthModel(month: 'NOVEMBRO', id: MonthsEnum.NOVEMBRO.index + 1),
    MonthModel(month: 'DEZEMBRO', id: MonthsEnum.DEZEMBRO.index + 1),
  ];

  @observable
  bool emptySearch = false;

  @observable
  double categorySpentsValue = 0;

  @observable
  bool positiveBalance = false;

  @observable
  bool updateSpentsStatus = false;

  @observable
  CardModel currentCard;

  @observable
  CategoryModel selectedCategory;

  @observable
  CardModel cardSpent = CardModel();

  @observable
  String searchText = '';

  @observable
  int page = 0;

  @action
  bool changeUpdateSpentStatus() => updateSpentsStatus = !updateSpentsStatus;

  @action
  updateCurrentCard(CardModel card) => currentCard = card;

  @action
  CategoryModel updateSelectedCategory(value) => selectedCategory = value;

  @action
  bool isEmptySearch(dynamic value) => emptySearch = value;

  @action
  Future<void> registerSpent(
      {SpentModel spent, String diffValue, Function callback}) async {
    loading.updateLoading(true);
    await _api.saveSpent(spent: spent, diffValue: diffValue);
    categoryController.selectedCategorySpent = CategoryModel();
    changeUpdateSpentStatus();
    cardController.isUpdatingCards(true);
    categoryController.getCategories();
    loading.updateLoading(false);
    DialogMessage.showSucessMessage('Gasto registrado com sucesso!');
    pagesStore.page != 2 ? navigatorPlus.back() : pagesStore.setPage(0);
  }

  @action
  Future<void> getSpents({String cardId}) async {
    if (page == 0) {
      mySpents.clear();
    }
    loading.updateLoading(true);
    isEmptySearch(false);
    List<SpentModel> monthSpents = await _api.getMonthSpents(
        currentMonth: DateTime.now().month, cardId: cardId, page: page);
    if (monthSpents.length == 0) isEmptySearch(true);
    mySpents.addAll(monthSpents);
    loading.updateLoading(false);
    searchText = '';
  }

  @action
  Future<void> getCategorySpents(CategoryModel category) async {
    categorySpents.clear();
    loading.updateLoading(true);
    List<SpentModel> spents = await _api.getCategorySpents(category: category);
    categorySpents.addAll(spents);
    sumCategorySpentsValue();
    loading.updateLoading(false);
  }

  @action
  sumCategorySpentsValue() {
    categorySpents.forEach((SpentModel e) {
      categorySpentsValue += double.parse(e.amount);
    });
  }

  @action
  diffCategorySpents(value) {
    if (categorySpentsValue == 0.0) {
      return '${double.parse((value).toString()).formattedMoneyBr()}';
    }
    return '${double.parse((value - categorySpentsValue).toString()).formattedMoneyBr()}';
  }

  @action
  bool isPositiveBalance({double value}) =>
      positiveBalance = categorySpentsValue < value;

  @action
  Future<void> searchSpent() async {
    loading.updateLoading(true);
    mySpents.clear();
    List<SpentModel> result = await _api.searchSpent(search: searchText);
    if (result == null) {
      isEmptySearch(true);
    } else {
      mySpents.addAll(result);
      isEmptySearch(false);
    }
    loading.updateLoading(false);
  }

  @action
  CardModel selectCardSpent(CardModel card) {
    cardSpent = null;
    cardSpent = card;
    return card;
  }

  @action
  Future<void> deleteSpent(SpentModel spent) async {
    await _api.delete(spent: spent);
    await _cardApi.removeSpentFromCard(spent: spent);
    await cardController.getCards();
    await cardController.getSavingsData();
    loading.updateLoading(false);
    changeUpdateSpentStatus();
  }

  @action
  updateMonthSpent({String id, double spent}) async {
    await categoryController.updateMonthSpent(
        id: selectedCategory.objectId, spent: spent);
  }

  @action
  nextPage() {
    page++;
    getSpents();
  }

  getFormattedCurrentMonth() {
    return months.firstWhere((m) => m.id == DateTime.now().month).month;
  }

  bool isSelectedCard(item) =>
      cardSpent != null ? cardSpent.cardId == item.cardId : false;

  bool canRegisterSpent() {
    return hasCards() && hasCategories();
  }

  bool hasCategories() {
    return categoryController.categoriesList.isNotEmpty;
  }

  bool hasCards() {
    return cardController.cards.isNotEmpty;
  }

  String cantRegisterSpentMessage() {
    if (!hasCards()) {
      // ignore: lines_longer_than_80_chars
      return 'Para registrar seus gastos precisamos ao menos um cartão registrado';
    } else if (!hasCategories()) {
      return 'Para registrar seus gastos precisamos ao menos uma categoria registrada';
      // ignore: lines_longer_than_80_chars
    }
    // ignore: lines_longer_than_80_chars
    return 'Para registrar seus gastos precisamos ao menos uma categoria e um cartão registrados';
  }
}
