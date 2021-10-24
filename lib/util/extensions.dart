import 'package:intl/intl.dart';

extension StringExtension on String {
  isEmailValid() {
    final RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(this);
  }

  stringToDateTimeObject() {
    return DateFormat('dd/MM/yyyy').parse(this);
  }

  String numToFormattedMoney() {
    final value = double.parse(this);
    return value.formattedMoneyBr();
  }
}

extension NumberExtension on num {
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
