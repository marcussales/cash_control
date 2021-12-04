import 'package:cash_control/controllers/category_controller.dart';
import 'package:cash_control/models/CategoryModel.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/widgets/category_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';

class CategoryListWidget extends StatelessWidget {
  final bool isSelectable;
  final Function(dynamic) callbackSelectItem;
  final Function(dynamic) isSelectedItem;
  final CategoryModel category;

  const CategoryListWidget(
      {Key key,
      this.isSelectable = false,
      this.callbackSelectItem,
      this.isSelectedItem,
      this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      List<CategoryModel> categories = categoryController.categoriesList;
      return ContainerPlus(
        height: 115,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:
              isSelectable && categories.length < 10 ? categories.length : 10,
          itemBuilder: (_, int index) {
            return CategoryTile(
                isSelectable: isSelectable,
                callbackSelectItem: callbackSelectItem,
                isSelectedItem: isSelectedItem,
                category: categories[index],
                hasItens: categories.length == 0);
          },
        ),
      );
    });
  }
}
