import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class SecondStepScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.verdeEscuro,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ContainerPlus(
      width: 350,
      padding: EdgeInsets.only(top: 170),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildTxt(),
          SizedBox(height: 80),
          ContainerPlus(
              alignment: Alignment.centerRight,
              child: Image.asset(
                'assets/images/mountain.png',
                height: 220,
              ))
        ],
      ),
    );
  }

  Widget _buildTxt() {
    return ContainerPlus(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextPlus(
            'Defina meta de gastos para as categorias e cartões melhorando o controle sobre suas finanças',
            fontSize: 24,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.w900,
            wordSpacing: 4,
            color: ColorsUtil.verdeSecundario,
          ),
        ],
      ),
    );
  }
}
