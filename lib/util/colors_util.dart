import 'dart:ui';

import 'package:flutter/material.dart';

class ColorsUtil {
  static final verdeEscuro = getColorByHex('#004751');
  static final verdeSucesso = getColorByHex('#4BDE5A');
  static final verdeSecundario = getColorByHex('#E8F44A');
  static final verdeSecundarioGradient = getColorByHex('#006E7D');
  static final verdeClaro = getColorByHex('#067989');
  static final vermelho = getColorByHex('#EC0000');
  static final vermelhoEscuro = getColorByHex('#C20000');
  static final bg = getColorByHex('#FBFBFB');
  static final amareloClaro = getColorByHex('#F5F5EA');
  static final cinza = getColorByHex('#A09D9D');
  static final cinzaEsverdiado = getColorByHex('#EDEDED');
  static final verdeAcinzentado = getColorByHex('#C5E6EB');
  static final cinzaClaro = getColorByHex('#C1C1C1');
  static final cinzaClaroGradient = getColorByHex('#FAFAFA');
  static final saldoPositivoColor = getColorByHex('#5D5FEF');
  static final verdeSplashScreen = getColorByHex('#9CB6BA');
  static final cinzaSplashScreen = getColorByHex('#E3E7E8');
  static final azulClaro = getColorByHex('#0EBBD3');

  static Color getColorByHex(String hex) {
    return Color(int.parse("0xFF${hex.replaceAll('#', '')}"));
  }
}
