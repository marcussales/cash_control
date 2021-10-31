import 'package:cash_control/controllers/card_controller.dart';
import 'package:cash_control/controllers/spent_controller.dart';
import 'package:cash_control/screens/spents_report/components/month_tile.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widget/card_item_widget.dart';
import 'package:cash_control/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:cash_control/util/extensions.dart';

class SpentsReportScreen extends StatefulWidget {
  @override
  _SpentsReportScreenState createState() => _SpentsReportScreenState();
}

class _SpentsReportScreenState extends State<SpentsReportScreen> {
  CardController cardController = GetIt.I<CardController>();
  SpentController spentController = GetIt.I<SpentController>();

  @override
  void initState() {
    auth.averageCalc();
    auth.percentageDiffCurrentPreviousMonth();
    categoryController.getMoreEconomicCategories();

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
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: _buildBody()),
      ),
    );
  }

  Widget _buildBody() {
    return Column(children: [
      _buildAverageArea(),
      SizedBox(
        height: 25,
      ),
      _buildPositiveResume(),
      SizedBox(
        height: 25,
      ),
      _buildPositiveChampions()
    ]);
  }

  ContainerPlus _buildAverageArea() {
    return ContainerPlus(
      radius: RadiusPlus.all(20),
      padding: EdgeInsets.fromLTRB(0, 25, 20, 25),
      color: ColorsUtil.azulClaro,
      height: 140,
      width: 500,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ContainerPlus(
              width: 120,
              height: 110,
              child: Image.asset(
                'assets/images/chart.png',
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextPlus('Média de gasto mensal',
                  color: Colors.white, fontSize: 20),
              SizedBox(height: 25),
              TextPlus('${auth.averageValue}'.numToFormattedMoney(),
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 30),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPositiveResume() {
    return ContainerPlus(
      radius: RadiusPlus.all(20),
      padding: EdgeInsets.fromLTRB(0, 10, 20, 20),
      color: ColorsUtil.getColorByHex('#4BDE5A'),
      child: Column(
        children: [
          Row(children: [
            Image.asset(
              'assets/images/happy.png',
              height: 120,
            ),
            ContainerPlus(
              width: 210,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextPlus(
                    'Parabéns!',
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextPlus(
                    'Você economizou ${auth.percentBalance}% acima da média mensal',
                    fontSize: 18,
                    textAlign: TextAlign.start,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
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

  Widget _buildPositiveChampions() {
    return ContainerPlus(
        radius: RadiusPlus.all(20),
        padding: EdgeInsets.fromLTRB(0, 10, 20, 20),
        color: ColorsUtil.getColorByHex('#E0FEE3'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ContainerPlus(
                    child: Image.asset(
                  'assets/images/podium.png',
                  width: 100.0,
                  height: 120,
                )),
                TextPlus(
                  'Campeões em ecônomia',
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichTextPlus(texts: [
                    TextPlus(
                      'Valor economizado: ',
                      fontSize: 20,
                      padding: const EdgeInsets.only(left: 20),
                    ),
                    TextPlus('${auth.currentSaving}'.numToFormattedMoney(),
                        fontWeight: FontWeight.w800, fontSize: 23)
                  ]),
                  SizedBox(height: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextPlus(
                        'Cartão com o menor gasto',
                        fontSize: 18,
                      ),
                      CardItemWidget(
                        card: cardController.moreEconomicCard(),
                        callbackSelectItem: (item) {},
                        isSelectedItem: (item) => true,
                        isSelectable: false,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
