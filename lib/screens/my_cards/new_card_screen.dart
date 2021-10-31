import 'package:cash_control/base/base_screen.dart';
import 'package:cash_control/controllers/card_controller.dart';
import 'package:cash_control/models/CardModel.dart';
import 'package:cash_control/models/ComboBoxItemModel.dart';
import 'package:cash_control/screens/my_cards/my_cards_screen.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/shared/snackbar_message.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widget/button_widget.dart';
import 'package:cash_control/widget/combo_box_widget.dart';
import 'package:cash_control/widget/custom_app_bar.dart';
import 'package:cash_control/widget/form_field_widget.dart';
import 'package:cash_control/widget/save_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:cash_control/util/extensions.dart';

class NewCardScreen extends StatefulWidget {
  final CardController cardController;

  const NewCardScreen({this.cardController});

  @override
  _NewCardScreenState createState() => _NewCardScreenState();
}

class _NewCardScreenState extends State<NewCardScreen> {
  TextEditingController txtName = new TextEditingController();
  TextEditingController txtSpentGoal = new TextEditingController();
  String nomeImpresso = '';

  @override
  void initState() {
    widget.cardController.resetSelecteds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Registrar cartão'),
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
        _buildCardArea(),
        SizedBox(height: 30),
        _buildForm(),
      ],
    );
  }

  ContainerPlus _buildCardArea() {
    return ContainerPlus(
      shadows: [
        ShadowPlus(
          color: ColorsUtil.verdeEscuro,
          blur: 6.0,
          spread: 1.5,
          moveDown: 8.5,
          opacity: 0.3,
        )
      ],
      padding: EdgeInsets.all(20),
      radius: RadiusPlus.all(10),
      width: 320,
      height: 200,
      gradient: GradientPlus.linear(
        colors: [
          ColorsUtil.verdeEscuro,
          ColorsUtil.verdeSecundarioGradient,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomCenter,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Observer(builder: (_) {
                return TextPlus(
                    widget.cardController.selectedBank.bankName ?? '',
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white);
              }),
              Image.asset(
                'assets/images/cardChip.png',
                width: 50,
                height: 50,
              )
            ],
          ),
          Observer(builder: (_) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNameOrTypeArea('Nome', txtName.text.toUpperCase()),
                _buildNameOrTypeArea(
                    'Tipo', widget.cardController.selectedCard.cardType)
              ],
            );
          })
        ],
      ),
    );
  }

  Widget _buildDefaultSpace() {
    return SizedBox(
      height: 20,
    );
  }

  Widget _buildNameOrTypeArea(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextPlus(title, color: Colors.white, fontSize: 12),
        SizedBox(
          height: 5,
        ),
        TextPlus(value,
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            textOverflow: TextOverflow.ellipsis),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        FormFieldWidget(
          title: 'Nome impresso no cartão',
          controller: txtName,
          isUpperCase: true,
          callbackOnChanged: (value) {
            setState(() {
              nomeImpresso = value;
            });
          },
        ),
        _buildDefaultSpace(),
        Row(
          children: [
            _buildTypeArea(),
            SizedBox(width: 8),
            _buildBankArea(),
          ],
        ),
        _buildDefaultSpace(),
        FormFieldWidget(
            title: 'Meta de gastos',
            controller: txtSpentGoal,
            isCurrency: true),
        SizedBox(height: 60),
        SaveButtonWidget(
          onPressed: _registerCard,
        )
      ],
    );
  }

  Widget _buildTypeArea() {
    return Observer(builder: (_) {
      return Expanded(
        child: ComboBoxWidget(
          title: 'Tipo',
          list: widget.cardController.typeCards
              .map((c) => ComboBoxItemModel(
                  title: c.cardType, objectId: c.cardTypeId.toString()))
              .toList(),
          selectedItem: widget.cardController.selectedCard.cardType ?? '',
          callbackSelectItem: (item) {
            widget.cardController
                .selectCard(widget.cardController.mapToCardModel(item));
          },
          isSelectedItem: (card) {
            return widget.cardController.isSelectedCard(card);
          },
        ),
      );
    });
  }

  Widget _buildBankArea() {
    return Observer(builder: (_) {
      return Expanded(
        child: ComboBoxWidget(
          title: 'Banco',
          list: widget.cardController.banks
              .map((c) => ComboBoxItemModel(
                  title: c.bankName, objectId: c.bankId.toString()))
              .toList(),
          selectedItem: widget.cardController.selectedBank.bankName ?? '',
          callbackSelectItem: (item) {
            widget.cardController
                .selectBank(widget.cardController.mapToBankModel(item));
          },
          isSelectedItem: (bank) {
            return widget.cardController.isSelectedBank(bank);
          },
        ),
      );
    });
  }

  Future<void> _registerCard() async {
    if (txtName.text.isEmpty ||
        widget.cardController.selectedBank == null ||
        widget.cardController.selectedCard == null ||
        txtSpentGoal.text.isEmpty) {
      SnackBarMessage().showMessageRequiredFields();
      return;
    }

    await widget.cardController.saveCard(
        txtName.text,
        widget.cardController.selectedCard.cardTypeId,
        widget.cardController.selectedBank.bankId,
        txtSpentGoal.text.formatStringToReal(),
        success);
  }

  success() {
    SnackBarMessage().showSucessMessage('Cartão registrado com sucesso');
    navigatorPlus.back();
    pagesStore.setPage(1);
    navigatorPlus.show(BaseScreen());
  }
}
