import 'package:cash_control/controllers/category_controller.dart';
import 'package:cash_control/screens/category/categories_screen.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widget/category_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class CategoryAreaWidget extends StatelessWidget {
  final CategoryController controller;

  const CategoryAreaWidget({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.categoriesList.length > 0
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextPlus('Gastos por categoria',
                      color: ColorsUtil.verdeEscuro, fontSize: 18),
                  ContainerPlus(
                      onTap: () => navigatorPlus.show(CategoriesScreen()),
                      child: TextPlus('Ver todas',
                          color: ColorsUtil.verdeEscuro, fontSize: 14)),
                ],
              ),
              SizedBox(height: 15),
              CategoryListWidget(
                controller: controller,
                isSelectable: false,
                callbackSelectItem: (item) => null,
                isSelectedItem: (item) => false,
              )
            ],
          )
        : SizedBox.shrink();
  }
}