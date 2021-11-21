import 'package:intl/intl.dart';

// ignore: public_member_api_docs
extension StringExtension on String {
  // ignore: public_member_api_docs
  bool isEmailValid() {
    final RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(this);
  }

  bool valueIsZero() {
    final double value = double.parse(this.toString().formatStringToReal());
    return value == 0.0;
  }

  // ignore: public_member_api_docs
  DateTime stringToDateTimeObject() {
    return DateFormat('dd/MM/yyyy').parse(this);
  }

  // ignore: public_member_api_docs
  String numToFormattedMoney({
    withoutSymbol = false,
  }) {
    final double value = double.parse(this);
    return value.formattedMoneyBr(withoutSymbol: withoutSymbol);
  }

  String formatStringToReal() {
    final String formattedStr =
        this.toString().replaceFirst('.', '').replaceAll(',', '.');
    return double.parse(formattedStr).toString();
  }
}

// ignore: public_member_api_docs
extension NumberExtension on num {
  // ignore: public_member_api_docs
  String formattedMoneyBr({withoutSymbol = false}) {
    return NumberFormat(
            withoutSymbol ? '###,##0.00' : 'R\$ ###,##0.00', 'pt-BR')
        .format(this);
  }
}

extension DateTimeExtension on DateTime {
  String formattedDate() {
    return DateFormat('dd/MM/yyyy', 'pt-BR').format(this);
  }
}
