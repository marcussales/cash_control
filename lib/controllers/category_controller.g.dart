// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoryController on _CategoryController, Store {
  final _$selectedCategorySpentAtom =
      Atom(name: '_CategoryController.selectedCategorySpent');

  @override
  CategoryModel get selectedCategorySpent {
    _$selectedCategorySpentAtom.reportRead();
    return super.selectedCategorySpent;
  }

  @override
  set selectedCategorySpent(CategoryModel value) {
    _$selectedCategorySpentAtom.reportWrite(value, super.selectedCategorySpent,
        () {
      super.selectedCategorySpent = value;
    });
  }

  final _$getCategoriesAsyncAction =
      AsyncAction('_CategoryController.getCategories');

  @override
  Future<dynamic> getCategories({int limit}) {
    return _$getCategoriesAsyncAction
        .run(() => super.getCategories(limit: limit));
  }

  final _$getCategorySpentsAsyncAction =
      AsyncAction('_CategoryController.getCategorySpents');

  @override
  Future<dynamic> getCategorySpents({int limit}) {
    return _$getCategorySpentsAsyncAction
        .run(() => super.getCategorySpents(limit: limit));
  }

  final _$getMoreEconomicCategoriesAsyncAction =
      AsyncAction('_CategoryController.getMoreEconomicCategories');

  @override
  Future<List<CategoryModel>> getMoreEconomicCategories() {
    return _$getMoreEconomicCategoriesAsyncAction
        .run(() => super.getMoreEconomicCategories());
  }

  final _$_CategoryControllerActionController =
      ActionController(name: '_CategoryController');

  @override
  CategoryModel selectCategorySpent(dynamic c) {
    final _$actionInfo = _$_CategoryControllerActionController.startAction(
        name: '_CategoryController.selectCategorySpent');
    try {
      return super.selectCategorySpent(c);
    } finally {
      _$_CategoryControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  CategoryModel resetSelectedCategory() {
    final _$actionInfo = _$_CategoryControllerActionController.startAction(
        name: '_CategoryController.resetSelectedCategory');
    try {
      return super.resetSelectedCategory();
    } finally {
      _$_CategoryControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedCategorySpent: ${selectedCategorySpent}
    ''';
  }
}
