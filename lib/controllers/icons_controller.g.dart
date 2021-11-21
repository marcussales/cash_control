// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icons_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$IconsController on _IconsController, Store {
  final _$selectedItemAtom = Atom(name: '_IconsController.selectedItem');

  @override
  int get selectedItem {
    _$selectedItemAtom.reportRead();
    return super.selectedItem;
  }

  @override
  set selectedItem(int value) {
    _$selectedItemAtom.reportWrite(value, super.selectedItem, () {
      super.selectedItem = value;
    });
  }

  final _$setSelectedItemAsyncAction =
      AsyncAction('_IconsController.setSelectedItem');

  @override
  Future setSelectedItem(dynamic value) {
    return _$setSelectedItemAsyncAction.run(() => super.setSelectedItem(value));
  }

  final _$getIconsListAsyncAction =
      AsyncAction('_IconsController.getIconsList');

  @override
  Future<void> getIconsList() {
    return _$getIconsListAsyncAction.run(() => super.getIconsList());
  }

  final _$_IconsControllerActionController =
      ActionController(name: '_IconsController');

  @override
  void _refreshList() {
    final _$actionInfo = _$_IconsControllerActionController.startAction(
        name: '_IconsController._refreshList');
    try {
      return super._refreshList();
    } finally {
      _$_IconsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCategoryIcon(String iconUrl) {
    final _$actionInfo = _$_IconsControllerActionController.startAction(
        name: '_IconsController.setCategoryIcon');
    try {
      return super.setCategoryIcon(iconUrl);
    } finally {
      _$_IconsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedItem: ${selectedItem}
    ''';
  }
}
