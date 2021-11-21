import 'package:cash_control/models/ComboBoxItemModel.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';

class ComboBoxItemWidget extends StatefulWidget {
  final ComboBoxItemModel item;
  final bool isSelectedItem;
  final Function callback;
  const ComboBoxItemWidget({this.item, this.isSelectedItem, this.callback});

  @override
  _ComboBoxItemWidgetState createState() => _ComboBoxItemWidgetState();
}

class _ComboBoxItemWidgetState extends State<ComboBoxItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return ContainerPlus(
        onTap: () {
          widget.callback.call();
        },
        margin: EdgeInsets.all(5),
        radius: RadiusPlus.all(25),
        height: 45,
        width: 500,
        color: widget.isSelectedItem
            ? ColorsUtil.verdeEscuro
            : ColorsUtil.amareloClaro,
        child: TextPlus(
          widget.item.title ?? '',
          color: widget.isSelectedItem
              ? ColorsUtil.verdeSecundario
              : ColorsUtil.verdeEscuro,
          fontSize: 18,
          isCenter: true,
          fontWeight:
              widget.isSelectedItem ? FontWeight.w800 : FontWeight.normal,
        ),
      );
    });
  }
}
