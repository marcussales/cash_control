import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Widget body;
  final Function onRefresh;
  const CustomRefreshIndicator({this.body, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: ColorsUtil.verdeEscuro,
      color: ColorsUtil.verdeSecundario,
      displacement: 50,
      onRefresh: () async {
        await onRefresh.call();
      },
      child: body,
    );
  }
}
