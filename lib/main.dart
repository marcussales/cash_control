import 'package:cash_control/base/base_screen.dart';
import 'package:cash_control/controllers/card_controller.dart';
import 'package:cash_control/controllers/category_controller.dart';
import 'package:cash_control/controllers/connectivity_controller.dart';
import 'package:cash_control/controllers/icons_controller.dart';
import 'package:cash_control/controllers/loading.controller.dart';
import 'package:cash_control/controllers/user_controller.dart';
import 'package:cash_control/controllers/spent_controller.dart';
import 'package:cash_control/screens/login/login_screen.dart';
import 'package:cash_control/screens/no_signal/no_signal.screen.dart';
import 'package:cash_control/screens/splash/splash_screen.dart';
import 'package:cash_control/shared/global.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'controllers/page_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _registerStores();
  await initializeParse();
  runApp(CashControl());
}

void _registerStores() {
  final getIt = GetIt.I.registerSingleton;
  getIt(UserController());
  getIt(PagesController());
  getIt(IconsController());
  getIt(SpentController());
  getIt(CardController());
  getIt(LoadingController());
  getIt(CategoryController());
  getIt(ConnectivityController());
}

Future<void> initializeParse() async {
  await Parse().initialize('zFGYcrfmTubEO9TY8ckXmf2D7SOomrobMF6VuXNs',
      'https://parseapi.back4app.com/',
      clientKey: '2Z4fBDq5hU3TgJyUggiPs1tVf3CxhtmbQbGPVSSN',
      autoSendSessionId: true,
      debug: true);
}

class CashControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Init.instance.initialize(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(home: SplashScreen());
          } else {
            return FlutterAppPlus(
              title: 'Cash Control',
              navigatorKey: navigatorPlus.key,
              home: auth.user?.id != null ? BaseScreen() : LoginScreen(),
              theme: ThemeData(
                primaryColor: ColorsUtil.verdeEscuro,
                fontFamily: 'Roboto',
                appBarTheme: AppBarTheme(elevation: 0),
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: ColorsUtil.verdeEscuro,
                ),
              ),
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [Locale('pt', 'BR')],
            );
          }
        });
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(const Duration(seconds: 3));
  }
}
