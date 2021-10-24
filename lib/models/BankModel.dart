// To parse this JSON data, do
//
//     final bankModel = bankModelFromJson(jsonString);

import 'dart:convert';

BankModel bankModelFromJson(String str) => BankModel.fromJson(json.decode(str));

String bankModelToJson(BankModel data) => json.encode(data.toJson());

class BankModel {
  BankModel({
    this.bankName,
    this.bankId,
  });

  String bankName;
  int bankId;

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        bankName: json["bankName"],
        bankId: json["bankId"],
      );

  Map<String, dynamic> toJson() => {
        "bankName": bankName,
        "bankId": bankId,
      };
}
