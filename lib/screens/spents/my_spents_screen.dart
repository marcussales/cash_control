import 'package:cash_control/controllers/spent_controller.dart';
import 'package:cash_control/screens/loading/loading_screen.dart';
import 'package:cash_control/screens/spents/components/search_dialog.dart';
import 'package:cash_control/screens/spents/components/spent_tile.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widgets/custom_app_bar.dart';
import 'package:cash_control/widgets/custom_refresh_indicator.widget.dart';
import 'package:cash_control/widgets/no_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';

// ignore: public_member_api_docs
class MySpentsScreen extends StatefulWidget {
  @override
  _MySpentsScreenState createState() => _MySpentsScreenState();
}

class _MySpentsScreenState extends State<MySpentsScreen> {
  String searchText;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (spentController.searchText != '') {
        spentController.getSpents();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: Observer(builder: (_) {
          return SingleChildScrollView(
            child: ContainerPlus(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: _buildBody(),
            ),
          );
        }));
  }

  Widget _buildAppBar() {
    return CustomAppBar(
      title: 'Meus gastos',
      showAction: true,
      showBackButton: false,
      actionIcon: Icons.search,
      callback: () async {
        spentController.searchText = await showDialog(
            context: context,
            builder: (_) => SearchDialog(
                  currentSearch: spentController.searchText,
                ));
        if (spentController.searchText != '') {
          spentController.searchSpent();
          return;
        }
        await spentController.getSpents();
      },
    );
  }

  Widget _buildBody() {
    return spentController.emptySearch && !loading.isLoading
        ? NoResultWidget(
            message: searchText == ''
                ? 'Você ainda não possui gastos registrados'
                : null)
        : _buildSpentsList();
  }

  Column _buildSpentsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextPlus(
          'Recentes',
          fontSize: 20,
          color: ColorsUtil.verdeEscuro,
        ),
        SizedBox(height: 10),
        ContainerPlus(
          height: 700,
          padding: EdgeInsets.only(bottom: 40),
          child: CustomRefreshIndicator(
            onRefresh: () {
              spentController.getSpents();
              cardController.updateCardData();
            },
            body: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              separatorBuilder: (_, __) {
                return Divider(
                  height: 0.1,
                  color: ColorsUtil.verdeEscuro,
                );
              },
              itemCount: spentController.mySpents.length ?? 10,
              itemBuilder: (_, int index) {
                if (index < spentController.mySpents.length) {
                  return SpentTile(spent: spentController.mySpents[index]);
                }
                spentController.nextPage();
                return Container(
                  height: 10,
                  child: LinearProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation(ColorsUtil.verdeEscuro)),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
