import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class SearchDialog extends StatelessWidget {
  SearchDialog({this.currentSearch})
      : controller = TextEditingController(text: currentSearch);
  final String currentSearch;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 2,
          right: 10,
          left: 10,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: TextFieldPlus(
                padding: EdgeInsets.all(5),
                controller: controller,
                cursorColor: ColorsUtil.verdeEscuro,
                enabled: true,
                autofocus: true,
                textInputAction: TextInputAction.search,
                placeholder: TextPlus(
                  'Busque por um gasto',
                  color: Colors.black38,
                ),
                prefixWidget: IconButton(
                  onPressed: () => navigatorPlus.back(result: ''),
                  icon: Icon(
                    Icons.arrow_back,
                    color: ColorsUtil.verdeEscuro,
                  ),
                ),
                suffixWidget: IconButton(
                    icon: Icon(Icons.search, color: ColorsUtil.verdeClaro),
                    onPressed: () {
                      if (controller.text != '') {
                        navigatorPlus.back(result: controller.text);
                      }
                    })),
          ),
        )
      ],
    );
  }
}
