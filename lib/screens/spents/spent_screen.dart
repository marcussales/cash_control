import 'package:cash_control/controllers/card_controller.dart';
import 'package:cash_control/controllers/page_controller.dart';
import 'package:cash_control/controllers/spent_controller.dart';
import 'package:cash_control/models/CardModel.dart';
import 'package:cash_control/models/CategoryModel.dart';
import 'package:cash_control/models/SpentModel.dart';
import 'package:cash_control/screens/category/new_category_screen.dart';
import 'package:cash_control/screens/my_cards/new_card_screen.dart';
import 'package:cash_control/screens/spents/components/card_list_widget.dart';
import 'package:cash_control/screens/spents/components/confirm_spent_widget.dart';
import 'package:cash_control/screens/spents/components/delete_spent_dialog.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/shared/snackbar_message.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widget/button_widget.dart';
import 'package:cash_control/widget/category_list_widget.dart';
import 'package:cash_control/widget/custom_app_bar.dart';
import 'package:cash_control/widget/form_field_widget.dart';
import 'package:cash_control/widget/no_result_widget.dart';
import 'package:cash_control/widget/save_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:cash_control/util/extensions.dart';

class SpentScreen extends StatefulWidget {
  final SpentModel spent;

  const SpentScreen({this.spent});

  @override
  _SpentScreenState createState() => _SpentScreenState();
}

class _SpentScreenState extends State<SpentScreen> {
  final TextEditingController txtTitleController = TextEditingController();
  final TextEditingController txtDateController =
      TextEditingController(text: DateTime.now().formattedDate());
  final TextEditingController txtValorController = TextEditingController();
  CategoryModel categorySpent = CategoryModel();
  CardModel cardSpent = CardModel();
  bool confirmSpent = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => setData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: ContainerPlus(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: Observer(builder: (_) {
              return _buildBody();
            }),
          ),
        ));
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: widget.spent != null ? 'Editar gasto' : 'Novo gasto',
      showBackButton: pagesStore.page != Pages.NEW_SPENT.index,
      showAction: widget.spent != null,
      actionIcon: Icons.delete_forever,
      callback: () {
        dialogPlus.show(
          child: DeleteSpentDialog(
              spent: widget.spent,
              spentController: spentController,
              callBack: () {
                navigatorPlus.back(result: true);
                SnackBarMessage()
                    .showSucessMessage('Gasto removido com sucesso!');
              }),
          barrierColor: Colors.black.withOpacity(0.7),
          radius: RadiusPlus.all(20),
          closeKeyboardWhenOpen: true,
        );
      },
    );
  }

  setData() {
    cardController.resetSelecteds();
    spentController.selectCardSpent(null);
    categoryController.resetSelectedCategory();
    spentController.updateSelectedCategory(categorySpent);
    if (widget.spent != null) {
      txtTitleController.text = widget.spent.spentTitle;
      txtDateController.text = widget.spent.spentDate.formattedDate();
      txtValorController.text =
          widget.spent.amount.numToFormattedMoney(withoutSymbol: true);
      categorySpent.objectId = widget.spent.categoryId;
      categoryController.selectCategorySpent(categorySpent);
      cardSpent = cardController.cards
          .firstWhere((c) => c.cardId == widget.spent.paymentForm['cardId']);
      spentController.selectCardSpent(cardSpent);
    }
  }

  Widget _buildBody() {
    if (!spentController.canRegisterSpent()) {
      return _buildCantRegisterSpent();
    }
    return _buildRegisterSpentForm();
  }

  Widget _buildCantRegisterSpent() {
    return Container(
        child: Column(children: [
      NoResultWidget(message: spentController.cantRegisterSpentMessage()),
      SizedBox(height: 50),
      Row(
        children: [
          _buildRegisterCardArea(),
          SizedBox(width: 10),
          _buildRegisterCategoryArea()
        ],
      ),
    ]));
  }

  Widget _buildRegisterSpentForm() {
    return Container(
      child: Column(
        children: [
          FormFieldWidget(
            title: 'Titulo do gasto',
            controller: txtTitleController,
          ),
          SizedBox(height: 25),
          _buildDateAndValueArea(),
          SizedBox(height: 25),
          _buildCategoryArea(),
          SizedBox(height: 25),
          CardListWidget(
            cards: cardController.cards,
            isSelectable: true,
            spentController: spentController,
          ),
          SizedBox(height: 80),
          SaveButtonWidget(
            text: widget.spent == null ? 'REGISTRAR GASTO' : 'EDITAR GASTO',
            onPressed: _registerSpent,
          )
        ],
      ),
    );
  }

  Row _buildDateAndValueArea() {
    return Row(
      children: [
        Expanded(
          child: FormFieldWidget(
            title: 'Data',
            controller: txtDateController,
            mask: '##/##/####',
            onlyNumbers: true,
            isDate: true,
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: FormFieldWidget(
            title: 'Valor',
            isCurrency: true,
            onlyNumbers: true,
            controller: txtValorController,
          ),
        ),
      ],
    );
  }

  Column _buildCategoryArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextPlus(
          'Selecione a categoria',
          fontSize: 17,
          color: ColorsUtil.verdeEscuro,
        ),
        SizedBox(height: 8),
        CategoryListWidget(
          isSelectable: true,
          controller: categoryController,
          isSelectedItem: (item) {
            return categoryController.isSelectedCategory(item);
          },
          callbackSelectItem: (item) {
            categoryController.selectCategorySpent(item);
          },
        )
      ],
    );
  }

  Widget _buildRegisterCategoryArea() {
    return spentController.hasCategories()
        ? Expanded(
            child: ContainerPlus(
              skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
              radius: RadiusPlus.all(15),
              child: ButtonWidget(
                  text: 'Registrar categoria',
                  onPressed: () {
                    navigatorPlus.show(NewCategoryScreen());
                  }),
            ),
          )
        : SizedBox.shrink();
  }

  Widget _buildRegisterCardArea() {
    return spentController.hasCards()
        ? Expanded(
            child: ContainerPlus(
              skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
              radius: RadiusPlus.all(15),
              child: ButtonWidget(
                  text: 'Registrar cartão',
                  onPressed: () {
                    navigatorPlus.show(NewCardScreen(
                      cardController: cardController,
                    ));
                  }),
            ),
          )
        : SizedBox.shrink();
  }

  _registerSpent() async {
    var formatedAmount =
        double.parse(txtValorController.text.formatStringToReal());

    spentController.cardSpent.cardBank = cardController.banks
        .firstWhere((b) =>
            b.bankName.toUpperCase() ==
            spentController.cardSpent.cardName.split('-')[1].trim())
        .bankId;

    if (txtDateController.text.isEmpty ||
        txtTitleController.text.isEmpty ||
        txtValorController.text.isEmpty ||
        categoryController.selectedCategorySpent.objectId == null ||
        spentController.cardSpent.cardId == null) {
      SnackBarMessage().errorMsg('Preencha os campos obrigatórios');
      return;
    }

    if (spentController.cardSpent.spentGoal <
            (spentController.cardSpent.monthSpents.totalValue +
                formatedAmount) &&
        !confirmSpent) {
      dialogPlus.show(
        child: ConfirmSpentWidget(callBack: () {
          setState(() {
            confirmSpent = true;
          });
          _registerSpent();
        }),
        barrierColor: Colors.black.withOpacity(0.7),
        radius: RadiusPlus.all(20),
        closeKeyboardWhenOpen: true,
      );
      return;
    }

    var newSpent = new SpentModel(
        spentTitle: txtTitleController.text,
        spentDate: txtDateController.text.stringToDateTimeObject(),
        amount: formatedAmount.toString(),
        card: spentController.cardSpent,
        categoryId: categoryController.selectedCategorySpent.objectId);
    if (widget.spent != null) newSpent.spentId = widget.spent.spentId;
    spentController
        .updateSelectedCategory(categoryController.selectedCategorySpent);
    await spentController.registerSpent(newSpent, registerSucess);
  }

  registerSucess() {
    SnackBarMessage().showSucessMessage('Gasto registrado com sucesso!');
    pagesStore.page != 2 ? navigatorPlus.back() : pagesStore.setPage(0);
  }
}
