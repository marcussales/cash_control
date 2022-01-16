import 'package:cash_control/controllers/card_controller.dart';
import 'package:cash_control/controllers/spent_controller.dart';
import 'package:cash_control/screens/spents_report/components/month_tile.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widgets/card_item_widget.dart';
import 'package:cash_control/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:cash_control/util/extensions.dart';

class SpentsReportScreen extends StatefulWidget {
  @override
  _SpentsReportScreenState createState() => _SpentsReportScreenState();
}

class _SpentsReportScreenState extends State<SpentsReportScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Relatório financeiro',
      ),
      body: SingleChildScrollView(
        child: ContainerPlus(
          padding: EdgeInsets.fromLTRB(18, 15, 18, 0),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTodayTxt(),
        _buildFinancesArea(),
        Divider(),
        SizedBox(height: 25),
        _buildMoreSpentArea()
      ],
    );
  }

  Widget _buildTodayTxt() {
    return Column(children: <Widget>[
      TextPlus(
        _todayInfo(),
        textAlign: TextAlign.left,
        fontSize: 22,
        color: ColorsUtil.verdeEscuro,
      ),
      SizedBox(
        height: 50,
      )
    ]);
  }

  Widget _buildFinancesArea() {
    return Column(
      children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextPlus(
                'Você economizou',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorsUtil.verdeEscuro,
              ),
              ContainerPlus(
                radius: RadiusPlus.all(50),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                color: ColorsUtil.verdeSucesso,
                child: TextPlus(
                  cardController.savingsValue.formattedMoneyBr(),
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]),
        SizedBox(height: 35),
        _buildDefaultRow(
          title: 'Categoria mais ecônomica',
          value: categoryController.getMoreEconomicCategory(moreEconomic: true),
          color: ColorsUtil.verdeSucesso,
        ),
        SizedBox(height: 25),
        _buildDefaultRow(
          title: 'Cartão mais ecônomico',
          value: cardController
              .moreEconomicOrWastedCard(moreEconomic: true)
              .cardName,
          color: ColorsUtil.verdeSucesso,
        ),
        SizedBox(height: 25),
      ],
    );
  }

  Widget _buildMoreSpentArea() {
    return Column(
      children: <Widget>[
        _buildDefaultRow(
            title: 'Categoria que gerou mais gastos',
            value:
                categoryController.getMoreEconomicCategory(moreEconomic: false),
            color: ColorsUtil.vermelhoEscuro),
        SizedBox(height: 25),
        _buildDefaultRow(
            title: 'Cartão com mais gastos:',
            value: cardController
                .moreEconomicOrWastedCard(moreEconomic: false)
                .cardName,
            color: ColorsUtil.vermelhoEscuro),
        SizedBox(height: 25),
      ],
    );
  }
}

String _todayInfo() {
  return 'Este mês até ${DateTime.now().day} de ${spentController.getFormattedCurrentMonth().toString().toLowerCase()}';
}

Row _buildDefaultRow({String title, String value, Color color}) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextPlus(
          title,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: ColorsUtil.verdeEscuro,
        ),
        TextPlus(
          value,
          fontSize: 16,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ]);
}

Widget _buildMonthList() {
  return ContainerPlus(
      height: 35,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: spentController.months.length,
          itemBuilder: (_, index) {
            return MonthTile(
                month: spentController.months[index],
                isCurrentMonth:
                    spentController.months[index].id == DateTime.now().month);
          }));
}
