import 'package:cash_control/shared/dialog_message.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:cash_control/util/extensions.dart';

import 'global.dart';

// ignore: public_member_api_docs
class Util {
  // ignore: public_member_api_docs
  static Future<void> getData() async {
    if (!auth.user.newUser) {
      await categoryController.getCategories();
      await cardController.getCards();
      await cardController.getSavingsData();
      await spentController.getSpents();
    }
  }

  static checkValueIsZero({String value}) {
    return value.valueIsZero();
  }

  // ignore: public_member_api_docs

}
