import 'package:cash_control/api/category_api.dart';
import 'package:cash_control/models/CardSpentModel.dart';
import 'package:cash_control/models/CategoryModel.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/shared/dialog_message.dart';
import 'package:flutter_plus/flutter_plus.dart';
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
      {String title, String spentGoal, String icon, String id}) async {
    loading.updateLoading(true);
    await _api.saveCategory(title, spentGoal, icon, id);
    DialogMessage.showSucessMessage(id != null
        ? 'Categoria criada com sucesso'
        : 'Categoria editada com sucesso');
    await getCategories();
    CategoryModel currentCategory =
        categoriesList.firstWhere((CategoryModel c) => c.objectId == id);
    navigatorPlus.back(result: currentCategory);
    loading.updateLoading(false);
  }

  bool checkCategoryExist({String title, bool edit}) {
    int categoryWithSameNameIdx = categoriesList.indexWhere(
        (CategoryModel category) =>
            category.title.toLowerCase() == title.toLowerCase());
    return categoryWithSameNameIdx != -1 && !edit;
  }

  @action
  Future<void> getCategories({int limit}) async {
    loading.updateLoading(true);
    categoriesList = ObservableList<CategoryModel>();
    List<CategoryModel> listFromApi = await _api.getCategories(limit: limit);
    categoriesList.addAll(listFromApi);
    loading.updateLoading(false);
  }

  @action
  CategoryModel selectCategorySpent(CategoryModel category) {
    selectedCategorySpent = null;
    selectedCategorySpent = category;
    return category;
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
