// To parse this JSON data, do
//
//     final cardModel = cardModelFromJson(jsonString);

import 'dart:convert';

CardModel cardModelFromJson(String str) => CardModel.fromJson(json.decode(str));

String cardModelToJson(CardModel data) => json.encode(data.toJson());

class CardModel {
  CardModel(
      {this.cardType,
      this.cardTypeId,
      this.cardBank,
      this.cardId,
      this.monthSpents,
      this.ownerName,
      this.invoicePaid,
      this.spentGoal,
      this.cardName});

  String cardType;
  String cardName;
  int cardTypeId;
  int cardBank;
  String cardId;
  String ownerName;
  dynamic monthSpents;
  bool invoicePaid;
  num spentGoal;

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        cardType: json["cardType"],
        cardTypeId: json["cardTypeId"],
        cardBank: json["cardBank"],
        cardId: json["cardId"],
        cardName: json["cardName"],
        ownerName: json["ownerName"],
        monthSpents: json["monthSpents"],
        invoicePaid: json["invoicePaid"],
        spentGoal: json["spentGoal"],
      );

  Map<String, dynamic> toJson() => {
        "cardType": cardType,
        "cardTypeId": cardTypeId,
        "cardName": cardName,
        "cardBank": cardBank,
        "cardId": cardId,
        "ownerName": ownerName,
        "monthSpents": monthSpents,
        "invoicePaid": invoicePaid,
        "spentGoal": spentGoal,
      };

  CardModel mapItemToCardModel(item) {
    return CardModel(cardId: item.objectId ?? '', cardName: item.title);
  }
}
