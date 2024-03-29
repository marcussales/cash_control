import 'dart:async';
import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerPlus(
      gradient: GradientPlus.linear(
        colors: <Color>[
          ColorsUtil.verdeSplashScreen,
          ColorsUtil.cinzaSplashScreen,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.bottomRight,
      ),
      child: SizedBox(
        height: 50,
        child: Image.asset(
          'assets/images/splash.png',
          height: 100,
        ),
      ),
    );
  }
}
