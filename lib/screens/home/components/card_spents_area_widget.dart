import 'package:cash_control/controllers/card_controller.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widget/card_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:intl/intl.dart';

class CardSpentsAreaWidget extends StatelessWidget {
  final CardController controller;
  CardSpentsAreaWidget({this.controller});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (controller.cards.isEmpty) {
        return SizedBox.shrink();
      }
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextPlus(
                  'Gastos em cartões (${DateFormat(DateFormat.ABBR_MONTH, 'pt_Br').format(DateTime.now()).toUpperCase()}/${DateFormat(DateFormat.YEAR, 'pt_Br').format(DateTime.now())})',
                  color: ColorsUtil.verdeEscuro,
                  fontSize: 18),
            ],
          ),
          ContainerPlus(
            height: 115,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.cards.length,
              itemBuilder: (_, index) {
                return CardItemWidget(
                    isSelectable: false,
                    callbackSelectItem: (item) {},
                    isSelectedItem: (item) => true,
                    card: controller.cards[index]);
              },
            ),
          )
        ],
      );
    });
  }
}
