import 'package:cash_control/controllers/card_controller.dart';
import 'package:cash_control/controllers/spent_controller.dart';
import 'package:cash_control/models/CardModel.dart';
import 'package:cash_control/models/SpentModel.dart';
import 'package:cash_control/screens/loading/loading_screen.dart';
import 'package:cash_control/screens/my_cards/card_screen.dart';
import 'package:cash_control/screens/spents/components/spent_tile.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/shared/dialog_message.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widgets/button_widget.dart';
import 'package:cash_control/widgets/custom_app_bar.dart';
import 'package:cash_control/widgets/no_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:get_it/get_it.dart';

class CardSpentsScreen extends StatefulWidget {
  final CardModel card;
  const CardSpentsScreen({this.card});

  @override
  _CardSpentsScreenState createState() => _CardSpentsScreenState();
}

class _CardSpentsScreenState extends State<CardSpentsScreen> {
  bool invoicePaid = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await spentController.getSpents(cardId: widget.card.cardId);
      await spentController.updateCurrentCard(widget.card);
      invoicePaid = widget.card.invoicePaid;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      key: Key('CardSpentsScreen'),
      body: Scaffold(
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: ContainerPlus(
              height: 1200,
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: _buildBody()),
        ),
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: 'Gastos por cartão',
      showAction: true,
      actionIcon: Icons.edit,
      callback: () => navigatorPlus.show(CardScreen(
        card: widget.card,
      )),
    );
  }

  Widget _buildBody() {
    return Column(children: <Widget>[
      _builCardData(),
      SizedBox(height: 40),
      _buildSpentList(),
    ]);
  }

  ContainerPlus _builCardData() {
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
      child: ContainerPlus(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ContainerPlus(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
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
                    _buildNameOrTypeArea('Tipo do cartão',
                        widget.card.cardName.split('-')[0].trim())
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

  Widget _buildSpentList() {
    return Observer(builder: (_) {
      List<SpentModel> spents = spentController.mySpents;
      if (spents.length == 0) {
        return NoResultWidget(
            message: 'Você ainda não tem gastos neste cartão este mês');
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
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
            height: 430,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              separatorBuilder: (_, __) {
                return Divider(
                  height: 0.1,
                  color: ColorsUtil.verdeEscuro,
                );
              },
              itemCount: spents.length ?? 10,
              itemBuilder: (_, int index) {
                return SpentTile(
                  spent: spents[index],
                );
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
          await cardController.updateCardSpents(
              cardId: widget.card.cardId,
              spentMonth: DateTime.now().month,
              resetSpentsValue: true,
              spentValue: 0.0);
          DialogMessage.showSucessMessage('Pagamento informado com sucesso');
          invoicePaid = !invoicePaid;
        });
  }
}
