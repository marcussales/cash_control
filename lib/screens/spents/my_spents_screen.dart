import 'package:cash_control/controllers/spent_controller.dart';
import 'package:cash_control/screens/spents/components/search_dialog.dart';
import 'package:cash_control/screens/spents/components/spent_tile.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widget/custom_app_bar.dart';
import 'package:cash_control/widget/no_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';

class MySpentsScreen extends StatefulWidget {
  @override
  _MySpentsScreenState createState() => _MySpentsScreenState();
}

class _MySpentsScreenState extends State<MySpentsScreen> {
  SpentController _spentController = SpentController();
  String searchText = '';

  @override
  void initState() {
    super.initState();
    _spentController.getSpents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Meus gastos',
          showAction: true,
          showBackButton: false,
          actionIcon: Icons.search,
          callback: () async {
            searchText = await showDialog(
                context: context,
                builder: (_) => SearchDialog(
                      currentSearch: '',
                    ));
            if (searchText != null) {
              _spentController.searchSpent(search: searchText);
              return;
            }
            await _spentController.getSpents();
          },
        ),
        body: SingleChildScrollView(
          child: ContainerPlus(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: _buildBody(),
          ),
        ));
  }

  Widget _buildBody() {
    return Observer(builder: (_) {
      return _spentController.emptySearch
          ? NoResultWidget(
              message: searchText == ''
                  ? 'Você ainda não possui gastos registrados'
                  : null)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextPlus(
                  'Recentes',
                  fontSize: 20,
                  color: ColorsUtil.verdeEscuro,
                ),
                SizedBox(height: 10),
                ContainerPlus(
                  height: 800,
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
                )
              ],
            );
    });
  }
}
