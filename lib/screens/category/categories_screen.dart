import 'package:cash_control/shared/global.dart';
import 'package:cash_control/widget/category_tile.dart';
import 'package:cash_control/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Categorias'),
      body: ContainerPlus(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 160,
                childAspectRatio: 3 / 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: categoryController.categoriesList.length,
            itemBuilder: (BuildContext ctx, index) {
              return CategoryTile(
                category: categoryController.categoriesList[index],
                hasItens: categoryController.categoriesList.length == 0,
                callbackSelectItem: (item) => null,
                isSelectedItem: (item) => false,
              );
            }),
      ),
    );
  }
}
