// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'dart:io';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

IconModel userModelFromJson(String str) => IconModel.fromJson(json.decode(str));

String userModelToJson(IconModel data) => json.encode(data.toJson());

class IconModel {
  IconModel({
    this.name,
    this.icon,
  });

  String name;
  String icon;

  factory IconModel.fromJson(Map<String, dynamic> json) => IconModel(
        name: json["name"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "icon": icon,
      };
}
