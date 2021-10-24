import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widget/menu/menu_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class BottomMenuWidget extends StatelessWidget {
  final double size = 11.5;
  final currentPage = pagesStore.page;
  @override
  Widget build(BuildContext context) {
    return ContainerPlus(
      shadows: [
        ShadowPlus(
          color: ColorsUtil.verdeEscuro,
          moveDown: -3,
          moveRight: -1,
          blur: 5,
          spread: 0.2,
          opacity: 0.2,
        ),
      ],
      radius: RadiusPlus.all(20),
      height: 60,
      child: BottomAppBar(
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MenuItemWidget(
                title: 'Home',
                icon: Icon(
                  Icons.home,
                  color: iconColor(0),
                  size: 25,
                ),
                currentPage: pagesStore.page,
                page: 0),
            MenuItemWidget(
                title: 'Meus cartões',
                icon: Icon(Icons.credit_card, color: iconColor(1), size: 25),
                currentPage: pagesStore.page,
                page: 1),
            ContainerPlus(
              isCircle: true,
              margin: EdgeInsets.only(top: 2),
              color: ColorsUtil.verdeSecundario,
              border: BorderPlus(color: ColorsUtil.verdeEscuro, width: 1),
              child: IconButton(
                icon: Icon(
                  Icons.request_quote_outlined,
                  size: 32,
                  color: ColorsUtil.verdeEscuro,
                ),
                onPressed: () {
                  pagesStore.setPage(2);
                },
              ),
            ),
            MenuItemWidget(
                title: 'Meus gastos',
                icon: Icon(
                  Icons.how_to_vote,
                  color: iconColor(3),
                  size: 25,
                ),
                currentPage: pagesStore.page,
                page: 3),
            MenuItemWidget(
                title: 'Perfil',
                icon: Icon(
                  Icons.person_outline,
                  color: iconColor(4),
                  size: 25,
                ),
                currentPage: pagesStore.page,
                page: 4)
          ],
        ),
      ),
    );
  }

  Color iconColor(int page) {
    return pagesStore.page == page ? ColorsUtil.verdeEscuro : ColorsUtil.cinza;
  }
}
