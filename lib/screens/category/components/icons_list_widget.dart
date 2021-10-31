import 'package:cash_control/controllers/icons_controller.dart';
import 'package:cash_control/screens/category/components/icon_tile_widget.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';

class IconsListWidget extends StatelessWidget {
  final IconsController controller;
  const IconsListWidget({this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextPlus(
          'Selecione uma imagem',
          fontSize: 17,
          color: ColorsUtil.verdeEscuro,
        ),
        SizedBox(
          height: 8,
        ),
        ContainerPlus(
          height: 80,
          child: Observer(builder: (_) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.iconsList.length ?? 8,
              itemBuilder: (_, index) {
                return IconTileWidget(
                  hasItens: controller.iconsList.length == 0,
                  icon: controller.iconsList[index],
                  itemIdx: index,
                  controller: controller,
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
