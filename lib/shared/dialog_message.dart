import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class DialogMessage {
  // ignore: public_member_api_docs
  static SnackBarPlus showMessageRequiredFields() {
    errorMsg('Preencha os campos obrigatórios');
  }

  // ignore: public_member_api_docs
  static SnackBarPlus errorMsg(String title) {
    // ignore: lines_longer_than_80_chars
    showMessage(title: title, bgColor: ColorsUtil.vermelhoEscuro);
  }

  // ignore: public_member_api_docs
  static SnackBarPlus showSucessMessage(String title) {
    // ignore: lines_longer_than_80_chars
    showMessage(
        title: title,
        messageColor: Colors.white,
        bgColor: ColorsUtil.verdeSucesso);
  }

  // ignore: public_member_api_docs
  static SnackBarPlus showMessage(
      {String title, Color messageColor, Color bgColor}) {
    dialogPlus.showDefault(
        title: 'Cash control',
        message: title ?? 'Ocorreu um erro, tente novamente',
        messageColor: messageColor ?? ColorsUtil.cinza,
        titleColor: ColorsUtil.verdeEscuro,
        barrierColor: Colors.black.withOpacity(0.4),
        buttonOneText: 'OK',
        buttonOneTextSize: 18,
        buttonOneColor: Colors.white,
        buttonOneTextColor: ColorsUtil.verdeEscuro,
        buttonOneCallback: () {
          navigatorPlus.back();
        },
        screenHorizontalMargin: 50);

    // snackBarPlus.show(
    //   backgroundColor: bgColor ?? Colors.white,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       TextPlus(
    //         title,
    //         color: txtColor ?? ColorsUtil.verdeEscuro,
    //         fontSize: 14,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ],
    //   ),
    // );
  }
}
