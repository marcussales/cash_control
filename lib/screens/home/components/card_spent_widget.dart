import 'package:cash_control/models/CardModel.dart';
import 'package:cash_control/models/SpentModel.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:cash_control/util/extensions.dart';

class CardSpent extends StatelessWidget {
  final String cardType;
  final String cardBank;
  final String cardSpents;

  CardSpent({this.cardType, this.cardBank, this.cardSpents});
  @override
  Widget build(BuildContext context) {
    return ContainerPlus(
      height: 45,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextPlus(cardBank,
                textAlign: TextAlign.left,
                color: ColorsUtil.verdeEscuro,
                fontSize: 16),
          ),
          Expanded(
            child: TextPlus(cardType,
                textAlign: TextAlign.center,
                color: ColorsUtil.verdeEscuro,
                fontSize: 16),
          ),
          Expanded(
            child: TextPlus('${this.cardSpents}'.numToFormattedMoney(),
                color: ColorsUtil.verdeEscuro,
                fontSize: 18,
                textAlign: TextAlign.right,
                fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
