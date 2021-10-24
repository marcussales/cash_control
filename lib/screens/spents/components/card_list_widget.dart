import 'package:cash_control/controllers/card_controller.dart';
import 'package:cash_control/controllers/spent_controller.dart';
import 'package:cash_control/models/CardModel.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widget/card_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';

class CardListWidget extends StatelessWidget {
  final List<CardModel> cards;
  final bool isSelectable;
  final CardController controller;
  final SpentController spentController;

  const CardListWidget(
      {this.cards,
      this.isSelectable = false,
      this.controller,
      this.spentController});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextPlus(
            'Selecione o cartão',
            textAlign: TextAlign.left,
            fontSize: 17,
            color: ColorsUtil.verdeEscuro,
          ),
          SizedBox(height: 8),
          ContainerPlus(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cards.length ?? 10,
              itemBuilder: (_, index) {
                return CardItemWidget(
                  card: controller.cards[index],
                  controller: controller,
                  isSelectable: isSelectable,
                  callbackSelectItem: (item) =>
                      spentController.selectCardSpent(controller.cards[index]),
                  isSelectedItem: (item) =>
                      spentController.isSelectedCard(item),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
