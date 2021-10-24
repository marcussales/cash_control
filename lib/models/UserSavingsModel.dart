// To parse this JSON data, do
//
//     final userSavingsModel = userSavingsModelFromJson(jsonString);

import 'dart:convert';

UserSavingsModel userSavingsModelFromJson(String str) =>
    UserSavingsModel.fromJson(json.decode(str));

String userSavingsModelToJson(UserSavingsModel data) =>
    json.encode(data.toJson());

class UserSavingsModel {
  UserSavingsModel({
    this.month,
    this.savings,
  });

  int month;
  num savings;

  factory UserSavingsModel.fromJson(Map<String, dynamic> json) =>
      UserSavingsModel(
        month: json["month"],
        savings: json["savings"],
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "savings": savings,
      };
}
