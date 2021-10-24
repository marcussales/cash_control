import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class DateFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String title;

  const DateFieldWidget({this.controller, this.title});
  @override
  _DateFieldWidgetState createState() => _DateFieldWidgetState();
}

class _DateFieldWidgetState extends State<DateFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return _dateField(context);
  }

  void _showDatePicker(context) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => ContainerPlus(
              height: 200,
              color: ColorsUtil.bg,
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (val) {
                          widget.controller.text = val.toString();
                        }),
                  ),
                ],
              ),
            ));
  }

  Widget _dateField(context) {
    return ContainerPlus(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextPlus(
          widget.title,
          fontSize: 17,
          color: ColorsUtil.verdeEscuro,
        ),
        SizedBox(height: 8),
        ContainerPlus(
            border: BorderPlus(color: ColorsUtil.verdeEscuro, width: 1.5),
            radius: RadiusPlus.all(10),
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 50,
            child: ContainerPlus(
                onTap: () {
                  _showDatePicker(context);
                },
                alignment: Alignment.centerRight,
                width: 500,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextPlus(_dateTimeToString(widget.controller.text),
                        color: ColorsUtil.verdeEscuro),
                    Icon(
                      Icons.date_range,
                      color: ColorsUtil.verdeEscuro,
                    ),
                  ],
                ))),
      ]),
    );
  }

  String _dateTimeToString(String date) {
    if (date.isEmpty) return '';
    var dt = DateTime.parse(date);
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}
