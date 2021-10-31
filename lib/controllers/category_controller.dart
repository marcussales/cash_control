import 'package:cash_control/api/category_api.dart';
import 'package:cash_control/models/CardSpentModel.dart';
import 'package:cash_control/models/CategoryModel.dart';
import 'package:cash_control/shared/global.dart';
import 'package:mobx/mobx.dart';
part 'category_controller.g.dart';

class CategoryController = _CategoryController with _$CategoryController;

abstract class _CategoryController with Store {
  CategoryApi _api = CategoryApi();
  ObservableList<CategoryModel> categoriesList =
      ObservableList<CategoryModel>();

  ObservableList<CategoryModel> moreEconomicCategoriesList =
      ObservableList<CategoryModel>();

  @observable
  CategoryModel selectedCategorySpent = CategoryModel();

  Future<void> saveCategory(
      String title, String spentGoal, String icon, Function callBack) async {
    loading.updateLoading(true);
    await _api.saveCategory(title, spentGoal, icon);
    callBack.call();
    loading.updateLoading(false);
  }

  @action
  Future getCategories({int limit}) async {
    loading.updateLoading(true);
    categoriesList = ObservableList<CategoryModel>();
    var listFromApi = await _api.getCategories(limit: limit);
    categoriesList.addAll(listFromApi);
    loading.updateLoading(false);
  }

  @action
  Future getCategorySpents({int limit}) async {
    loading.updateLoading(true);
    categoriesList = ObservableList<CategoryModel>();
    var listFromApi = await _api.getCategories(limit: limit);
    categoriesList.addAll(listFromApi);
    Future.delayed(Duration(seconds: 3))
        .then((value) => loading.updateLoading(false));
  }

  @action
  CategoryModel selectCategorySpent(c) {
    selectedCategorySpent = null;
    selectedCategorySpent = c;
    return c;
  }

  updateMonthSpent({String id, double spent}) async {
    await _api.updateMonthSpentCategory(categoryId: id, spent: spent);
  }

  @action
  CategoryModel resetSelectedCategory() =>
      selectedCategorySpent = CategoryModel();

  @action
  Future<List<CategoryModel>> getMoreEconomicCategories() async {
    List<CategoryModel> categoriesWithSpentThisMonth = [];
    List<CategoryModel> moreEconomicCategories = [];
    categoriesList.forEach((c) {
      if (c.monthSpents.firstWhere((m) => m['month'] == DateTime.now().month) !=
          null) {
        categoriesWithSpentThisMonth.add(c);
      }
    });
  }

  bool isSelectedCategory(item) =>
      selectedCategorySpent.objectId == item.objectId;
}
