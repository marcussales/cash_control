import 'package:cash_control/screens/introduction/steps/first_step_screen.dart';
import 'package:cash_control/screens/introduction/steps/second_step_screen.dart';
import 'package:cash_control/screens/introduction/steps/third_step_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatelessWidget {
  List<PageViewModel> pagesList = [
    // FirstStepScreen(),
    // SecondStepScreen(),
    // ThirdStepScreen(),
    PageViewModel(
        title: 'Titulo',
        body: 'asdasdasdasdasdasdasdasdasd',
        image: ContainerPlus(
            child: Image.asset(
          'assets/images/tetrix.png',
          // width: 50.0,
          height: 250,
        )),
        footer: ElevatedButton(
          onPressed: () {
            print('aasdad');
          },
          child: const Text('aloo'),
        ))
  ];

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: pagesList,
      done: Text('done'),
      onDone: () {
        print('asdasdasd');
      },
    );
  }
}
