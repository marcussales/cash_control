import 'dart:async';
import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _visible = true;
  Duration _duration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerPlus(
      gradient: GradientPlus.linear(
        colors: [
          ColorsUtil.verdeSplashScreen,
          ColorsUtil.cinzaSplashScreen,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      child: Image.asset(
        'assets/images/splash.png',
        height: 200,
      ),
    );
  }
}
