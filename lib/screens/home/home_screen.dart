import 'package:cash_control/controllers/card_controller.dart';
import 'package:cash_control/controllers/category_controller.dart';
import 'package:cash_control/screens/category/categories_screen.dart';
import 'package:cash_control/screens/category/new_category_screen.dart';
import 'package:cash_control/screens/home/components/card_spents_area_widget.dart';
import 'package:cash_control/screens/home/components/category_area_widget.dart';
import 'package:cash_control/screens/home/components/finances_area_widget.dart';
import 'package:cash_control/screens/perfil/my_data_screen.dart';
import 'package:cash_control/screens/perfil/profile_screen.dart';
import 'package:cash_control/screens/spents/spent_screen.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widget/button_widget.dart';
import 'package:cash_control/widget/profile_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CategoryController _categoryController = GetIt.I<CategoryController>();
  final CardController _cardController = GetIt.I<CardController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getData();
    });
    super.initState();
  }

  getData() async {
    if (!auth.user.newUser) {
      await _categoryController.getCategories(limit: 10);
      await _cardController.getCards();
      await _cardController.getSavingsData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ContainerPlus(
          padding: EdgeInsets.fromLTRB(15, 60, 15, 10),
          child: Observer(builder: (_) {
            return Column(
              children: [_buildHeader(), _buildBody()],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return auth.user.newUser ? _newUserArea() : _usualUserArea();
  }

  Widget _newUserArea() {
    return Column(children: [
      SizedBox(height: 40),
      FinancesAreaWidget(cardController: _cardController),
      SizedBox(height: 40),
      _buildNewCategoryArea(),
      SizedBox(height: 40),
      _buildCompletePerfil()
    ]);
  }

  Widget _usualUserArea() {
    return Column(children: [
      SizedBox(height: 25),
      FinancesAreaWidget(cardController: _cardController),
      SizedBox(height: 25),
      _buildMoreUsedArea(),
      SizedBox(height: 25),
      CategoryAreaWidget(controller: _categoryController),
      SizedBox(height: 25),
      CardSpentsAreaWidget(controller: _cardController)
    ]);
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileImageWidget(),
        SizedBox(width: 15),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextPlus(
              'Olá, ${auth.user.displayName}',
              fontWeight: FontWeight.w600,
              color: ColorsUtil.verdeEscuro,
              fontSize: 26,
            ),
            SizedBox(height: 10),
            TextPlus(
                'Bem vindo ${auth.user.newUser ? "" : "de volta"} ao Cash Control',
                color: ColorsUtil.verdeEscuro,
                fontSize: 15),
          ],
        )
      ],
    );
  }

  Widget _buildMoreUsedArea() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextPlus('Mais usados', color: ColorsUtil.verdeEscuro, fontSize: 18),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ContainerPlus(
                skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
                radius: RadiusPlus.all(15),
                child: ButtonWidget(
                    text: 'Registrar gasto',
                    onPressed: () {
                      navigatorPlus.show(SpentScreen());
                    }),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ContainerPlus(
                skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
                radius: RadiusPlus.all(15),
                child: ButtonWidget(
                    text: 'Criar categoria',
                    onPressed: () {
                      navigatorPlus
                          .show(NewCategoryScreen())
                          .then((value) => _categoryController.getCategories());
                    }),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildNewCategoryArea() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ContainerPlus(
          width: 170,
          child: TextPlus(
            'Organize seus gastos por categorias',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: ColorsUtil.verdeEscuro,
          ),
        ),
        SizedBox(width: 2),
        ContainerPlus(
            width: 185,
            child: ButtonWidget(
              text: 'Criar nova categoria',
            ))
      ],
    );
  }

  Widget _buildCompletePerfil() {
    return ContainerPlus(
      radius: RadiusPlus.all(15),
      padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
      color: ColorsUtil.verdeEscuro,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ContainerPlus(
              child: Image.asset(
            'assets/images/moneyPerson.png',
            width: 102.0,
            height: 150,
          )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ContainerPlus(
                width: 240,
                child: TextPlus(
                  'Complete seu cadastro para visualizar suas ecônomias',
                  fontSize: 22,
                  color: ColorsUtil.verdeSecundario,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.end,
                ),
              ),
              SizedBox(height: 15),
              ButtonPlus(
                height: 50,
                width: 240,
                radius: RadiusPlus.all(25),
                alignment: Alignment.center,
                child: TextPlus(
                  'Ver meu perfil',
                  fontSize: 18,
                  color: ColorsUtil.verdeEscuro,
                ),
                color: Colors.white,
                splashColor: ColorsUtil.verdeClaro,
                onPressed: () => navigatorPlus.show(ProfileScreen()),
              )
            ],
          ),
        ],
      ),
    );
  }
}