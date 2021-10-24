import 'package:cash_control/controllers/spent_controller.dart';
import 'package:cash_control/models/SpentModel.dart';
import 'package:cash_control/screens/spents/spent_screen.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:cash_control/util/extensions.dart';

class SpentTile extends StatelessWidget {
  final SpentModel spent;
  final SpentController controller;
  const SpentTile({this.spent, this.controller});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return ContainerPlus(
          padding: EdgeInsets.fromLTRB(0, 15, 5, 15),
          onTap: () => navigatorPlus.show(SpentScreen(
                spent: spent,
                controller: controller,
              )),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              ContainerPlus(
                skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
                radius: RadiusPlus.all(10),
                color: ColorsUtil.verdeSecundario,
                width: 50,
                height: 45,
                alignment: Alignment.center,
                child: TextPlus(
                  spent.spentTitle.firstLetter.toUpperCase(),
                  fontSize: 22,
                  color: ColorsUtil.verdeEscuro,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(width: 18),
              ContainerPlus(
                skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextPlus(
                      spent.spentTitle,
                      fontSize: 18,
                      color: ColorsUtil.verdeEscuro,
                    ),
                    TextPlus(
                      '- ${formattedAmount()}',
                      fontSize: 20,
                      color: ColorsUtil.vermelhoEscuro,
                      fontWeight: FontWeight.w800,
                    ),
                  ],
                ),
              ),
            ]),
            ContainerPlus(
              skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.keyboard_arrow_right_outlined,
                color: ColorsUtil.verdeClaro,
                size: 28,
              ),
            )
          ]));
    });
  }

  String formattedAmount() {
    if (spent.amount.length <= 6) {
      return double.parse(spent.amount).formattedMoneyBr();
    }
    return double.parse(spent.amount.replaceFirst(',', '.')).formattedMoneyBr();
  }
}
