import 'package:cash_control/models/UserModel.dart';
import 'package:cash_control/models/UserSavingsModel.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/shared/parse_errors.dart';
import 'package:cash_control/shared/table_keys.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserApi {
  Future<UserModel> login(String email, String password) async {
    final parseUser = ParseUser(email, password, null);
    final response = await parseUser.login();
    if (response.success) {
      return mapParseToUser(response.result);
    } else {
      print(Future.error(ParseErrors.getDescription(response.error.code)));
      return null;
    }
  }

  Future<UserModel> signUp(UserModel user) async {
    final parseUser = ParseUser(user.email, user.id, user.email);
    parseUser.set<String>(keyUserName, user.displayName);
    parseUser.set<String>(keyUserId, user.id);
    final response = await parseUser.signUp();

    if (response.success) {
      return await mapParseToUser(response.result);
    }
  }

  Future<UserModel> saveUserData() async {
    final ParseUser parseUser = await ParseUser.currentUser();
    parseUser.set<String>(keyUserName, auth.user.displayName);
    parseUser.set<num>(keyUserSpentGoal, auth.user.spentGoal);
    parseUser.set<num>(keyMonthIncome, auth.user.monthIncome);
    // ignore: always_specify_types
    parseUser.set<List>(keySavings, auth.user.savings);
    final ParseResponse response = await parseUser.save();

    if (response.success) {
      return mapParseToUser(response.result);
    } else {
      return null;
    }
  }

  Future<void> logout() async {
    final ParseUser currentUser = await ParseUser.currentUser();
    await currentUser.logout();
  }

  UserModel mapParseToUser(user) {
    List<UserSavingsModel> savingsList = [];
    if (auth.user?.savings == null) {
      user
          .get(keySavings)
          .forEach((s) => savingsList.add(mapParseToSavingsModel(s)));
    } else {
      savingsList = auth.user.savings;
    }

    return UserModel(
        displayName: user.get(keyUserName),
        id: user.objectId,
        spentGoal: user.get(keyUserSpentGoal) != null
            ? user.get(keyUserSpentGoal).toDouble()
            : 0.0,
        monthIncome: user.get(keyMonthIncome) != null
            ? user.get(keyMonthIncome).toDouble()
            : 0.0,
        savings: savingsList,
        email: user.get(keyUserEmail));
  }

  UserModel mapGoogleUserToUser(user) {
    return UserModel(
        displayName: user.displayName, id: user.id, email: user.email);
  }

  UserSavingsModel mapParseToSavingsModel(savings) {
    return UserSavingsModel(
        month: savings['month'], savings: savings['savings']);
  }
}
