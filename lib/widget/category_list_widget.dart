import 'package:cash_control/controllers/category_controller.dart';
import 'package:cash_control/models/CategoryModel.dart';
import 'package:cash_control/widget/category_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';

class CategoryListWidget extends StatelessWidget {
  final bool isSelectable;
  final Function(dynamic) callbackSelectItem;
  final Function(dynamic) isSelectedItem;
  final CategoryModel category;
  final CategoryController controller;

  const CategoryListWidget(
      {Key key,
      this.isSelectable = false,
      this.callbackSelectItem,
      this.isSelectedItem,
      this.category,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return ContainerPlus(
        height: 115,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categoriesList.length ?? 10,
          itemBuilder: (_, index) {
            return CategoryTile(
                isSelectable: isSelectable,
                callbackSelectItem: callbackSelectItem,
                isSelectedItem: isSelectedItem,
                category: controller.categoriesList[index],
                hasItens: controller.categoriesList.length == 0);
          },
        ),
      );
    });
  }
}
