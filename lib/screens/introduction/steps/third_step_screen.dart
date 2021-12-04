import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class ThirdStepScreen extends StatelessWidget {
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
              child: Image.asset(
            'assets/images/demo.png',
            // width: 50.0,
            height: 260,
          ))
        ],
      ),
    );
  }

  Widget _buildTxt() {
    return ContainerPlus(
      padding: EdgeInsets.only(left: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextPlus(
            'Cash Control vem para melhorar seu planejamento financeiro e colaborar com suas economias',
            fontSize: 24,
            textAlign: TextAlign.end,
            fontWeight: FontWeight.w900,
            wordSpacing: 4,
            color: ColorsUtil.verdeSecundario,
          ),
        ],
      ),
    );
  }
}
