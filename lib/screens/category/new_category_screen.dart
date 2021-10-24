import 'package:cash_control/controllers/category_controller.dart';
import 'package:cash_control/controllers/icons_controller.dart';
import 'package:cash_control/screens/category/components/icons_list_widget.dart';
import 'package:cash_control/shared/snackbar_message.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widget/button_widget.dart';
import 'package:cash_control/widget/custom_app_bar.dart';
import 'package:cash_control/widget/form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';

class NewCategoryScreen extends StatefulWidget {
  @override
  _NewCategoryScreenState createState() => _NewCategoryScreenState();
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
  final IconsController iconsController = IconsController();
  final CategoryController _categoryController = CategoryController();
  final txtTitulo = TextEditingController();
  final txtMetaGastoMensal = TextEditingController();

  @override
  void initState() {
    super.initState();
    iconsController.getIconsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Criar categoria'),
      body: SingleChildScrollView(
        child: ContainerPlus(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: Observer(builder: (_) {
            return _buildCategoryFields();
          }),
        ),
      ),
    );
  }

  Widget _buildCategoryFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormFieldWidget(
          title: 'Titulo',
          isCurrency: false,
          onlyNumbers: false,
          controller: txtTitulo,
        ),
        SizedBox(
          height: 25,
        ),
        FormFieldWidget(
          title: 'Meta de gasto mensal',
          isCurrency: true,
          onlyNumbers: true,
          controller: txtMetaGastoMensal,
        ),
        SizedBox(
          height: 25,
        ),
        TextPlus(
          'Selecione uma imagem',
          fontSize: 17,
          color: ColorsUtil.verdeEscuro,
        ),
        SizedBox(
          height: 8,
        ),
        IconsListWidget(controller: iconsController),
        SizedBox(height: 80),
        ContainerPlus(
            width: 500,
            child: ButtonWidget(
              onPressed: saveCategory,
              text: 'SALVAR',
            ))
      ],
    );
  }

  saveCategory() {
    if (txtMetaGastoMensal.text.isEmpty ||
        txtTitulo.text.isEmpty ||
        iconsController.selectedItem == -1) {
      SnackBarMessage().showMessageRequiredFields();
    }
    _categoryController.saveCategory(txtTitulo.text, txtMetaGastoMensal.text,
        iconsController.getSelectedItem(), saveSucess);
  }

  saveSucess() {
    SnackBarMessage().showSucessMessage('Categoria criada com sucesso');
    navigatorPlus.back();
  }
}
