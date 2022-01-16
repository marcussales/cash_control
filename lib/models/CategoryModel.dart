// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:cash_control/shared/table_keys.dart';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  // ignore: public_member_api_docs
  CategoryModel({
    this.objectId,
    this.title,
    this.spentsGoal,
    this.icon,
    this.monthSpents,
    this.currentMonthSpent,
  });

  String title;
  String spentsGoal;
  String icon;
  List<dynamic> monthSpents;
  String objectId;
  num currentMonthSpent;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        objectId: json["objectId"],
        title: json["title"],
        spentsGoal: json["spents_goal"],
        icon: json["icon"],
        monthSpents: json["month_spents"],
        currentMonthSpent: json["currentMonthSpent"],
      );

  Map<String, dynamic> toJson() => {
        "objectId": objectId,
        "title": title,
        "spents_goal": spentsGoal,
        "icon": icon,
        "month_spents": monthSpents,
        "currentMonthSpent": currentMonthSpent,
      };

  // ignore: public_member_api_docs
  CategoryModel mapItemToCategoryModel(item) {
    return CategoryModel(
        objectId: item.objectId ?? '', title: item.title, icon: item.icon);
  }

  // ignore: public_member_api_docs
  CategoryModel mapParseToCategory(category) {
    return CategoryModel(
        objectId: category.get(keyObjectId),
        title: category.get(keyCategoryTitle),
        icon: category.get(keyCategoryIcon),
        currentMonthSpent: category.get(keyCurrentMonthSpent),
        monthSpents: category.get(keyMonthSpents) != null
            ? category.get(keyMonthSpents)
            : [],
        spentsGoal: category.get(keyCategorySpentGoal));
  }
}
