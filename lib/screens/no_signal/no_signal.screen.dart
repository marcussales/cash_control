import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class NoSignalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Sem sinal de internet',
          showBackButton: false,
        ),
        body: ContainerPlus(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: Column(
            children: [
              Image.asset(
                'assets/images/noConnection.png',
                width: 200.0,
                height: 600,
              ),
              TextPlus(
                'Ops... precisamos de internet para buscar suas finanças',
                fontWeight: FontWeight.w800,
                fontSize: 24,
                color: ColorsUtil.verdeEscuro,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }
}
