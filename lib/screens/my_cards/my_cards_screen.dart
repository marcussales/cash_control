import 'package:cash_control/controllers/card_controller.dart';
import 'package:cash_control/screens/my_cards/components/card_tile.dart';
import 'package:cash_control/screens/my_cards/new_card_screen.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widget/button_widget.dart';
import 'package:cash_control/widget/custom_app_bar.dart';
import 'package:cash_control/widget/no_result_widget.dart';
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
        navigatorPlus.show(NewCardScreen(cardController: cardController));
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
      children: [
        NoResultWidget(message: 'Você ainda não possui cartões registrados'),
        SizedBox(height: 40),
        ButtonWidget(
          text: 'REGISTRAR NOVO CARTÃO',
          onPressed: () => navigatorPlus.show(NewCardScreen()),
        )
      ],
    );
  }

  Widget _buildCardList() {
    return ListView.separated(
      separatorBuilder: (_, __) {
        return Divider(
          height: 0.1,
          color: ColorsUtil.verdeEscuro,
        );
      },
      itemCount: cardController.cards.length,
      itemBuilder: (_, index) {
        return CardTile(
            card: cardController.cards[index], controller: cardController);
      },
    );
  }
}
