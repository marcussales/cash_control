import 'package:cash_control/shared/global.dart';
import 'package:cash_control/shared/dialog_message.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:mobx/mobx.dart';

class NoSignalScreen extends StatefulWidget {
  @override
  _NoSignalScreenState createState() => _NoSignalScreenState();
}

class _NoSignalScreenState extends State<NoSignalScreen> {
  @override
  void initState() {
    super.initState();
    when((_) => connectivityController.connected, () {
      Navigator.of(context).pop();
      DialogMessage.showSucessMessage('Conexão restabelecida com a intenet');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  Widget _buildBody() {
    return WillPopScope(
      onWillPop: () async => Future.value(false),
      child: SingleChildScrollView(
          child: ContainerPlus(
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/noConnection.png',
              width: 250.0,
              height: 650,
            ),
            TextPlus(
              'Sem sinal de internet',
              fontWeight: FontWeight.w800,
              fontSize: 24,
              color: ColorsUtil.verdeEscuro,
              textAlign: TextAlign.center,
            )
          ],
        ),
      )),
    );
  }
}
