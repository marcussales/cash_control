import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class ProfileImageWidget extends StatelessWidget {
  final double height;
  final double width;

  ProfileImageWidget({this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return ContainerPlus(
        skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
        color: ColorsUtil.verdeEscuro,
        height: this.height ?? 95,
        width: this.width ?? 105,
        border: BorderPlus(color: ColorsUtil.verdeEscuro, width: 2),
        radius: RadiusPlus.all(10),
        child: Image.network(
          auth.user.photoUrl,
          fit: BoxFit.cover,
        ));
  }
}
