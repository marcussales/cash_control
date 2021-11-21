import 'package:cash_control/base/base_screen.dart';
import 'package:cash_control/controllers/card_controller.dart';
import 'package:cash_control/models/BankModel.dart';
import 'package:cash_control/models/CardModel.dart';
import 'package:cash_control/models/ComboBoxItemModel.dart';
import 'package:cash_control/screens/loading/loading_screen.dart';
import 'package:cash_control/screens/my_cards/my_cards_screen.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/shared/dialog_message.dart';
import 'package:cash_control/shared/utils.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widgets/button_widget.dart';
import 'package:cash_control/widgets/combo_box_widget.dart';
import 'package:cash_control/widgets/custom_app_bar.dart';
import 'package:cash_control/widgets/form_field_widget.dart';
import 'package:cash_control/widgets/save_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:cash_control/util/extensions.dart';

class CardScreen extends StatefulWidget {
  final CardModel card;

  const CardScreen({Key key, this.card}) : super(key: key);

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  TextEditingController txtName = new TextEditingController();
  TextEditingController txtSpentGoal = new TextEditingController(text: '0.00');
  String nomeImpresso = '';

  @override
  void initState() {
    cardController.resetSelecteds();
    // setData();
    super.initState();
  }

  setData() {
    CardModel card = widget.card;
    if (card == null) {
      return;
    }
    card.cardType = card.cardName.split('-')[0].trim();
    card.cardTypeId = card.cardType != 'DÉBITO' ? 0 : 1;
    BankModel bank = BankModel(
        bankName: card.cardName.split('-')[1].trim(), bankId: card.cardBank);
    cardController.selectBank(bank);
    cardController.selectCard(card);
    txtName.text = card.ownerName;
    txtSpentGoal.text = card.spentGoal.formattedMoneyBr(withoutSymbol: true);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      key: Key('NewCardScreen'),
      body: Scaffold(
        appBar: CustomAppBar(
            title: widget.card == null ? 'Registrar cartão' : 'Editar cartão'),
        body: SingleChildScrollView(
          child: ContainerPlus(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: _buildBody()),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        _buildCardArea(),
        SizedBox(height: 30),
        _buildForm(),
      ],
    );
  }

  ContainerPlus _buildCardArea() {
    return ContainerPlus(
      shadows: <ShadowPlus>[
        ShadowPlus(
          color: ColorsUtil.verdeEscuro,
          blur: 6.0,
          spread: 1.5,
          moveDown: 8.5,
          opacity: 0.3,
        )
      ],
      padding: const EdgeInsets.all(20),
      radius: RadiusPlus.all(10),
      width: 320,
      height: 200,
      gradient: GradientPlus.linear(
        colors: <Color>[
          ColorsUtil.verdeEscuro,
          ColorsUtil.verdeSecundarioGradient,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomCenter,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Observer(builder: (_) {
                return TextPlus(cardController.selectedBank.bankName ?? '',
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
              children: <Widget>[
                _buildNameOrTypeArea('Nome', txtName.text.toUpperCase()),
                _buildNameOrTypeArea(
                    'Tipo', cardController.selectedCard.cardType)
              ],
            );
          })
        ],
      ),
    );
  }

  Widget _buildDefaultSpace() {
    return SizedBox(height: 20);
  }

  Widget _buildNameOrTypeArea(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
      children: <Widget>[
        widget.card == null
            ? Column(
                children: [
                  FormFieldWidget(
                    title: 'Nome impresso no cartão',
                    controller: txtName,
                    isUpperCase: true,
                    callbackOnChanged: (String value) {
                      setState(() {
                        nomeImpresso = value;
                      });
                    },
                  ),
                  _buildDefaultSpace(),
                  Row(
                    children: <Widget>[
                      _buildTypeArea(),
                      SizedBox(width: 8),
                      _buildBankArea(),
                    ],
                  ),
                  _buildDefaultSpace(),
                ],
              )
            : SizedBox.shrink(),
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
          list: cardController.typeCards
              .map((c) => ComboBoxItemModel(
                  title: c.cardType, objectId: c.cardTypeId.toString()))
              .toList(),
          selectedItem: cardController.selectedCard.cardType ?? '',
          callbackSelectItem: (item) {
            cardController.selectCard(cardController.mapToCardModel(item));
          },
          isSelectedItem: (card) {
            return cardController.isSelectedCard(card);
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
          list: cardController.banks
              .map((BankModel c) => ComboBoxItemModel(
                  title: c.bankName, objectId: c.bankId.toString()))
              .toList(),
          selectedItem: cardController.selectedBank.bankName ?? '',
          callbackSelectItem: (item) {
            cardController.selectBank(cardController.mapToBankModel(item));
          },
          isSelectedItem: (bank) {
            return cardController.isSelectedBank(bank);
          },
        ),
      );
    });
  }

  Future<void> _registerCard() async {
    if (txtName.text.isEmpty ||
        cardController.selectedBank == null ||
        cardController.selectedCard == null) {
      DialogMessage.showMessageRequiredFields();
      return;
    }

    if (Util.checkValueIsZero(value: txtSpentGoal.text)) {
      DialogMessage.errorMsg('A meta de gasto precisa ser maior que zero');
      return;
    }

    await cardController.saveCard(
        id: widget.card.cardId,
        name: txtName.text,
        typeId: cardController.selectedCard.cardTypeId,
        bankId: cardController.selectedBank.bankId,
        spentGoal: txtSpentGoal.text.formatStringToReal(),
        callback: success);
  }

  success() {
    DialogMessage.showSucessMessage(
        'Cartão ${widget.card == null ? 'registrado' : 'editado'} com sucesso');
    navigatorPlus.back();
    pagesStore.setPage(1);
    navigatorPlus.show(BaseScreen());
  }
}
