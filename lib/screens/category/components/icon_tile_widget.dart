import 'package:cached_network_image/cached_network_image.dart';
import 'package:cash_control/controllers/icons_controller.dart';
import 'package:cash_control/models/IconsModel.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';

class IconTileWidget extends StatefulWidget {
  final IconModel icon;
  final bool selectedIcon;
  final int itemIdx;
  final IconsController controller;
  final bool hasItens;

  const IconTileWidget(
      {this.icon,
      this.selectedIcon,
      this.itemIdx,
      this.controller,
      this.hasItens});

  @override
  _IconTileWidgetState createState() => _IconTileWidgetState();
}

class _IconTileWidgetState extends State<IconTileWidget> {
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return ContainerPlus(
        onTap: () {
          setState(() {
            widget.controller.setSelectedItem(widget.itemIdx);
          });
        },
        radius: RadiusPlus.all(15),
        border: BorderPlus(color: ColorsUtil.verdeEscuro, width: 2),
        margin: EdgeInsets.all(5),
        width: 70,
        height: 30,
        color: widget.controller.selectedItem == widget.itemIdx
            ? ColorsUtil.verdeSecundario
            : ColorsUtil.amareloClaro,
        child: ContainerPlus(
          padding: EdgeInsets.all(8),
          child: widget.hasItens
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(ColorsUtil.verdeClaro),
                )
              : CachedNetworkImage(imageUrl: widget.icon.icon),
        ),
      );
    });
  }
}
