// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spent_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SpentController on _SpentController, Store {
  final _$emptySearchAtom = Atom(name: '_SpentController.emptySearch');

  @override
  bool get emptySearch {
    _$emptySearchAtom.reportRead();
    return super.emptySearch;
  }

  @override
  set emptySearch(bool value) {
    _$emptySearchAtom.reportWrite(value, super.emptySearch, () {
      super.emptySearch = value;
    });
  }

  final _$categorySpentsValueAtom =
      Atom(name: '_SpentController.categorySpentsValue');

  @override
  double get categorySpentsValue {
    _$categorySpentsValueAtom.reportRead();
    return super.categorySpentsValue;
  }

  @override
  set categorySpentsValue(double value) {
    _$categorySpentsValueAtom.reportWrite(value, super.categorySpentsValue, () {
      super.categorySpentsValue = value;
    });
  }

  final _$positiveBalanceAtom = Atom(name: '_SpentController.positiveBalance');

  @override
  bool get positiveBalance {
    _$positiveBalanceAtom.reportRead();
    return super.positiveBalance;
  }

  @override
  set positiveBalance(bool value) {
    _$positiveBalanceAtom.reportWrite(value, super.positiveBalance, () {
      super.positiveBalance = value;
    });
  }

  final _$removeSpentAtom = Atom(name: '_SpentController.removeSpent');

  @override
  bool get removeSpent {
    _$removeSpentAtom.reportRead();
    return super.removeSpent;
  }

  @override
  set removeSpent(bool value) {
    _$removeSpentAtom.reportWrite(value, super.removeSpent, () {
      super.removeSpent = value;
    });
  }

  final _$selectedCategoryAtom =
      Atom(name: '_SpentController.selectedCategory');

  @override
  CategoryModel get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(CategoryModel value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  final _$cardSpentAtom = Atom(name: '_SpentController.cardSpent');

  @override
  CardModel get cardSpent {
    _$cardSpentAtom.reportRead();
    return super.cardSpent;
  }

  @override
  set cardSpent(CardModel value) {
    _$cardSpentAtom.reportWrite(value, super.cardSpent, () {
      super.cardSpent = value;
    });
  }

  final _$registerSpentAsyncAction =
      AsyncAction('_SpentController.registerSpent');

  @override
  Future<void> registerSpent(SpentModel spent, Function callback) {
    return _$registerSpentAsyncAction
        .run(() => super.registerSpent(spent, callback));
  }

  final _$getSpentsAsyncAction = AsyncAction('_SpentController.getSpents');

  @override
  Future<void> getSpents({String cardId}) {
    return _$getSpentsAsyncAction.run(() => super.getSpents(cardId: cardId));
  }

  final _$getCategorySpentsAsyncAction =
      AsyncAction('_SpentController.getCategorySpents');

  @override
  Future<void> getCategorySpents(CategoryModel category) {
    return _$getCategorySpentsAsyncAction
        .run(() => super.getCategorySpents(category));
  }

  final _$searchSpentAsyncAction = AsyncAction('_SpentController.searchSpent');

  @override
  Future<void> searchSpent({String search}) {
    return _$searchSpentAsyncAction
        .run(() => super.searchSpent(search: search));
  }

  final _$deleteSpentAsyncAction = AsyncAction('_SpentController.deleteSpent');

  @override
  Future<void> deleteSpent(SpentModel spent) {
    return _$deleteSpentAsyncAction.run(() => super.deleteSpent(spent));
  }

  final _$updateMonthSpentAsyncAction =
      AsyncAction('_SpentController.updateMonthSpent');

  @override
  Future updateMonthSpent({String id, double spent}) {
    return _$updateMonthSpentAsyncAction
        .run(() => super.updateMonthSpent(id: id, spent: spent));
  }

  final _$_SpentControllerActionController =
      ActionController(name: '_SpentController');

  @override
  CategoryModel updateSelectedCategory(dynamic value) {
    final _$actionInfo = _$_SpentControllerActionController.startAction(
        name: '_SpentController.updateSelectedCategory');
    try {
      return super.updateSelectedCategory(value);
    } finally {
      _$_SpentControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool isRemovingSpent(dynamic value) {
    final _$actionInfo = _$_SpentControllerActionController.startAction(
        name: '_SpentController.isRemovingSpent');
    try {
      return super.isRemovingSpent(value);
    } finally {
      _$_SpentControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool updateSearch(dynamic value) {
    final _$actionInfo = _$_SpentControllerActionController.startAction(
        name: '_SpentController.updateSearch');
    try {
      return super.updateSearch(value);
    } finally {
      _$_SpentControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic sumCategorySpentsValue() {
    final _$actionInfo = _$_SpentControllerActionController.startAction(
        name: '_SpentController.sumCategorySpentsValue');
    try {
      return super.sumCategorySpentsValue();
    } finally {
      _$_SpentControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic diffCategorySpents(dynamic value1, dynamic value2) {
    final _$actionInfo = _$_SpentControllerActionController.startAction(
        name: '_SpentController.diffCategorySpents');
    try {
      return super.diffCategorySpents(value1, value2);
    } finally {
      _$_SpentControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool isPositiveBalance(dynamic value1, dynamic value2) {
    final _$actionInfo = _$_SpentControllerActionController.startAction(
        name: '_SpentController.isPositiveBalance');
    try {
      return super.isPositiveBalance(value1, value2);
    } finally {
      _$_SpentControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  CardModel selectCardSpent(dynamic c) {
    final _$actionInfo = _$_SpentControllerActionController.startAction(
        name: '_SpentController.selectCardSpent');
    try {
      return super.selectCardSpent(c);
    } finally {
      _$_SpentControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
emptySearch: ${emptySearch},
categorySpentsValue: ${categorySpentsValue},
positiveBalance: ${positiveBalance},
removeSpent: ${removeSpent},
selectedCategory: ${selectedCategory},
cardSpent: ${cardSpent}
    ''';
  }
}
