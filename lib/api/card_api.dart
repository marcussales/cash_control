import 'package:cash_control/models/CardModel.dart';
import 'package:cash_control/models/CardSpentModel.dart';
import 'package:cash_control/models/SpentModel.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/shared/parse_errors.dart';
import 'package:cash_control/shared/snackbar_message.dart';
import 'package:cash_control/shared/table_keys.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CardApi {
  Future<void> saveCard(String name, int typeId, int bankId, String cardName,
      String spentGoal) async {
    try {
      final cardObject = ParseObject(keyCardTable);
      cardObject.set<String>(keyCardOwnerName, name);
      cardObject.set<String>(keyCardName, cardName);
      cardObject.set<int>(keyCardType, typeId);
      cardObject.set<int>(keyCardBank, bankId);
      cardObject.set<int>(keyCardBank, bankId);
      cardObject.set<int>(keyCardBank, bankId);
      cardObject.set<num>(keySpentGoal, double.parse(spentGoal));
      cardObject.set<String>(keyCardOwner, auth.user.id);
      cardObject.set<int>(keySpentMonth, DateTime.now().month);
      final response = await cardObject.save();
      if (!response.success) {
        return Future.error(ParseErrors.getDescription(response.error.code));
      } else {
        return;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<CardModel>> getUserCards() async {
    final queryBuilder = QueryBuilder(ParseObject(keyCardTable))
      ..orderByAscending(keyCardBank);
    queryBuilder.whereEqualTo(keyCardOwner, auth.user.id);

    final response = await queryBuilder.query();
    if (response.success) {
      if (response.results == null) {
        return [];
      }
      return response.results.map((e) => mapParseToMonthSpent(e)).toList();
    } else {
      return SnackBarMessage().errorMsg(ParseErrors.getDefaultDescription());
    }
  }

  Future<List<CardModel>> getSpentsCards() async {
    final queryBuilder = QueryBuilder(ParseObject(keyCardTable))
      ..orderByAscending(keyCardBank);
    queryBuilder.whereEqualTo(keyCardOwner, auth.user.id);

    final response = await queryBuilder.query();
    if (response.success) {
      return response.results.map((e) => mapParseToMonthSpent(e)).toList();
    } else {
      return SnackBarMessage()
          .errorMsg(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<void> updateCardMonthSpents(
      {String cardObjectId,
      double spentValue,
      int spentMonth,
      bool resetSpentsValue}) async {
    final queryBuilder = QueryBuilder(ParseObject(keyCardTable))
      ..orderByAscending(keyCardBank);
    queryBuilder.whereEqualTo(keyCardOwner, auth.user.id);
    queryBuilder.whereEqualTo(keyObjectId, cardObjectId);
    final response = await queryBuilder.query();
    if (response.success) {
      final results = response.results;
      final currentMonthIdx = results.first[keyMonthSpents]
          .indexWhere((c) => c['month'] == DateTime.now().month);
      final currentMonthSpents = currentMonthIdx != -1
          ? response.results.first[keyMonthSpents][currentMonthIdx]
          : null;

      if (currentMonthSpents != null) {
        currentMonthSpents['totalValue'] =
            currentMonthSpents['totalValue'] != null && !resetSpentsValue
                ? currentMonthSpents['totalValue'] + spentValue
                : spentValue;
      } else {
        results.first['monthSpents'].add(CardMonthSpentsModel(
                month: DateTime.now().month, totalValue: spentValue)
            .toJson());
      }
      try {
        final cardObject = ParseObject(keyCardTable);
        cardObject.objectId = cardObjectId;
        cardObject.set<bool>(keyInvoicePaid, resetSpentsValue);
        cardObject.set<List>(keyMonthSpents, results.first['monthSpents']);
        final response = await cardObject.save();
        if (!response.success) {
          return Future.error(ParseErrors.getDescription(response.error.code));
        } else {
          return;
        }
      } catch (e) {
        return SnackBarMessage().errorMsg(ParseErrors.getDefaultDescription());
      }
    } else {
      return SnackBarMessage()
          .errorMsg(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<void> removeSpentFromCard({SpentModel spent}) async {
    final queryBuilder = QueryBuilder(ParseObject(keyCardTable))
      ..orderByAscending(keyCardBank);
    queryBuilder.whereEqualTo(keyCardOwner, auth.user.id);
    queryBuilder.whereEqualTo(keyObjectId, spent.paymentForm['cardId']);
    final response = await queryBuilder.query();
    if (response.success) {
      final cards = response.results.map((c) => mapParseToCard(c));

      final currentMonthIdx = cards.first.monthSpents
          .indexWhere((c) => c['month'] == spent.spentDate.month);

      cards.first.monthSpents[currentMonthIdx]['totalValue'] =
          cards.first.monthSpents[currentMonthIdx]['totalValue'] -
              double.parse(spent.amount);

      try {
        final cardObject = ParseObject(keyCardTable);
        cardObject.objectId = spent.paymentForm['cardId'];
        cardObject.set<dynamic>(keyMonthSpents, cards.first.monthSpents);
        final response = await cardObject.save();
        if (!response.success) {
          return Future.error(ParseErrors.getDescription(response.error.code));
        } else {
          return;
        }
      } catch (e) {
        return SnackBarMessage()
            .errorMsg(ParseErrors.getDescription(response.error.code));
      }
    } else {
      return SnackBarMessage()
          .errorMsg(ParseErrors.getDescription(response.error.code));
    }
  }

  CardModel mapParseToMonthSpent(card) {
    var currentMonthSpents = card
        .get(keyMonthSpents)
        .where((c) => c['month'] == DateTime.now().month);
    return CardModel(
        cardType: card.get(keyCardType).toString(),
        cardBank: card.get(keyCardBank),
        cardName: card.get(keyCardName),
        ownerName: card.get(keyCardOwnerName),
        spentGoal: card.get(keySpentGoal),
        invoicePaid: card.get(keyInvoicePaid),
        monthSpents: CardMonthSpentsModel(
            month: currentMonthSpents.length > 0
                ? currentMonthSpents.first['month']
                : DateTime.now().month,
            totalValue: currentMonthSpents.length > 0
                ? currentMonthSpents.first['totalValue']
                : 0.0),
        cardId: card.get(keyObjectId));
  }

  CardModel mapParseToCard(card) {
    return CardModel(
        cardType: card.get(keyCardType).toString(),
        cardBank: card.get(keyCardBank),
        cardName: card.get(keyCardName),
        ownerName: card.get(keyCardOwnerName),
        spentGoal: card.get(keySpentGoal),
        invoicePaid: card.get(keyInvoicePaid),
        monthSpents: card.get(keyMonthSpents),
        cardId: card.get(keyObjectId));
  }
}
