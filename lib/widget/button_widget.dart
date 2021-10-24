import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color color;
  final int padding;

  ButtonWidget({@required this.text, this.onPressed, this.color, this.padding});
  @override
  Widget build(BuildContext context) {
    return ContainerPlus(
      height: 55,
      child: ButtonPlus(
        padding: padding ?? EdgeInsets.all(10),
        onPressed: onPressed,
        color: color ?? ColorsUtil.verdeSecundario,
        splashColor: color ?? ColorsUtil.verdeClaro,
        child: TextPlus(text,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: ColorsUtil.verdeEscuro),
        radius: RadiusPlus.all(30),
      ),
    );
  }
}
