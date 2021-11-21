import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class MenuItemWidget extends StatefulWidget {
  final String title;
  final Icon icon;
  final int page;

  const MenuItemWidget({this.title, this.icon, this.page});

  @override
  _MenuItemWidgetState createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget> {
  @override
  Widget build(BuildContext context) {
    bool isCurrentPage = pagesStore.page == widget.page;

    return ContainerPlus(
        onTap: () {
          pagesStore.setPage(widget.page);
        },
        isExpanded: true,
        isCenter: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ContainerPlus(
              child: widget.icon,
            ),
            _buildText(isCurrentPage: isCurrentPage, title: widget.title)
          ],
        ));
  }

  Widget _buildText({bool isCurrentPage, String title}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: AnimatedDefaultTextStyle(
        child: Text(title),
        style: isCurrentPage
            ? TextStyle(
                color: ColorsUtil.verdeEscuro,
                fontSize: 13,
                fontWeight: FontWeight.w800)
            : TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.normal),
        duration: Duration(milliseconds: 450),
      ),
    );
  }
}
