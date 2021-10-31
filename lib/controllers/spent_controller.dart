import 'package:cash_control/api/card_api.dart';
import 'package:cash_control/api/spent_api.dart';
import 'package:cash_control/controllers/category_controller.dart';
import 'package:cash_control/models/CardModel.dart';
import 'package:cash_control/models/CategoryModel.dart';
import 'package:cash_control/models/MonthModel.dart';
import 'package:cash_control/models/SpentModel.dart';
import 'package:cash_control/shared/global.dart';
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
    reaction((_) => updateSpentsStatus,
        (updateSpents) => {getSpents(), cardController.getCards()});
  }

  SpentApi _api = SpentApi();
  CardApi _cardApi = CardApi();
  ObservableList<SpentModel> mySpents = ObservableList();
  ObservableList<SpentModel> categorySpents = ObservableList();

  List<MonthModel> months = [
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
  CategoryModel selectedCategory;

  @action
  bool changeUpdateSpentStatus() => updateSpentsStatus = !updateSpentsStatus;

  @action
  CategoryModel updateSelectedCategory(value) => selectedCategory = value;

  @action
  bool updateSearch(value) => emptySearch = value;

  @action
  Future<void> registerSpent(SpentModel spent, Function callback) async {
    await _api.saveSpent(spent);
    categoryController.selectedCategorySpent = CategoryModel();
    callback.call();
    changeUpdateSpentStatus();
  }

  @action
  Future<void> getSpents({String cardId}) async {
    mySpents = ObservableList();
    loading.updateLoading(true);
    updateSearch(false);
    var montSpents = await _api.getMonthSpents(
        currentMonth: DateTime.now().month, cardId: cardId);
    if (montSpents.length == 0) updateSearch(true);
    mySpents.addAll(montSpents);
    loading.updateLoading(false);
  }

  @action
  Future<void> getCategorySpents(CategoryModel category) async {
    loading.updateLoading(true);
    var spents = await _api.getCategorySpents(category: category);
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
  diffCategorySpents(value1, value2) {
    if (value1 == 0.0)
      return '${double.parse((value2).toString()).formattedMoneyBr()}';
    return '${double.parse((value2 - value1).toString()).formattedMoneyBr()}';
  }

  @action
  bool isPositiveBalance({value1, value2}) => positiveBalance = value1 < value2;

  @action
  Future<void> searchSpent({String search}) async {
    loading.updateLoading(true);
    mySpents.clear();
    var result = await _api.searchSpent(search: search);
    if (result == null) {
      updateSearch(true);
    } else {
      mySpents.addAll(result);
      updateSearch(false);
    }
    loading.updateLoading(false);
  }

  @observable
  CardModel cardSpent = CardModel();

  @action
  CardModel selectCardSpent(c) {
    cardSpent = null;
    cardSpent = c;
    return c;
  }

  @action
  Future<void> deleteSpent(SpentModel spent) async {
    await _api.delete(spent: spent);
    await _cardApi.removeSpentFromCard(spent: spent);
    loading.updateLoading(false);
    changeUpdateSpentStatus();
  }

  @action
  updateMonthSpent({String id, double spent}) async {
    await categoryController.updateMonthSpent(
        id: selectedCategory.objectId, spent: spent);
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
      return 'Para registrar seus gastos precisamos ao menos uma categoria registrada';
    } else if (!hasCategories()) {
      return 'Para registrar seus gastos precisamos ao menos um cartão registrado';
    }
    return 'Para registrar seus gastos precisamos ao menos uma categoria e um cartão registrados';
  }
}
