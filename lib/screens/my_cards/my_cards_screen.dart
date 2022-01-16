import 'package:cash_control/controllers/card_controller.dart';
import 'package:cash_control/screens/loading/loading_screen.dart';
import 'package:cash_control/screens/my_cards/components/card_tile.dart';
import 'package:cash_control/screens/my_cards/card_screen.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widgets/button_widget.dart';
import 'package:cash_control/widgets/custom_app_bar.dart';
import 'package:cash_control/widgets/custom_refresh_indicator.widget.dart';
import 'package:cash_control/widgets/no_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';

class MyCardsScreen extends StatefulWidget {
  @override
  _MyCardsScreenState createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends State<MyCardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: ContainerPlus(
            height: 700,
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: _buildBody()),
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: 'Meus cartões',
      showAction: true,
      showBackButton: false,
      actionIcon: Icons.add,
      callback: () {
        navigatorPlus.show(CardScreen());
      },
    );
  }

  Widget _buildBody() {
    return Observer(builder: (_) {
      if (cardController.cards.length == 0) {
        return _buildNoCardArea();
      }
      return _buildCardList();
    });
  }

  Widget _buildNoCardArea() {
    return Column(
      children: <Widget>[
        NoResultWidget(message: 'Você ainda não possui cartões registrados'),
        SizedBox(height: 40),
        ButtonWidget(
          text: 'REGISTRAR NOVO CARTÃO',
          onPressed: () => navigatorPlus.show(CardScreen()),
        )
      ],
    );
  }

  Widget _buildCardList() {
    return CustomRefreshIndicator(
      onRefresh: () {
        cardController.getCards();
      },
      body: ListView.separated(
        separatorBuilder: (_, __) {
          return Divider(
            height: 0.1,
            color: ColorsUtil.verdeEscuro,
          );
        },
        itemCount: cardController.cards.length,
        itemBuilder: (_, index) {
          return CardTile(card: cardController.cards[index]);
        },
      ),
    );
  }
}
