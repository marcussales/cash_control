import 'package:cash_control/controllers/user_controller.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/shared/snackbar_message.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widget/button_widget.dart';
import 'package:cash_control/widget/custom_app_bar.dart';
import 'package:cash_control/widget/form_field_widget.dart';
import 'package:cash_control/widget/profile_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:cash_control/util/extensions.dart';

class MyDataScreen extends StatefulWidget {
  @override
  _MyDataScreenState createState() => _MyDataScreenState();
}

class _MyDataScreenState extends State<MyDataScreen> {
  UserController _controller = UserController();
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
      children: [
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
        ButtonWidget(
          text: 'SALVAR DADOS',
          onPressed: () => _saveData(),
        )
      ],
    );
  }

  _saveData() async {
    if (auth.user.monthIncome.toString() == txtMonthIncomeController.text &&
        auth.user.spentGoal.toString() == txtGoalController.text) {
      SnackBarMessage().showMessageRequiredFields();
    }

    var formattedMonthIncome = double.parse(txtMonthIncomeController.text
        .replaceAll(',', '.')
        .replaceFirst('.', ''));
    var formattedGoal = double.parse(
        txtGoalController.text.replaceAll(',', '.').replaceFirst('.', ''));
    auth.user.spentGoal = formattedGoal;
    auth.user.monthIncome = formattedMonthIncome;
    await _controller.saveUser(callback: saveSucess());
  }

  saveSucess() {
    SnackBarMessage().showSucessMessage('Dados alterados com sucesso!');
  }
}
