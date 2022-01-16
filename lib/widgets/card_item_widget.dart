import 'package:cash_control/models/CardModel.dart';
import 'package:cash_control/screens/my_cards/card_spents_screen.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:cash_control/util/extensions.dart';

class CardItemWidget extends StatelessWidget {
  final bool isSelectable;
  final Function(dynamic) callbackSelectItem;
  final Function(dynamic) isSelectedItem;
  final CardModel card;
  final double width;
  final double heigth;

  const CardItemWidget(
      {this.isSelectable,
      this.callbackSelectItem,
      this.isSelectedItem,
      this.card,
      this.width,
      this.heigth});

  @override
  Widget build(BuildContext context) {
    return _buildCardItem(card);
  }

  Widget _buildCardItem(CardModel card) {
    return Observer(builder: (_) {
      return ContainerPlus(
        skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
        onTap: () {
          if (isSelectable) {
            this.isSelectedItem(card);
            this.callbackSelectItem.call(card);
            return;
          }
          navigatorPlus.show(CardSpentsScreen(card: card));
        },
        margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
        padding: EdgeInsets.fromLTRB(18, 15, 18, 15),
        radius: RadiusPlus.all(12),
        width: width ?? 165,
        height: heigth ?? 110,
        gradient: GradientPlus.linear(
          colors: _gradientColor(card),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextPlus(card.cardName.split('-')[1].trim(),
                    fontSize: isSelectable ? 17 : 14.5,
                    fontWeight: isSelectedItem(card)
                        ? FontWeight.w700
                        : FontWeight.normal,
                    color: isSelectedItem(card)
                        ? Colors.white
                        : ColorsUtil.verdeEscuro),
                Image.asset(
                  'assets/images/cardChip.png',
                  width: 30,
                  height: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isSelectable
                    ? TextPlus(card.cardName.split('-')[0].trim(),
                        fontSize: 18,
                        fontWeight: isSelectedItem(card)
                            ? FontWeight.w700
                            : FontWeight.normal,
                        color: isSelectedItem(card)
                            ? Colors.white
                            : ColorsUtil.verdeEscuro)
                    : TextPlus(_spentValue(),
                        fontSize: 18,
                        fontWeight: isSelectedItem(card)
                            ? FontWeight.w700
                            : FontWeight.normal,
                        color: isSelectedItem(card)
                            ? Colors.white
                            : ColorsUtil.verdeEscuro)
              ],
            ),
          ],
        ),
      );
    });
  }

  List<Color> _gradientColor(CardModel card) {
    if (isSelectedItem(card) || !isSelectable)
      return [ColorsUtil.verdeEscuro, ColorsUtil.verdeSecundarioGradient];
    return [ColorsUtil.cinzaClaro, ColorsUtil.cinzaClaroGradient];
  }

  String _spentValue() {
    return card.monthSpents.totalValue > 0
        ? '${card.monthSpents.totalValue.toString().numToFormattedMoney()}'
        : '0.0'.numToFormattedMoney();
  }
}
