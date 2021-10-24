import 'package:cash_control/models/MonthModel.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class MonthTile extends StatelessWidget {
  final MonthModel month;
  final bool isCurrentMonth;
  const MonthTile({Key key, this.month, this.isCurrentMonth});

  @override
  Widget build(BuildContext context) {
    return ContainerPlus(
      height: 20,
      radius: RadiusPlus.all(50),
      padding: EdgeInsets.all(10),
      color: isCurrentMonth ? ColorsUtil.verdeEscuro : ColorsUtil.bg,
      child: TextPlus(
        isCurrentMonth ? 'Este mês' : month.month.capitalizeFirstWord,
        fontWeight: FontWeight.w800,
        color: isCurrentMonth
            ? ColorsUtil.verdeSecundario
            : ColorsUtil.verdeEscuro,
        fontSize: 15,
      ),
    );
  }
}
