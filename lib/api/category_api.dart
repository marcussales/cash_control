import 'package:cash_control/models/CardSpentModel.dart';
import 'package:cash_control/models/CategoryModel.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/shared/parse_errors.dart';
import 'package:cash_control/shared/dialog_message.dart';
import 'package:cash_control/shared/table_keys.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CategoryApi {
  Future<void> saveCategory(
      String title, String spentGoal, String icon, String id) async {
    try {
      ParseObject categoryObject = ParseObject(keyCategoryTable);
      if (id != null) {
        categoryObject.set<String>(keyObjectId, id);
      }
      categoryObject.set<String>(keyCategoryIcon, icon);
      categoryObject.set<String>(keyCategoryTitle, title);
      categoryObject.set<String>(keyCategorySpentGoal, spentGoal);
      categoryObject.set<String>(keyUserId, auth.user.id);
      ParseResponse response = await categoryObject.save();
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
    QueryBuilder<ParseObject> queryBuilder =
        QueryBuilder(ParseObject(keyCategoryTable))
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
      DialogMessage.errorMsg(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<List<CategoryModel>> getMoreEconomicCategories() async {
    final QueryBuilder<ParseObject> queryBuilder = QueryBuilder(ParseObject(keyCategoryTable))
      ..orderByAscending(keyMonthSpents);

    queryBuilder.whereEqualTo(keyUserId, auth.user.id);

    final ParseResponse response = await queryBuilder.query();
    if (response.success) {
      return response.results
          .map((e) => CategoryModel().mapParseToCategory(e))
          .toList();
    } else {
      DialogMessage.errorMsg(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<List<CategoryModel>> updateMonthSpentCategory(
      {String categoryId, double spent}) async {
    final QueryBuilder<ParseObject> queryBuilder = QueryBuilder(ParseObject(keyCategoryTable));
    queryBuilder.whereEqualTo(keyObjectId, categoryId);

    final ParseResponse response = await queryBuilder.query();
    if (response.success) {
      final List category = response.results;
      final ParseObject categoryObject = ParseObject(keyCategoryTable);
      if (category.first[keyMonthSpents] == null) {
        category.first[keyMonthSpents] = [
          {'month': DateTime.now().month, 'totalValue': 0.0}
        ];
      }
      final currentMonthIdx = category.first[keyMonthSpents]
          .indexWhere((c) => c['month'] == DateTime.now().month);
      if (currentMonthIdx != -1) {
        final currentMonthSpents =
            category.first[keyMonthSpents][currentMonthIdx];
        currentMonthSpents['totalValue'] =
            currentMonthSpents['totalValue'] != null
                ? currentMonthSpents['totalValue'] + spent
                : spent;
      } else {
        category.first['monthSpents'].add(CardMonthSpentsModel(
                month: DateTime.now().month, totalValue: (spent))
            .toJson());
      }
      categoryObject.set<String>(keyObjectId, categoryId);
      categoryObject.set<String>(keyUserId, auth.user.id);
      categoryObject.set<List>(keyMonthSpents, category.first['monthSpents']);
      final ParseResponse res = await categoryObject.save();
      if (!res.success) {
        return Future.error(ParseErrors.getDescription(response.error.code));
      } else {
        return [];
      }
    } else {
      DialogMessage.errorMsg(ParseErrors.getDescription(response.error.code));
    }
  }
}
