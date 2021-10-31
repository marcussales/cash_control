import 'package:cash_control/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class SaveButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final String text;
  const SaveButtonWidget({this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return ContainerPlus(
        width: 500,
        child: ButtonWidget(
          onPressed: onPressed,
          text: text ?? 'SALVAR',
        ));
  }
}
