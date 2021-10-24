import 'package:cash_control/controllers/card_controller.dart';
import 'package:cash_control/controllers/spent_controller.dart';
import 'package:cash_control/models/CardModel.dart';
import 'package:cash_control/screens/spents/components/spent_tile.dart';
import 'package:cash_control/shared/snackbar_message.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widget/button_widget.dart';
import 'package:cash_control/widget/custom_app_bar.dart';
import 'package:cash_control/widget/no_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:get_it/get_it.dart';

class CardSpentsScreen extends StatefulWidget {
  final CardModel card;
  final CardController controller;
  const CardSpentsScreen({this.card, this.controller});

  @override
  _CardSpentsScreenState createState() => _CardSpentsScreenState();
}

class _CardSpentsScreenState extends State<CardSpentsScreen> {
  SpentController _spentController = SpentController();
  bool invoicePaid;

  @override
  void initState() {
    _spentController.getSpents(cardId: widget.card.cardId);
    invoicePaid = widget.card.invoicePaid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Gastos por cartão',
      ),
      body: SingleChildScrollView(
        child: ContainerPlus(
            height: 1200,
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: _buildBody()),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
        children: [_builCardData(), SizedBox(height: 40), _buildSpentList()]);
  }

  ContainerPlus _builCardData() {
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
      child: ContainerPlus(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContainerPlus(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextPlus(widget.card.cardName.split('-')[1].trim(),
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                  Image.asset(
                    'assets/images/cardChip.png',
                    width: 50,
                    height: 50,
                  )
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              ContainerPlus(
                radius: RadiusPlus.only(topLeft: 50, bottomLeft: 50),
                color: invoicePaid
                    ? ColorsUtil.verdeSucesso
                    : ColorsUtil.verdeSecundario,
                padding: EdgeInsets.fromLTRB(30, 8, 15, 8),
                child: TextPlus(
                  invoicePaid ? 'Fatura paga' : 'Fatura em aberto',
                  fontSize: 16,
                  color: invoicePaid ? Colors.white : ColorsUtil.verdeEscuro,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ]),
            SizedBox(height: 5),
            Observer(builder: (_) {
              return ContainerPlus(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNameOrTypeArea('Nome', widget.card.ownerName),
                    _buildNameOrTypeArea(
                        'Tipo', widget.card.cardName.split('-')[0].trim())
                  ],
                ),
              );
            })
          ],
        ),
      ),
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

  Widget _buildSpentList() {
    return Observer(builder: (_) {
      if (_spentController.mySpents.length == 0) {
        return NoResultWidget(
            message: 'Você ainda não tem gastos neste cartão este mês');
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextPlus(
                'Este mês',
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: ColorsUtil.verdeEscuro,
              ),
              _buildInformPaidButton()
            ],
          ),
          SizedBox(height: 20),
          ContainerPlus(
            height: 600,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              separatorBuilder: (_, __) {
                return Divider(
                  height: 0.1,
                  color: ColorsUtil.verdeEscuro,
                );
              },
              itemCount: _spentController.mySpents.length ?? 10,
              itemBuilder: (_, index) {
                return SpentTile(
                    spent: _spentController.mySpents[index],
                    controller: _spentController);
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildInformPaidButton() {
    if (invoicePaid) {
      return SizedBox.shrink();
    }
    return ButtonWidget(
        text: 'Informar pagamento',
        onPressed: () async {
          await widget.controller.updateCardSpents(
              cardId: widget.card.cardId,
              spentMonth: DateTime.now().month,
              resetSpentsValue: true,
              spentValue: 0.0);
          SnackBarMessage()
              .showSucessMessage('Pagamento informado com sucesso');
          setState(() {
            invoicePaid = !invoicePaid;
          });
        });
  }
}
