import 'package:cash_control/controllers/spent_controller.dart';
import 'package:cash_control/models/SpentModel.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class DeleteSpentDialog extends StatelessWidget {
  final SpentModel spent;
  final SpentController spentController;
  final Function callBack;
  const DeleteSpentDialog(
      {Key key, this.spent, this.spentController, this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerPlus(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TextPlus('Remover gasto',
              fontWeight: FontWeight.w700,
              color: ColorsUtil.verdeEscuro,
              fontSize: 18),
          SizedBox(height: 15),
          TextPlus('Ao remove-lo o mesmo não constará mais em seus balanços',
              fontSize: 16, color: ColorsUtil.cinzaClaro),
          SizedBox(height: 15),
          ButtonPlus(
            child: TextPlus(
              'Remover',
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
            radius: RadiusPlus.all(30),
            padding: EdgeInsets.symmetric(horizontal: 40),
            color: ColorsUtil.vermelho,
            onPressed: () {
              spentController.deleteSpent(spent);
              navigatorPlus.back();
              callBack.call();
            },
          ),
        ],
      ),
    );
  }
}
