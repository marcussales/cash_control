import 'package:cash_control/models/CategoryModel.dart';
import 'package:cash_control/models/SpentModel.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/shared/parse_errors.dart';
import 'package:cash_control/shared/table_keys.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class SpentApi {
  Future<void> saveSpent(SpentModel spent) async {
    try {
      final spentObject = ParseObject(keySpentTable);
      if (spent.spentId != null)
        spentObject.set<String>(keyObjectId, spent.spentId);
      spentObject.set<String>(keySpentTitle, spent.spentTitle);
      spentObject.set<DateTime>(keySpentDate, spent.spentDate);
      spentObject.set<int>(keySpentMonth, spent.spentDate.month);
      spentObject.set<String>(keySpentAmount, spent.amount);
      spentObject.set<String>(keySpentcategoryId, spent.categoryId);
      spentObject.set<String>(keySpentOwner, auth.user.id);
      spentObject.set<dynamic>(keyPaymentForm, spent.card);
      final response = await spentObject.save();
      if (!response.success) {
        return Future.error(ParseErrors.getDescription(response.error.code));
      } else {
        await cardController.updateCardSpents(
            cardId: spent.card.cardId,
            spentValue: double.parse(spent.amount),
            spentMonth: spent.spentDate.month);
        await categoryController.updateMonthSpent(
            id: categoryController.selectedCategorySpent.objectId,
            spent: double.parse(spent.amount));
        return;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<SpentModel>> getMonthSpents(
      {int limit, int currentMonth, String cardId}) async {
    final queryBuilder = QueryBuilder(ParseObject(keySpentTable))
      ..orderByDescending(keySpentDate);
    queryBuilder.whereEqualTo(keySpentOwner, auth.user.id);
    queryBuilder.whereEqualTo(keySpentMonth, currentMonth);
    queryBuilder.orderByDescending(keyCreatedAt);

    final response = await queryBuilder.query();
    if (response.success) {
      if (response.results == null) return [];
      if (cardId != null) {
        return response.results
            .where((c) => c['paymentForm']['cardId'] == cardId)
            .map((e) => mapParseToSpent(e))
            .toList();
      }
      return response.results.map((e) => mapParseToSpent(e)).toList();
    } else {
      throw ParseErrors.getDescription(response.error.code);
    }
  }

  Future<List<SpentModel>> getCategorySpents({CategoryModel category}) async {
    final queryBuilder = QueryBuilder(ParseObject(keySpentTable))
      ..orderByDescending(keySpentDate);
    queryBuilder.whereEqualTo(keySpentcategoryId, category.objectId);
    queryBuilder.whereEqualTo(keySpentMonth, DateTime.now());
    final response = await queryBuilder.query();
    if (response.success && response.results != null) {
      return response.results.map((e) => mapParseToSpent(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<SpentModel>> searchSpent({String search}) async {
    final queryBuilder = QueryBuilder(ParseObject(keySpentTable))
      ..orderByDescending(keySpentDate);
    queryBuilder.whereEqualTo(keySpentOwner, auth.user.id);
    queryBuilder.whereContains(keySpentTitle, search);

    final response = await queryBuilder.query();
    if (response.success) {
      if (response.results != null) {
        return response.results.map((e) => mapParseToSpent(e)).toList();
      }
      return null;
    } else {
      throw ParseErrors.getDescription(response.error.code);
    }
  }

  Future<void> delete({SpentModel spent}) async {
    try {
      final queryBuilder =
          QueryBuilder<ParseObject>(ParseObject(keySpentTable));
      queryBuilder.whereEqualTo(keySpentOwner, auth.user.id);
      queryBuilder.whereEqualTo(keyObjectId, spent.spentId);

      final response = await queryBuilder.query();

      if (response.success && response.results != null) {
        for (final s in response.results as List<ParseObject>) {
          await s.delete();
        }
      }
    } catch (e) {
      return Future.error('Falha ao excluir gasto');
    }
  }

  SpentModel mapParseToSpent(spent) {
    print(spent);
    return SpentModel(
        spentId: spent.get(keyObjectId),
        spentTitle: spent.get(keySpentTitle),
        amount: spent.get(keySpentAmount).toString().replaceAll(',', '.'),
        categoryId: spent.get(keySpentcategoryId),
        paymentForm: spent.get(keyPaymentForm),
        spentDate: spent.get(keySpentDate));
  }
}
