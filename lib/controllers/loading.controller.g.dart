// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loading.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoadingController on _LoadingController, Store {
  final _$isLoadingAtom = Atom(name: '_LoadingController.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$_LoadingControllerActionController =
      ActionController(name: '_LoadingController');

  @override
  bool updateLoading(bool value) {
    final _$actionInfo = _$_LoadingControllerActionController.startAction(
        name: '_LoadingController.updateLoading');
    try {
      return super.updateLoading(value);
    } finally {
      _$_LoadingControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> showLoading() {
    final _$actionInfo = _$_LoadingControllerActionController.startAction(
        name: '_LoadingController.showLoading');
    try {
      return super.showLoading();
    } finally {
      _$_LoadingControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
