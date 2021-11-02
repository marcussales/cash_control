import 'package:cash_control/screens/splash/splash_screen.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
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
  void initState() {
    // _changeOpacity();
    super.initState();
  }

  var showOpacity = false;
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      // if (!loading.isLoading) {
      return widget.body;
      // } else {
      // return _buildLoading();
      // }
    });
  }

  Widget _buildLoading() {
    return ContainerPlus(
        height: 900,
        gradient: GradientPlus.linear(
          colors: [
            ColorsUtil.verdeSplashScreen,
            ColorsUtil.cinzaSplashScreen,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        child: AnimatedOpacity(
          opacity: showOpacity ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: SizedBox(
            height: 50,
            child: Image.asset(
              'assets/images/splash.png',
              height: 200,
            ),
          ),
        ));
  }

  Future<void> _changeOpacity() {
    Future.delayed(Duration(milliseconds: 500)).then((value) => {
          setState(() {
            showOpacity = !showOpacity;
            _changeOpacity();
          })
        });
  }
}
