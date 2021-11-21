import 'package:cash_control/controllers/card_controller.dart';
import 'package:cash_control/models/CardModel.dart';
import 'package:cash_control/screens/my_cards/card_spents_screen.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widgets/card_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:cash_control/util/extensions.dart';

class CardTile extends StatelessWidget {
  final CardModel card;
  const CardTile({this.card});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return _buildTile();
    });
  }

  ContainerPlus _buildTile() {
    return ContainerPlus(
      onTap: () {
        navigatorPlus.show(CardSpentsScreen(card: this.card));
      },
      skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
      padding: EdgeInsets.fromLTRB(15, 15, 5, 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
  }

  CardItemWidget _buildCard() {
    return CardItemWidget(
      heigth: 95,
      width: 150,
      card: card,
      isSelectable: false,
      callbackSelectItem: (item) => null,
      isSelectedItem: (item) => true,
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
                // ignore: lines_longer_than_80_chars
                ? '${card.monthSpents.totalValue.toString().numToFormattedMoney()}'
                : '${'0.00'.numToFormattedMoney()}',
            fontSize: 20,
            color: ColorsUtil.vermelhoEscuro,
            fontWeight: FontWeight.w800,
          ),
          SizedBox(height: 8),
          TextPlus(
            cardController.typeCards[int.parse(card.cardType)].cardType,
            fontSize: 16,
            color: ColorsUtil.verdeEscuro,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
