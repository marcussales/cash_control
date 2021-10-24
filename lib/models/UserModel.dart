// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:cash_control/models/UserSavingsModel.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel(
      {this.displayName,
      this.email,
      this.id,
      this.photoUrl,
      this.newUser,
      this.monthIncome,
      this.savings,
      this.spentGoal});

  String displayName;
  String email;
  String id;
  String photoUrl;
  bool newUser;
  double spentGoal;
  double monthIncome;
  List<dynamic> savings;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        displayName: json["displayName"],
        email: json["email"],
        id: json["id"],
        photoUrl: json["photoUrl"],
        newUser: json["newUser"],
        spentGoal: json["spentGoal"],
        monthIncome: json["monthIncome"],
        savings: json["savings"],
      );

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "email": email,
        "id": id,
        "photoUrl": photoUrl,
        "newUser": newUser,
        "spentGoal": spentGoal,
        "monthIncome": monthIncome,
        "savings": savings,
      };
}
