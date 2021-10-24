// To parse this JSON data, do
//
//     final comboBoxItemModel = comboBoxItemModelFromJson(jsonString);

import 'dart:convert';

ComboBoxItemModel comboBoxItemModelFromJson(String str) =>
    ComboBoxItemModel.fromJson(json.decode(str));

String comboBoxItemModelToJson(ComboBoxItemModel data) =>
    json.encode(data.toJson());

class ComboBoxItemModel {
  ComboBoxItemModel({
    this.title,
    this.objectId,
    this.icon,
  });

  String title;
  String objectId;
  String icon;

  factory ComboBoxItemModel.fromJson(Map<String, dynamic> json) =>
      ComboBoxItemModel(
        title: json["title"],
        objectId: json["objectId"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "objectId": objectId,
        "icon": icon,
      };
  ComboBoxItemModel mapItemToComboBoxItem(item) {
    return ComboBoxItemModel(
      objectId: item.objectId ?? '',
      title: item.title,
      icon: item.icon,
    );
  }
}
