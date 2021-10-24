import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class MenuItemWidget extends StatelessWidget {
  final String title;
  final Icon icon;
  final int currentPage;
  final int page;

  const MenuItemWidget({this.title, this.icon, this.currentPage, this.page});

  @override
  Widget build(BuildContext context) {
    return ContainerPlus(
        onTap: () {
          pagesStore.setPage(page);
        },
        isExpanded: true,
        isCenter: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ContainerPlus(
              child: icon,
            ),
            TextPlus(
              title,
              fontSize: currentPage == page ? 13 : 12,
              fontWeight:
                  currentPage == page ? FontWeight.w800 : FontWeight.normal,
              color: currentPage == page ? ColorsUtil.verdeEscuro : Colors.grey,
            )
          ],
        ));
  }
}
