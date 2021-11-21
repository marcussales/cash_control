import 'package:cash_control/screens/home/home_screen.dart';
import 'package:cash_control/screens/login/login_screen.dart';
import 'package:cash_control/screens/my_cards/my_cards_screen.dart';
import 'package:cash_control/screens/my_cards/card_screen.dart';
import 'package:cash_control/screens/no_signal/no_signal.screen.dart';
import 'package:cash_control/screens/perfil/profile_screen.dart';
import 'package:cash_control/screens/spents/my_spents_screen.dart';
import 'package:cash_control/screens/perfil/my_data_screen.dart';
import 'package:cash_control/screens/spents/spent_screen.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/shared/utils.dart';
import 'package:cash_control/widgets/menu/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:mobx/mobx.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();
  final List<Widget> _screens = [
    HomeScreen(),
    MyCardsScreen(),
    SpentScreen(),
    MySpentsScreen(),
    ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    autorun((_) {
      if (!connectivityController.connected) {
        Future.delayed(Duration(microseconds: 50))
            .then((value) => navigatorPlus.show(NoSignalScreen()));
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getData();
    });
  }

  getData() async {
    await Util.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            bottomNavigationBar: BottomMenuWidget(),
            body: _screens[pagesStore.page]),
      );
    });
  }
}
