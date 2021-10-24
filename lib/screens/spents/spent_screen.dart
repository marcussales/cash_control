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
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:cash_control/util/extensions.dart';

class SpentScreen extends StatefulWidget {
  final SpentModel spent;
  final SpentController controller;

  const SpentScreen({this.spent, this.controller});
  @override
  _SpentScreenState createState() => _SpentScreenState();
}

class _SpentScreenState extends State<SpentScreen> {
  final CardController _cardController = CardController();
  SpentController _spentController;
  final TextEditingController txtTitleController = TextEditingController();
  final TextEditingController txtDateController =
      TextEditingController(text: DateTime.now().formattedDate());
  final TextEditingController txtValorController = TextEditingController();
  CategoryModel categorySpent = CategoryModel();
  CardModel cardSpent = CardModel();
  bool confirmSpent = false;

  @override
  void initState() {
    _spentController =
        widget.controller != null ? widget.controller : spentController;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _cardController.getCards();
      await categoryController.getCategories();
      categoryController.resetSelectedCategory();
      if (widget.spent != null) {
        txtTitleController.text = widget.spent.spentTitle;
        txtDateController.text = widget.spent.spentDate.formattedDate();
        txtValorController.text = widget.spent.amount;
        categorySpent.objectId = widget.spent.categoryId;
        categoryController.selectCategorySpent(categorySpent);
        cardSpent = _cardController.cards
            .firstWhere((c) => c.cardId == widget.spent.paymentForm['cardId']);
        widget.controller.selectCardSpent(cardSpent);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: widget.spent != null ? 'Editar gasto' : 'Novo gasto',
          showBackButton: pagesStore.page != Pages.NEW_SPENT.index,
          showAction: widget.spent != null,
          actionIcon: Icons.delete_forever,
          callback: () {
            dialogPlus.show(
              child: DeleteSpentDialog(
                  spent: widget.spent,
                  spentController: _spentController,
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
        ),
        body: SingleChildScrollView(
          child: ContainerPlus(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: Observer(builder: (_) {
              return _buildBody();
            }),
          ),
        ));
  }

  Widget _buildBody() {
    if (!spentController.canRegisterSpent()) {
      return Container(
          child: Column(children: [
        NoResultWidget(message: spentController.cantRegisterSpentMessage()),
        SizedBox(height: 50),
        Row(
          children: [
            spentController.hasCards()
                ? Expanded(
                    child: ContainerPlus(
                      skeleton:
                          SkeletonPlus.automatic(enabled: loading.isLoading),
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
                : SizedBox.shrink(),
            SizedBox(width: 10),
            spentController.hasCategories()
                ? Expanded(
                    child: ContainerPlus(
                      skeleton:
                          SkeletonPlus.automatic(enabled: loading.isLoading),
                      radius: RadiusPlus.all(15),
                      child: ButtonWidget(
                          text: 'Registrar categoria',
                          onPressed: () {
                            navigatorPlus.show(NewCategoryScreen());
                          }),
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
      ]));
    }

    return Container(
      child: Column(
        children: [
          FormFieldWidget(
            title: 'Titulo do gasto',
            controller: txtTitleController,
          ),
          SizedBox(height: 25),
          Row(
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
          ),
          SizedBox(height: 25),
          Column(
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
          ),
          SizedBox(height: 25),
          CardListWidget(
            cards: _cardController.cards,
            isSelectable: true,
            controller: _cardController,
            spentController: _spentController,
          ),
          SizedBox(height: 80),
          ButtonWidget(
            text: 'REGISTRAR GASTO',
            onPressed: _registerSpent,
          )
        ],
      ),
    );
  }

  _registerSpent() async {
    var formatedAmount = double.parse(
        txtValorController.text.replaceFirst('.', '').replaceAll(',', '.'));

    _spentController.cardSpent.cardBank = _cardController.banks
        .firstWhere((b) =>
            b.bankName.toUpperCase() ==
            _spentController.cardSpent.cardName.split('-')[1].trim())
        .bankId;

    if (txtDateController.text.isEmpty ||
        txtTitleController.text.isEmpty ||
        txtValorController.text.isEmpty ||
        categoryController.selectedCategorySpent.objectId == null ||
        _spentController.cardSpent.cardId == null) {
      SnackBarMessage().showMessageRequiredFields();
      return;
    }

    if (_spentController.cardSpent.spentGoal <
            (_spentController.cardSpent.monthSpents.totalValue +
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
        card: _spentController.cardSpent,
        categoryId: categoryController.selectedCategorySpent.objectId);
    if (widget.spent != null) newSpent.spentId = widget.spent.spentId;
    _spentController
        .updateSelectedCategory(categoryController.selectedCategorySpent);
    await _spentController.registerSpent(newSpent, registerSucess);
  }

  registerSucess() {
    SnackBarMessage().showSucessMessage('Gasto registrado com sucesso!');
    pagesStore.page != 2 ? navigatorPlus.back() : pagesStore.setPage(0);
  }
}
