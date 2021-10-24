// To parse this JSON data, do
//
//     final cardMonthSpentsModel = cardMonthSpentsModelFromJson(jsonString);

import 'dart:convert';

CardMonthSpentsModel cardMonthSpentsModelFromJson(String str) =>
    CardMonthSpentsModel.fromJson(json.decode(str));

String cardMonthSpentsModelToJson(CardMonthSpentsModel data) =>
    json.encode(data.toJson());

class CardMonthSpentsModel {
  CardMonthSpentsModel({
    this.month,
    this.totalValue,
  });

  int month;
  num totalValue;

  factory CardMonthSpentsModel.fromJson(Map<String, dynamic> json) =>
      CardMonthSpentsModel(
        month: json["month"],
        totalValue: json["totalValue"],
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "totalValue": totalValue,
      };
}
