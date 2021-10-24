import 'package:cash_control/models/CategoryModel.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widget/combo_box_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';

class ComboBoxWidget extends StatefulWidget {
  final String title;
  final String selectedItem;
  final List<dynamic> list;
  final Function(dynamic) callbackSelectItem;
  final Function(dynamic) isSelectedItem;
  const ComboBoxWidget(
      {this.title,
      this.list,
      this.selectedItem,
      this.callbackSelectItem,
      this.isSelectedItem});

  @override
  _ComboBoxWidgetState createState() => _ComboBoxWidgetState();
}

class _ComboBoxWidgetState extends State<ComboBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return ContainerPlus(
        onTap: () {
          if (widget.list != null) _openDialog();
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextPlus(
            widget.title,
            fontSize: 17,
            color: ColorsUtil.verdeEscuro,
          ),
          SizedBox(height: 8),
          Observer(builder: (_) {
            return ContainerPlus(
              border: BorderPlus(color: ColorsUtil.verdeEscuro, width: 1.5),
              radius: RadiusPlus.all(10),
              padding: EdgeInsets.symmetric(horizontal: 8),
              height: 50,
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextPlus(
                    widget.selectedItem ?? '',
                    color: ColorsUtil.verdeEscuro,
                    fontSize: 16,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: ColorsUtil.verdeEscuro,
                  ),
                ],
              ),
              width: 500,
            );
          })
        ]));
  }

  _openDialog() {
    dialogPlus.show(
        closeKeyboardWhenOpen: true,
        radius: RadiusPlus.all(10),
        child: ContainerPlus(
          height: calcBoxHeight(list: widget.list, value: 400) + 60,
          width: 500,
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextPlus(
                widget.title,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: ColorsUtil.verdeEscuro,
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 4,
              ),
              Observer(builder: (_) {
                return ContainerPlus(
                  margin: EdgeInsets.all(0),
                  height: calcBoxHeight(list: widget.list, value: 350),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.list.length,
                    itemBuilder: (_, index) {
                      return ComboBoxItemWidget(
                          callback: () {
                            widget.callbackSelectItem(widget.list[index]);
                            navigatorPlus.back();
                          },
                          item: widget.list[index],
                          isSelectedItem:
                              widget.isSelectedItem(widget.list[index]));
                    },
                  ),
                );
              })
            ],
          ),
        ));
  }

  double calcBoxHeight({List list, int value}) {
    return (list.length >= 6 ? value : (list.length * 80)).toDouble();
  }
}
