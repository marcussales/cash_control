import 'package:cash_control/models/IconsModel.dart';
import 'package:cash_control/shared/parse_errors.dart';
import 'package:cash_control/shared/snackbar_message.dart';
import 'package:cash_control/shared/table_keys.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class IconsApi {
  Future<List<IconModel>> getList() async {
    final queryBuilder = QueryBuilder(ParseObject(keyIconsTable))
      ..orderByAscending(keyIconName);
    final response = await queryBuilder.query();

    if (response.success) {
      return response.results.map((e) => mapParseToIcon(e)).toList();
    } else {
      return SnackBarMessage()
          .errorMsg(ParseErrors.getDescription(response.error.code));
    }
  }

  IconModel mapParseToIcon(icon) {
    return IconModel(
        name: icon.get(keyIconName), icon: icon.get(keyIconImage).url);
  }
}
