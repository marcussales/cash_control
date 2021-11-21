import 'package:cash_control/shared/global.dart';
import 'package:cash_control/widgets/category_tile.dart';
import 'package:cash_control/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    categoryController.getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Categorias'),
        body: ContainerPlus(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: Observer(builder: (_) {
              return GridView.builder(
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
                  });
            })));
  }
}
