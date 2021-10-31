import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class SnackBarMessage {
  showMessageRequiredFields() {
    errorMsg('Preencha os campos obrigatórios');
  }

  errorMsg(String title) {
    showMessage(title: title, bgColor: ColorsUtil.vermelhoEscuro);
  }

  showSucessMessage(String title) {
    showMessage(title: title, bgColor: ColorsUtil.verdeSucesso);
  }

  showMessage({String title, Color txtColor, Color bgColor}) {
    snackBarPlus.show(
      backgroundColor: bgColor ?? Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextPlus(
            title,
            color: txtColor ?? ColorsUtil.verdeEscuro,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

}
