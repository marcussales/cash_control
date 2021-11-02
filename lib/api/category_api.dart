import 'package:cash_control/models/CardSpentModel.dart';
import 'package:cash_control/models/CategoryModel.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/shared/parse_errors.dart';
import 'package:cash_control/shared/snackbar_message.dart';
import 'package:cash_control/shared/table_keys.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CategoryApi {
  Future<void> saveCategory(String title, String spentGoal, String icon) async {
    try {
      final categoryObject = ParseObject(keyCategoryTable);
      categoryObject.set<String>(keyCategoryIcon, icon);
      categoryObject.set<String>(keyCategoryTitle, title);
      categoryObject.set<String>(keyCategorySpentGoal, spentGoal);
      categoryObject.set<String>(keyUserId, auth.user.id);
      final response = await categoryObject.save();
      if (!response.success) {
        return Future.error(ParseErrors.getDescription(response.error.code));
      } else {
        return;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<CategoryModel>> getCategories({int limit}) async {
    final queryBuilder = QueryBuilder(ParseObject(keyCategoryTable))
      ..orderByDescending(keyVarUpdatedAt);

    if (limit != null) queryBuilder.setLimit(limit);

    queryBuilder.whereEqualTo(keyUserId, auth.user.id);

    final response = await queryBuilder.query();
    if (response.success) {
      if (response.results == null) {
        return [];
      }
      return response.results
          .map((e) => CategoryModel().mapParseToCategory(e))
          .toList();
    } else {
      return SnackBarMessage()
          .errorMsg(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<List<CategoryModel>> getMoreEconomicCategories() async {
    final queryBuilder = QueryBuilder(ParseObject(keyCategoryTable))
      ..orderByAscending(keyMonthSpents);

    queryBuilder.whereEqualTo(keyUserId, auth.user.id);

    final response = await queryBuilder.query();
    if (response.success) {
      return response.results
          .map((e) => CategoryModel().mapParseToCategory(e))
          .toList();
    } else {
      return SnackBarMessage()
          .errorMsg(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<List<CategoryModel>> updateMonthSpentCategory(
      {String categoryId, double spent}) async {
    final queryBuilder = QueryBuilder(ParseObject(keyCategoryTable));
    queryBuilder.whereEqualTo(keyObjectId, categoryId);

    final response = await queryBuilder.query();
    if (response.success) {
      final category = response.results;
      final categoryObject = ParseObject(keyCategoryTable);
      if (category.first[keyMonthSpents] == null) {
        category.first[keyMonthSpents] = [
          {'month': DateTime.now().month, 'totalValue': 0.0}
        ];
      }
      final currentMonthIdx = category.first[keyMonthSpents]
          .indexWhere((c) => c['month'] == DateTime.now().month);
      final currentMonthSpents =
          category.first[keyMonthSpents][currentMonthIdx];
      if (currentMonthSpents != null) {
        currentMonthSpents['totalValue'] =
            currentMonthSpents['totalValue'] != null
                ? currentMonthSpents['totalValue'] + spent
                : spent;
      } else {
        category.first['monthSpents'].add(CardMonthSpentsModel(
                month: DateTime.now().month,
                totalValue: (spent + currentMonthSpents['totalValue']))
            .toJson());
      }
      categoryObject.set<String>(keyObjectId, categoryId);
      categoryObject.set<String>(keyUserId, auth.user.id);
      categoryObject.set<List>(keyMonthSpents, category.first['monthSpents']);
      final res = await categoryObject.save();
      if (!res.success) {
        return Future.error(ParseErrors.getDescription(response.error.code));
      } else {
        return [];
      }
    } else {
      return SnackBarMessage()
          .errorMsg(ParseErrors.getDescription(response.error.code));
    }
  }
}
