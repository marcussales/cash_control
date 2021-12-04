import 'package:cash_control/controllers/card_controller.dart';
import 'package:cash_control/controllers/page_controller.dart';
import 'package:cash_control/controllers/spent_controller.dart';
import 'package:cash_control/models/BankModel.dart';
import 'package:cash_control/models/CardModel.dart';
import 'package:cash_control/models/CategoryModel.dart';
import 'package:cash_control/models/SpentModel.dart';
import 'package:cash_control/screens/category/category_screen.dart';
import 'package:cash_control/screens/loading/loading_screen.dart';
import 'package:cash_control/screens/my_cards/card_screen.dart';
import 'package:cash_control/screens/spents/components/card_list_widget.dart';
import 'package:cash_control/screens/spents/components/confirm_spent_widget.dart';
import 'package:cash_control/screens/spents/components/delete_spent_dialog.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/shared/dialog_message.dart';
import 'package:cash_control/shared/utils.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widgets/button_widget.dart';
import 'package:cash_control/widgets/category_list_widget.dart';
import 'package:cash_control/widgets/custom_app_bar.dart';
import 'package:cash_control/widgets/form_field_widget.dart';
import 'package:cash_control/widgets/no_result_widget.dart';
import 'package:cash_control/widgets/save_button_widget.dart';
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
  final TextEditingController txtValueController =
      TextEditingController(text: '0.00');
  CategoryModel categorySpent = CategoryModel();
  CardModel cardSpent = CardModel();
  bool confirmSpent = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setData(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      key: Key('SpentScreen'),
      body: Scaffold(
          appBar: _buildAppBar(),
          body: SingleChildScrollView(
            child: ContainerPlus(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Observer(builder: (_) {
                return _buildBody();
              }),
            ),
          )),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: widget.spent != null ? 'Editar gasto' : 'Novo gasto',
      showBackButton: pagesStore.page != Pages.NEW_SPENT.index,
      showAction: widget.spent != null,
      actionIcon: Icons.delete,
      callback: () {
        dialogPlus.show(
          child: DeleteSpentDialog(
              spent: widget.spent,
              spentController: spentController,
              callBack: () {
                navigatorPlus.back(result: true);
                cardController.updateCardData();
                DialogMessage.showSucessMessage('Gasto removido com sucesso!');
              }),
          barrierColor: Colors.black.withOpacity(0.7),
          radius: RadiusPlus.all(20),
          closeKeyboardWhenOpen: true,
        );
      },
    );
  }

  setData() async {
    await categoryController.getCategories();
    cardController.resetSelecteds();
    spentController.selectCardSpent(null);
    categoryController.resetSelectedCategory();
    spentController.updateSelectedCategory(categorySpent);
    if (widget.spent != null) {
      txtTitleController.text = widget.spent.spentTitle;
      txtDateController.text = widget.spent.spentDate.formattedDate();
      txtValueController.text =
          widget.spent.amount.numToFormattedMoney(withoutSymbol: true);
      categorySpent.objectId = widget.spent.categoryId;
      categoryController.selectCategorySpent(categorySpent);
      cardSpent = cardController.cards
          // ignore: lines_longer_than_80_chars
          .firstWhere(
              (CardModel c) => c.cardId == widget.spent.paymentForm['cardId']);
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
        child: Column(children: <Widget>[
      NoResultWidget(message: spentController.cantRegisterSpentMessage()),
      SizedBox(height: 50),
      Row(
        children: <Widget>[
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
            controller: txtValueController,
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
    return !spentController.hasCategories()
        ? Expanded(
            child: ContainerPlus(
              skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
              radius: RadiusPlus.all(15),
              child: ButtonWidget(
                  text: 'Registrar categoria',
                  onPressed: () {
                    navigatorPlus.show(CategoryScreen());
                  }),
            ),
          )
        : SizedBox.shrink();
  }

  Widget _buildRegisterCardArea() {
    return !spentController.hasCards()
        ? Expanded(
            child: ContainerPlus(
              skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
              radius: RadiusPlus.all(15),
              child: ButtonWidget(
                  text: 'Registrar cartão',
                  onPressed: () {
                    navigatorPlus.show(CardScreen());
                  }),
            ),
          )
        : SizedBox.shrink();
  }

  _showConfirmRegister() {
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
  }

  _registerSpent() async {
    if (txtDateController.text.isEmpty ||
        txtTitleController.text.isEmpty ||
        txtValueController.text.isEmpty ||
        categoryController.selectedCategorySpent.objectId == null ||
        spentController.cardSpent.cardId == null) {
      DialogMessage.showMessageRequiredFields();
      return;
    }

    if (Util.checkValueIsZero(value: txtValueController.text)) {
      DialogMessage.errorMsg('O valor do gasto não pode ser zero');
      return;
    }

    double formatedAmount =
        double.parse(txtValueController.text.formatStringToReal());

    spentController.cardSpent.cardBank = cardController.banks
        .firstWhere((BankModel b) =>
            b.bankName.toUpperCase() ==
            spentController.cardSpent.cardName.split('-')[1].trim())
        .bankId;

    if (spentController.cardSpent.spentGoal <
            (spentController.cardSpent.monthSpents.totalValue +
                formatedAmount) &&
        !confirmSpent) {
      _showConfirmRegister();
      return;
    }

    SpentModel newSpent = SpentModel(
        spentTitle: txtTitleController.text,
        spentDate: txtDateController.text.stringToDateTimeObject(),
        amount: formatedAmount.toString(),
        card: spentController.cardSpent,
        categoryId: categoryController.selectedCategorySpent.objectId);
    if (widget.spent != null) {
      newSpent.spentId = widget.spent.spentId;
    }
    spentController
        .updateSelectedCategory(categoryController.selectedCategorySpent);
    await spentController.registerSpent(
      spent: newSpent,
      diffValue: _calculatedDiffAmount(formatedAmount),
    );
  }

  String _calculatedDiffAmount(double formatedAmount) {
    if (widget.spent != null) {
      return (double.parse(widget.spent.amount) - formatedAmount).toString();
    }
    return null;
  }
}
