import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar(
      {Key key,
      @required this.title,
      this.showBackButton = true,
      this.showAction = false,
      this.actionIcon,
      this.callback})
      : preferredSize = Size.fromHeight(60.0),
        super(key: key);

  @override
  final Size preferredSize;
  final String title;
  final bool showBackButton;
  final bool showAction;
  final IconData actionIcon;
  final Function callback;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 15,
      title: Text(this.widget.title,
          style: TextStyle(
              color: ColorsUtil.verdeEscuro,
              fontSize: 22,
              fontWeight: FontWeight.w400)),
      backgroundColor: ColorsUtil.bg,
      actions: [
        widget.showAction
            ? ContainerPlus(
                onTap: widget.callback,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                isCircle: true,
                width: 40,
                height: 15,
                color: ColorsUtil.verdeEscuro,
                child: Icon(
                  widget.actionIcon,
                  size: 25,
                  color: ColorsUtil.verdeSecundario,
                ),
              )
            : SizedBox.shrink()
      ],
      leadingWidth: widget.showBackButton ? 55 : 0,
      leading: widget.showBackButton
          ? IconButton(
              icon: RotatedBox(
                  quarterTurns: 2,
                  child: IconButton(
                    icon: Icon(
                      Icons.subdirectory_arrow_right,
                      color: ColorsUtil.verdeEscuro,
                      size: 27,
                    ),
                    onPressed: null,
                  )),
              onPressed: () => navigatorPlus.back(),
            )
          : SizedBox.shrink(),
    );
  }
}
