// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserController on _UserController, Store {
  final _$userAtom = Atom(name: '_UserController.user');

  @override
  UserModel get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$doLoginAtom = Atom(name: '_UserController.doLogin');

  @override
  bool get doLogin {
    _$doLoginAtom.reportRead();
    return super.doLogin;
  }

  @override
  set doLogin(bool value) {
    _$doLoginAtom.reportWrite(value, super.doLogin, () {
      super.doLogin = value;
    });
  }

  final _$loginOrSignUpAsyncAction =
      AsyncAction('_UserController.loginOrSignUp');

  @override
  Future<dynamic> loginOrSignUp(GoogleSignInAccount googleSignInAccount) {
    return _$loginOrSignUpAsyncAction
        .run(() => super.loginOrSignUp(googleSignInAccount));
  }

  final _$_UserControllerActionController =
      ActionController(name: '_UserController');

  @override
  bool updateLoginStatus(dynamic value) {
    final _$actionInfo = _$_UserControllerActionController.startAction(
        name: '_UserController.updateLoginStatus');
    try {
      return super.updateLoginStatus(value);
    } finally {
      _$_UserControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
doLogin: ${doLogin}
    ''';
  }
}
