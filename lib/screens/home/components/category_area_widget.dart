import 'package:cash_control/controllers/category_controller.dart';
import 'package:cash_control/screens/category/categories_screen.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widgets/category_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class CategoryAreaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return categoryController.categoriesList.length > 0
        ? Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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
                isSelectable: false,
                callbackSelectItem: (item) => null,
                isSelectedItem: (item) => false,
              )
            ],
          )
        : SizedBox.shrink();
  }
}
