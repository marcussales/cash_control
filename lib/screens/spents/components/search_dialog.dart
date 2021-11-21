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
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  hintText: 'Busque por um gasto',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  prefixIcon: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: ColorsUtil.verdeEscuro,
                      ),
                      onPressed: navigatorPlus.back),
                  suffixIcon: IconButton(
                      icon: Icon(Icons.search, color: ColorsUtil.verdeClaro),
                      onPressed: () {
                        navigatorPlus.back(result: controller.text);
                      })),
              textInputAction: TextInputAction.search,
              onSubmitted: (String text) {
                Navigator.of(context).pop(text);
              },
              autofocus: true,
            ),
          ),
        )
      ],
    );
  }
}
