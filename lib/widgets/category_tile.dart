import 'package:cached_network_image/cached_network_image.dart';
import 'package:cash_control/models/CategoryModel.dart';
import 'package:cash_control/screens/category/category_details/category_details_screen.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';

class CategoryTile extends StatelessWidget {
  final CategoryModel category;
  final bool hasItens;
  final bool isSelectable;
  final Function(dynamic) callbackSelectItem;
  final Function(dynamic) isSelectedItem;

  const CategoryTile(
      {this.category,
      this.hasItens,
      this.isSelectable = false,
      this.callbackSelectItem,
      this.isSelectedItem});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return ContainerPlus(
          skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
          onTap: () {
            if (isSelectable) {
              this.isSelectedItem(this.category);
              this.callbackSelectItem.call(this.category);
              return;
            }
            navigatorPlus.show(CategoryDetailsScreen(
              category: category,
            ));
          },
          radius: RadiusPlus.all(15),
          color: isSelectedItem(this.category) && this.isSelectable
              ? ColorsUtil.verdeSecundarioGradient
              : Colors.white,
          alignment: Alignment.center,
          border: BorderPlus(
              color: ColorsUtil.verdeEscuro, width: isSelectable ? 1.5 : 0.7),
          padding: EdgeInsets.all(10),
          width: 95,
          margin: EdgeInsets.all(4),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ContainerPlus(
                  color: ColorsUtil.verdeSecundario,
                  radius: RadiusPlus.all(15),
                  padding: EdgeInsets.all(8),
                  height: 50,
                  width: 50,
                  child: CachedNetworkImage(imageUrl: category.icon),
                ),
                TextPlus(
                  category.title,
                  textOverflow: TextOverflow.ellipsis,
                  color: isSelectedItem(this.category) && this.isSelectable
                      ? ColorsUtil.verdeSecundario
                      : ColorsUtil.verdeEscuro,
                  fontSize: 15,
                  fontWeight: this.isSelectedItem(this.category)
                      ? FontWeight.w600
                      : FontWeight.normal,
                )
              ]));
    });
  }
}
