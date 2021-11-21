import 'package:cash_control/api/user_api.dart';
import 'package:cash_control/models/UserModel.dart';
import 'package:cash_control/models/UserSavingsModel.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/shared/dialog_message.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

class UserController = _UserController with _$UserController;

abstract class _UserController with Store {
  UserApi _api = UserApi();

  @observable
  UserModel user = UserModel();

  @observable
  bool doLogin = false;

  @observable
  double averageValue = 0.0;

  @observable
  double percentBalance = 0.0;

  @observable
  double currentSaving = 0.0;

  @observable
  bool isNewUser = false;

  @action
  bool updateLoginStatus(value) => doLogin = value;

  Future<void> logoutCurrentUser(_googleSignIn) async {
    if (_googleSignIn.currentUser == null) {
      await _googleSignIn.signOut();
    }
  }

  @action
  Future loginOrSignUp(GoogleSignInAccount googleSignInAccount) async {
    if (googleSignInAccount == null) {
      return;
    }
    auth.user = UserModel();
    updateLoginStatus(true);
    final UserModel currentUserData =
        await _api.login(googleSignInAccount.email, googleSignInAccount.id);
    if (currentUserData != null) {
      isNewUser = false;
      return _setDataToUser(googleSignInAccount, currentUserData, false);
    } else {
      await signUpUser(googleSignInAccount);
    }
  }

  Future<UserModel> signUpUser(GoogleSignInAccount googleSignInAccount) async {
    // ignore: lines_longer_than_80_chars
    final UserModel formattedUser =
        _api.mapGoogleUserToUser(googleSignInAccount);
    final UserModel newUserData = await _api.signUp(formattedUser);
    return _setDataToUser(googleSignInAccount, newUserData, true);
  }

  @action
  Future<UserModel> _setDataToUser(GoogleSignInAccount googleSignInAccount,
      UserModel data, bool newUser) async {
    if (googleSignInAccount == null) {
      navigatorPlus.backAll();
      return data;
    }
    if (data == null) {
      DialogMessage.showMessage(
        title: 'Ops... você já tem cadastro, tente fazer login',
        bgColor: ColorsUtil.verdeSecundario,
      );
      return data;
    }
    auth.user.newUser = newUser;
    auth.user.photoUrl = googleSignInAccount.photoUrl;
    auth.user.id = data.id;
    auth.user.displayName = data.displayName;
    auth.user.monthIncome = data.monthIncome;
    auth.user.spentGoal = data.spentGoal;
    auth.user.savings = data.savings;
    updateLoginStatus(false);
    loading.updateLoading(false);
    return auth.user;
  }

  Future<void> saveUser({Function callback, double incomeValue}) async {
    loading.updateLoading(true);
    auth.user.monthIncome = incomeValue ?? auth.user.monthIncome;
    await _api.saveUserData();
    loading.updateLoading(false);
    if (callback != null) callback.call();
  }

  @action
  averageCalc() {
    double values = 0.0;
    auth.user.savings.forEach((s) {
      values += s.savings;
    });
    averageValue = values / auth.user.savings.length;
  }

  @action
  percentageDiffCurrentPreviousMonth() {
    if (auth.user.savings.length >= 2) {
      currentSaving = auth.user.savings
          .firstWhere(((s) => s.month == DateTime.now().month))
          .savings;
      UserSavingsModel previousMonth = auth.user.savings
          .firstWhere(((s) => s.month == (DateTime.now().month - 1)));
      num percent =
          ((currentSaving - previousMonth.savings) / (currentSaving) * 100);
      percentBalance = double.parse(percent.toStringAsFixed(2));
    }
  }

  @action
  Future<void> logout() async {
    await _api.logout();
    _setDataToUser(null, null, false);
  }
}
