// To parse this JSON data, do
//
//     final spentModel = spentModelFromJson(jsonString);

import 'dart:convert';

import 'CardModel.dart';

SpentModel spentModelFromJson(String str) =>
    SpentModel.fromJson(json.decode(str));

String spentModelToJson(SpentModel data) => json.encode(data.toJson());

class SpentModel {
  SpentModel(
      {this.spentTitle,
      this.spentId,
      this.spentDate,
      this.amount,
      this.categoryId,
      this.paymentForm,
      this.card,
      this.monthSpent});

  String spentTitle;
  String spentId;
  DateTime spentDate;
  String amount;
  String categoryId;
  dynamic card;
  dynamic paymentForm;
  int monthSpent;
  factory SpentModel.fromJson(Map<String, dynamic> json) => SpentModel(
      spentTitle: json["spentTitle"],
      spentId: json["spentId"],
      spentDate: json["spentDate"],
      amount: json["amount"],
      categoryId: json["categoryId"],
      card: json["card"],
      paymentForm: json["paymentForm"],
      monthSpent: json["monthSpent"]);

  Map<String, dynamic> toJson() => {
        "spentTitle": spentTitle,
        "spentId": spentId,
        "spentDate": spentDate,
        "amount": amount,
        "categoryId": categoryId,
        "card": card,
        "monthSpent": monthSpent,
        "paymentForm": paymentForm,
      };
}
