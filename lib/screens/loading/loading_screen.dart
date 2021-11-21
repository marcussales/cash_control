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
    _changeOpacity();
    super.initState();
  }

  bool showOpacity = true;
  Duration duration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (!loading.isLoading) {
        return widget.body;
      } else {
        return _buildLoading();
      }
    });
  }

  Widget _buildLoading() {
    return ContainerPlus(
        height: 900,
        gradient: GradientPlus.linear(
          colors: <Color>[
            ColorsUtil.verdeSplashScreen,
            ColorsUtil.cinzaSplashScreen,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.bottomRight,
        ),
        child: AnimatedOpacity(
          opacity: showOpacity ? 1.0 : 0.0,
          duration: duration,
          child: SizedBox(
            height: 50,
            child: Image.asset(
              'assets/images/splash.png',
              height: 100,
            ),
          ),
        ));
  }

  void _changeOpacity() {
    Future<void>.delayed(duration)
        // ignore: always_specify_types
        .then((_) => {
              showOpacity = !showOpacity,
              _changeOpacity(),
            });
  }
}
