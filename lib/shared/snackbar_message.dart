import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class SnackBarMessage {
  showMessageRequiredFields() {
    snackBarPlus.show(
      backgroundColor: ColorsUtil.vermelhoEscuro,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextPlus(
            'Preencha os campos obrigatórios',
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  errorMsg(String message) {
    snackBarPlus.show(
      backgroundColor: ColorsUtil.vermelhoEscuro,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextPlus(
            message,
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  showSucessMessage(String title) {
    snackBarPlus.show(
      backgroundColor: ColorsUtil.verdeSucesso,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextPlus(
            title,
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
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
