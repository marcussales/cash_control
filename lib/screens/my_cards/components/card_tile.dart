import 'package:cash_control/controllers/card_controller.dart';
import 'package:cash_control/models/CardModel.dart';
import 'package:cash_control/screens/my_cards/card_screen.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:cash_control/util/extensions.dart';

class CardTile extends StatelessWidget {
  final CardModel card;
  final CardController controller;
  const CardTile({this.card, this.controller});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return ContainerPlus(
        onTap: () {
          navigatorPlus.show(
              CardSpentsScreen(card: this.card, controller: this.controller));
        },
        skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
        padding: EdgeInsets.fromLTRB(15, 15, 5, 15),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          _buildCard(),
          _buildDataArea(),
          ContainerPlus(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.keyboard_arrow_right_outlined,
              color: ColorsUtil.verdeClaro,
              size: 28,
            ),
          )
        ]),
      );
    });
  }

  ContainerPlus _buildCard() {
    return ContainerPlus(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 28),
      radius: RadiusPlus.all(12),
      width: 145,
      height: 90,
      gradient: GradientPlus.linear(
        colors: [
          ColorsUtil.verdeEscuro,
          ColorsUtil.verdeSecundarioGradient,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomCenter,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'assets/images/cardChip.png',
                width: 25,
                height: 25,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Observer(builder: (_) {
                return TextPlus(
                    controller.banks[card.cardBank].bankName.toUpperCase(),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white);
              }),
            ],
          ),
        ],
      ),
    );
  }

  ContainerPlus _buildDataArea() {
    return ContainerPlus(
      height: 90,
      radius: RadiusPlus.all(12),
      skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextPlus(
            card.monthSpents.totalValue != null
                ? '${card.monthSpents.totalValue.toString().numToFormattedMoney()}'
                : '${'0.00'.numToFormattedMoney()}',
            fontSize: 20,
            color: ColorsUtil.vermelhoEscuro,
            fontWeight: FontWeight.w800,
          ),
          SizedBox(height: 8),
          TextPlus(
            controller.typeCards[int.parse(card.cardType)].cardType,
            fontSize: 16,
            color: ColorsUtil.verdeEscuro,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
