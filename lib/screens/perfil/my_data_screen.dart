import 'package:cash_control/controllers/user_controller.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/shared/dialog_message.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widgets/button_widget.dart';
import 'package:cash_control/widgets/custom_app_bar.dart';
import 'package:cash_control/widgets/form_field_widget.dart';
import 'package:cash_control/widgets/profile_image_widget.dart';
import 'package:cash_control/widgets/save_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:cash_control/util/extensions.dart';

class MyDataScreen extends StatefulWidget {
  @override
  _MyDataScreenState createState() => _MyDataScreenState();
}

class _MyDataScreenState extends State<MyDataScreen> {
  TextEditingController txtMonthIncomeController = TextEditingController();
  TextEditingController txtGoalController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      txtMonthIncomeController.text =
          auth.user.monthIncome.formattedMoneyBr(withoutSymbol: true);
      txtGoalController.text =
          auth.user.spentGoal.formattedMoneyBr(withoutSymbol: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Meus dados',
      ),
      body: SingleChildScrollView(
        child: ContainerPlus(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: _buildBody()),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        ProfileImageWidget(
          height: 120,
          width: 130,
        ),
        SizedBox(height: 15),
        TextPlus(
          auth.user.displayName,
          fontSize: 25,
          fontWeight: FontWeight.w700,
          color: ColorsUtil.verdeEscuro,
        ),
        SizedBox(height: 30),
        SizedBox(height: 25),
        FormFieldWidget(
          title: 'Renda mensal',
          controller: txtMonthIncomeController,
          isCurrency: true,
          onlyNumbers: true,
        ),
        SizedBox(height: 25),
        FormFieldWidget(
          title: 'Meta de ecônomia mensal',
          isCurrency: true,
          onlyNumbers: true,
          controller: txtGoalController,
        ),
        SizedBox(height: 50),
        SaveButtonWidget(
          text: 'SALVAR DADOS',
          onPressed: () => _saveData(),
        )
      ],
    );
  }

  _saveData() async {
    if (auth.user.monthIncome.toString() == txtMonthIncomeController.text &&
        auth.user.spentGoal.toString() == txtGoalController.text) {
      DialogMessage.showMessageRequiredFields();
    }

    double formattedMonthIncome =
        double.parse(txtMonthIncomeController.text.formatStringToReal());
    String formattedGoal = txtGoalController.text.formatStringToReal();
    auth.user.spentGoal = double.parse(formattedGoal);
    await auth.saveUser(
      callback: saveSucess(),
      incomeValue: formattedMonthIncome,
    );
  }

  saveSucess() {
    DialogMessage.showSucessMessage('Dados alterados com sucesso!');
    cardController.updateCardData();
  }
}
