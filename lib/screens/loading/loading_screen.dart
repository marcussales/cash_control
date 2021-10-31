import 'package:cash_control/screens/splash/splash_screen.dart';
import 'package:cash_control/shared/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';

class LoadingScreen extends StatefulWidget {
  final Widget body;
  const LoadingScreen({Key key, this.body}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (!loading.isLoading) {
        return widget.body;
      } else {
        return SplashScreen();
      }
    });
  }
}
