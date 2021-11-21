import 'package:cash_control/controllers/category_controller.dart';
import 'package:cash_control/controllers/icons_controller.dart';
import 'package:cash_control/models/CategoryModel.dart';
import 'package:cash_control/screens/category/components/icons_list_widget.dart';
import 'package:cash_control/screens/loading/loading_screen.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/shared/dialog_message.dart';
import 'package:cash_control/shared/utils.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widgets/button_widget.dart';
import 'package:cash_control/widgets/custom_app_bar.dart';
import 'package:cash_control/widgets/form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:cash_control/util/extensions.dart';

class CategoryScreen extends StatefulWidget {
  final CategoryModel category;

  const CategoryScreen({Key key, this.category}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final IconsController iconsController = IconsController();
  final TextEditingController txtTitle = TextEditingController();
  final TextEditingController txtMonthSpentGoal =
      TextEditingController(text: '0.00');

  @override
  void initState() {
    super.initState();
    setData();
  }

  setData() async {
    await iconsController.getIconsList();
    CategoryModel category = widget.category;
    if (category == null) {
      return;
    }
    txtTitle.text = category.title;
    txtMonthSpentGoal.text = category.spentsGoal;
    iconsController.setCategoryIcon(category.icon);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
        key: Key('CategoryScreen'),
        body: Scaffold(
          appBar: _buildAppBar(),
          body: SingleChildScrollView(
            child: ContainerPlus(
              height: 500,
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Observer(builder: (_) {
                return _buildCategoryFields();
              }),
            ),
          ),
        ));
  }

  CustomAppBar _buildAppBar() => CustomAppBar(
        title: widget.category == null ? 'Criar categoria' : 'Editar categoria',
      );

  Widget _buildCategoryFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        FormFieldWidget(
          title: 'Titulo',
          controller: txtTitle,
        ),
        FormFieldWidget(
          title: 'Meta de gasto mensal',
          isCurrency: true,
          controller: txtMonthSpentGoal,
        ),
        IconsListWidget(controller: iconsController),
        SizedBox(height: 40),
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
    if (txtTitle.text.isEmpty || iconsController.selectedItem == -1) {
      DialogMessage.showMessageRequiredFields();
      return;
    }

    if (categoryController.checkCategoryExist(
        title: txtTitle.text, edit: widget.category != null)) {
      DialogMessage.errorMsg('Você já possui uma categoria com este nome');
      return;
    }

    if (Util.checkValueIsZero(value: txtMonthSpentGoal.text)) {
      DialogMessage.errorMsg('A meta de gasto precisa ser maior que zero');
      return;
    }

    categoryController.saveCategory(
        title: txtTitle.text,
        spentGoal: txtMonthSpentGoal.text,
        icon: iconsController.getSelectedItem(),
        id: widget.category.objectId);
  }
}
