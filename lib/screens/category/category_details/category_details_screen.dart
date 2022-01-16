import 'package:cached_network_image/cached_network_image.dart';
import 'package:cash_control/controllers/spent_controller.dart';
import 'package:cash_control/models/CategoryModel.dart';
import 'package:cash_control/models/SpentModel.dart';
import 'package:cash_control/screens/category/category_screen.dart';
import 'package:cash_control/screens/spents/spent_screen.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widgets/button_widget.dart';
import 'package:cash_control/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:cash_control/util/extensions.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final CategoryModel category;

  const CategoryDetailsScreen({this.category});

  @override
  _CategoryDetailsScreenState createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  CategoryModel category;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getCategoryData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: ContainerPlus(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: _buildBody()),
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
        title: 'Detalhes da categoria',
        showAction: true,
        actionIcon: Icons.edit,
        callback: () => navigatorPlus
                .show(CategoryScreen(
              category: widget.category,
            ))
                .then((currentCategory) async {
              await getCategoryData(currentCategory: currentCategory);
            }));
  }

  Future<void> getCategoryData({CategoryModel currentCategory}) async {
    category = currentCategory ?? widget.category;
    await spentController.getCategorySpents(category);
    spentController.isPositiveBalance(
        value: double.parse(category.spentsGoal.replaceAll(',', '.')));
  }

  Widget _buildBody() {
    return Observer(builder: (_) {
      return Column(children: <Widget>[
        _buildCategoryData(),
        SizedBox(height: 30),
        _buildCategoryResume(),
        SizedBox(
          height: 25,
        ),
        _buildGeneralSpent(
          text: spentController.positiveBalance
              ? 'Você ainda pode gastar'
              : 'Você ultrapassou a meta de ecônomia em',
          color: spentController.positiveBalance
              ? ColorsUtil.saldoPositivoColor
              : ColorsUtil.vermelho,
          value: loading.isLoading
              ? ''
              : spentController.diffCategorySpents(category.spentsGoal),
        ),
        SizedBox(height: 20),
        _buildRegisters()
      ]);
    });
  }

  Row _buildCategoryData() {
    return Row(children: <Widget>[
      ContainerPlus(
        skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
        color: ColorsUtil.verdeSecundario,
        radius: RadiusPlus.all(15),
        padding: EdgeInsets.all(8),
        height: 80,
        width: 80,
        child: CachedNetworkImage(imageUrl: widget.category.icon),
      ),
      SizedBox(width: 15),
      TextPlus(
        category.title,
        fontSize: 20,
        color: ColorsUtil.verdeEscuro,
        fontWeight: FontWeight.w600,
      )
    ]);
  }

  Row _buildCategoryResume() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildGeneralSpent(
            text: 'Gastos este mês',
            value:
                '- ${spentController.categorySpentsValue.toString().numToFormattedMoney()}'),
        _buildGeneralSpent(
            text: 'Meta de gasto mensal',
            value: 'R\$ ${category.spentsGoal ?? 0.0}'),
      ],
    );
  }

  Widget _buildGeneralSpent({String text, String value, Color color}) {
    return ContainerPlus(
      skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
      radius: RadiusPlus.all(15),
      padding: EdgeInsets.all(5),
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextPlus(
            text,
            color: color ?? ColorsUtil.verdeEscuro,
            fontSize: 16,
          ),
          SizedBox(height: 5),
          TextPlus(
            value,
            color: color ?? ColorsUtil.verdeEscuro,
            fontSize: 26,
            fontWeight: FontWeight.w900,
          ),
        ],
      ),
    );
  }

  Widget _buildRegisters() {
    return Observer(builder: (_) {
      if (!loading.isLoading && spentController.categorySpents.length == 0) {
        return ContainerPlus(
          child: Column(
            children: <Widget>[
              SizedBox(height: 25),
              TextPlus(
                'Você não possui gastos nesta categoria',
                fontSize: 18,
                color: ColorsUtil.verdeEscuro,
              ),
              SizedBox(height: 25),
              ButtonWidget(
                text: 'REGISTRAR NOVO GASTO',
                onPressed: () => navigatorPlus.show(SpentScreen()),
              )
            ],
          ),
        );
      }
      return _buildTable();
    });
  }

  _buildTable() {
    return Column(
      children: <Widget>[
        _buildHeader(),
        _buildList(),
      ],
    );
  }

  Widget _buildHeader() {
    return ContainerPlus(
      padding: EdgeInsets.all(15),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ContainerPlus(
              skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
              radius: RadiusPlus.all(15),
              padding: EdgeInsets.all(5),
              child: TextPlus(
                'Data',
                fontSize: 18,
                color: ColorsUtil.verdeEscuro,
              ),
            ),
            ContainerPlus(
              skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
              radius: RadiusPlus.all(15),
              padding: EdgeInsets.all(5),
              child: TextPlus(
                'Valor',
                fontSize: 18,
                color: ColorsUtil.verdeEscuro,
                textAlign: TextAlign.left,
              ),
            ),
          ]),
    );
  }

  Widget _buildList() {
    return ContainerPlus(
      height: 380,
      skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
      radius: RadiusPlus.all(15),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        separatorBuilder: (_, __) {
          return Divider(
            height: 0.1,
            color: ColorsUtil.cinza,
          );
        },
        itemCount: spentController.categorySpents.length ?? 5,
        itemBuilder: (_, int index) {
          SpentModel item = spentController.categorySpents[index];
          return ContainerPlus(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ContainerPlus(
                  skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
                  child: TextPlus(
                    item.spentDate.formattedDate(),
                    fontSize: 16,
                    color: ColorsUtil.verdeEscuro,
                  ),
                ),
                ContainerPlus(
                  skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
                  child: TextPlus(
                    '- ${item.amount.toString().numToFormattedMoney()}',
                    color: ColorsUtil.vermelhoEscuro,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
