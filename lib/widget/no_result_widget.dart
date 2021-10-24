import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class NoResultWidget extends StatelessWidget {
  final String message;

  const NoResultWidget({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerPlus(
      isCenter: true,
      margin: EdgeInsets.only(top: 200),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/sad.png',
              width: 80,
              height: 80,
            ),
            SizedBox(
              height: 50,
            ),
            TextPlus(
              message ?? 'Não encontramos resultados para sua busca',
              fontSize: 22,
              textAlign: TextAlign.center,
              color: ColorsUtil.verdeEscuro,
            ),
          ]),
    );
  }
}
