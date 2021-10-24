import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class ConfirmSpentWidget extends StatelessWidget {
  final Function callBack;
  ConfirmSpentWidget({this.callBack});

  @override
  Widget build(BuildContext context) {
    return ContainerPlus(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TextPlus('Confirmar registro',
              fontWeight: FontWeight.w700,
              color: ColorsUtil.verdeEscuro,
              fontSize: 18),
          SizedBox(height: 15),
          TextPlus(
              'Você ja gastou mais do que o planejado neste cartão, deseja continuar?',
              fontSize: 16,
              color: ColorsUtil.cinzaClaro),
          SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonPlus(
                child: TextPlus(
                  'Não',
                  color: ColorsUtil.verdeEscuro,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                radius: RadiusPlus.all(30),
                padding: EdgeInsets.symmetric(horizontal: 40),
                onPressed: () {
                  navigatorPlus.back();
                },
              ),
              ButtonPlus(
                child: TextPlus(
                  'Continuar',
                  color: ColorsUtil.verdeEscuro,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                radius: RadiusPlus.all(30),
                padding: EdgeInsets.symmetric(horizontal: 25),
                color: ColorsUtil.verdeSecundario,
                onPressed: () {
                  navigatorPlus.back();
                  callBack.call();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
