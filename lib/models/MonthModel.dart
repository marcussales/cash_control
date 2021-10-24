// To parse this JSON data, do
//
//     final monthModel = monthModelFromJson(jsonString);

import 'dart:convert';

MonthModel monthModelFromJson(String str) =>
    MonthModel.fromJson(json.decode(str));

String monthModelToJson(MonthModel data) => json.encode(data.toJson());

class MonthModel {
  MonthModel({
    this.month,
    this.id,
  });

  String month;
  int id;

  factory MonthModel.fromJson(Map<String, dynamic> json) => MonthModel(
        month: json["month"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "id": id,
      };
}
