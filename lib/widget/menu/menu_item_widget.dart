import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class MenuItemWidget extends StatelessWidget {
  final String title;
  final Icon icon;
  final int page;

  const MenuItemWidget({this.title, this.icon, this.page});

  @override
  Widget build(BuildContext context) {
    bool isCurrentPage = pagesStore.page == page;
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
              fontSize: isCurrentPage ? 13 : 12,
              fontWeight: isCurrentPage ? FontWeight.w800 : FontWeight.normal,
              color: isCurrentPage ? ColorsUtil.verdeEscuro : Colors.grey,
            )
          ],
        ));
  }
}
