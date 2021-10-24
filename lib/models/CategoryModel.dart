// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:cash_control/shared/table_keys.dart';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.objectId,
    this.title,
    this.spentsGoal,
    this.icon,
    this.monthSpents,
  });

  String title;
  String spentsGoal;
  String icon;
  List<dynamic> monthSpents;
  String objectId;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        objectId: json["objectId"],
        title: json["title"],
        spentsGoal: json["spents_goal"],
        icon: json["icon"],
        monthSpents: json["month_spents"],
      );

  Map<String, dynamic> toJson() => {
        "objectId": objectId,
        "title": title,
        "spents_goal": spentsGoal,
        "icon": icon,
        "month_spents": monthSpents,
      };

  CategoryModel mapItemToCategoryModel(item) {
    return CategoryModel(
        objectId: item.objectId ?? '', title: item.title, icon: item.icon);
  }

  CategoryModel mapParseToCategory(category) {
    return CategoryModel(
        objectId: category.get(keyObjectId),
        title: category.get(keyCategoryTitle),
        icon: category.get(keyCategoryIcon),
        monthSpents: category.get(keyMonthSpents) != null
            ? category.get(keyMonthSpents)
            : [],
        spentsGoal: category.get(keyCategorySpentGoal));
  }
}
