import 'package:cash_control/controllers/card_controller.dart';
import 'package:cash_control/screens/spents/spent_screen.dart';
import 'package:cash_control/screens/spents_report/spents_report_screen.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/shared/dialog_message.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:cash_control/util/extensions.dart';

class FinancesAreaWidget extends StatelessWidget {
  final CardController cardController;

  const FinancesAreaWidget({Key key, this.cardController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerPlus(
      skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
      radius: RadiusPlus.all(35),
      padding: EdgeInsets.fromLTRB(20, 15, 0, 15),
      color: ColorsUtil.verdeEscuro,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          auth.user.newUser ? _buildNewSpentArea() : _buildMyFinancesArea(),
          ContainerPlus(
              child: Image.asset(
            'assets/images/piggyBank.png',
            width: 120.0,
            height: 150,
          ))
        ],
      ),
    );
  }

  Widget _buildNewSpentArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ContainerPlus(
          width: 200,
          child: TextPlus(
            'Registre seus gastos e veja suas economias mensais',
            fontSize: 22,
            color: ColorsUtil.verdeSecundario,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 15),
        ButtonPlus(
            height: 50,
            width: 220,
            radius: RadiusPlus.all(25),
            alignment: Alignment.center,
            child: TextPlus(
              'Registrar novo gasto',
              fontSize: 18,
              color: ColorsUtil.verdeSecundario,
            ),
            color: Colors.white,
            splashColor: ColorsUtil.verdeClaro,
            onPressed: () => navigatorPlus.show(SpentScreen()))
      ],
    );
  }

  Widget _buildMyFinancesArea() {
    return Observer(builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextPlus('Suas economias esse mês',
              fontSize: 18, color: ColorsUtil.verdeSecundario),
          SizedBox(height: 10),
          TextPlus(
            cardController.savingsValue.formattedMoneyBr(),
            fontSize: 30,
            color: ColorsUtil.verdeSecundario,
            fontWeight: FontWeight.w800,
          ),
        ],
      );
    });
  }
}
