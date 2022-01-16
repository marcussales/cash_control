import 'package:brasil_fields/brasil_fields.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormFieldWidget extends StatelessWidget {
  final String title;
  final bool isCurrency;
  final bool onlyNumbers;
  final String mask;
  final bool isDate;
  final bool isUpperCase;
  final Function(String) callbackOnChanged;
  final TextEditingController controller;

  FormFieldWidget(
      {this.title,
      this.isCurrency = false,
      this.onlyNumbers = false,
      this.mask,
      this.callbackOnChanged,
      this.isDate = false,
      this.controller,
      this.isUpperCase = false});

  @override
  Widget build(BuildContext context) {
    return _textField();
  }

  _getFormatters() {
    var textInputFormatters = <TextInputFormatter>[];
    if (isCurrency) {
      textInputFormatters.add(FilteringTextInputFormatter.digitsOnly);
      textInputFormatters.add(RealInputFormatter(centavos: true));
    }

    if (mask != null) {
      var maskFormatter = new MaskTextInputFormatter(
          mask: mask, filter: {"#": RegExp(r'[0-9]')});
      textInputFormatters.add(maskFormatter);
    }

    if (onlyNumbers || isCurrency) {
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
    }

    if (isUpperCase) {
      textInputFormatters.add(UpperCaseTextFormatter());
    }
    return textInputFormatters;
  }

  Widget _textField() {
    return ContainerPlus(
      skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextPlus(
              title,
              fontSize: 17,
              color: ColorsUtil.verdeEscuro,
            ),
            SizedBox(height: 8),
            ContainerPlus(
              border: BorderPlus(color: ColorsUtil.verdeEscuro, width: 1.5),
              radius: RadiusPlus.all(10),
              padding: EdgeInsets.symmetric(horizontal: 8),
              height: 50,
              child: RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (RawKeyEvent event) {
                  if (event.logicalKey == LogicalKeyboardKey.backspace &&
                      isDate) {
                    controller.text = '';
                  }
                },
                child: TextField(
                  autofocus: false,
                  cursorColor: ColorsUtil.verdeEscuro,
                  decoration: InputDecoration(
                      prefixText: isCurrency ? 'R\$' : null,
                      border: InputBorder.none,
                      suffixIcon: isDate
                          ? Icon(
                              Icons.date_range,
                              color: ColorsUtil.verdeEscuro,
                            )
                          : null),
                  inputFormatters: _getFormatters(),
                  keyboardType: onlyNumbers || isCurrency
                      ? TextInputType.number
                      : TextInputType.name,
                  style: TextStyle(
                    color: ColorsUtil.verdeEscuro,
                  ),
                  controller: controller,
                  onChanged: callbackOnChanged,
                ),
              ),
            ),
          ]),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
