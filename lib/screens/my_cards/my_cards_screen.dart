import 'package:cash_control/controllers/card_controller.dart';
import 'package:cash_control/screens/my_cards/components/card_tile.dart';
import 'package:cash_control/screens/my_cards/new_card_screen.dart';
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
  CardController _cardController = CardController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cardController.getCards();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Meus cartões',
        showAction: true,
        showBackButton: false,
        actionIcon: Icons.add,
        callback: () {
          navigatorPlus.show(NewCardScreen(cardController: _cardController));
        },
      ),
      body: SingleChildScrollView(
        child: ContainerPlus(
            height: 700,
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: _buildBody()),
      ),
    );
  }

  Widget _buildBody() {
    return Observer(builder: (_) {
      if (_cardController.cards.length == 0) {
        return Column(
          children: [
            NoResultWidget(
                message: 'Você ainda não possui cartões registrados'),
            SizedBox(height: 40),
            ButtonWidget(
              text: 'REGISTRAR NOVO CARTÃO',
              onPressed: () => navigatorPlus.show(NewCardScreen()),
            )
          ],
        );
      }
      return ListView.separated(
        separatorBuilder: (_, __) {
          return Divider(
            height: 0.1,
            color: ColorsUtil.verdeEscuro,
          );
        },
        itemCount: _cardController.cards.length,
        itemBuilder: (_, index) {
          return CardTile(
              card: _cardController.cards[index], controller: _cardController);
        },
      );
    });
  }
}
