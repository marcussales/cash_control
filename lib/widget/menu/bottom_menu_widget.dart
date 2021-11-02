import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widget/menu/menu_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';

class BottomMenuWidget extends StatelessWidget {
  final double size = 11.5;
  final currentPage = pagesStore.page;

  @override
  Widget build(BuildContext context) {
    return _buildMenu();
  }

  Widget _buildMenu() {
    return Observer(builder: (_) {
      if (loading.isLoading) {
        return SizedBox.shrink();
      }
      return ContainerPlus(
        shadows: [
          ShadowPlus(
            color: ColorsUtil.verdeEscuro,
            moveDown: -3,
            moveRight: -1,
            blur: 5,
            spread: 0.2,
            opacity: 0.2,
          ),
        ],
        radius: RadiusPlus.all(20),
        height: 60,
        child: BottomAppBar(
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MenuItemWidget(
                  title: 'Home',
                  icon: buildIcon(icon: Icons.home, idx: 0),
                  page: 0),
              MenuItemWidget(
                  title: 'Meus cartões',
                  icon: buildIcon(icon: Icons.credit_card, idx: 1),
                  page: 1),
              ContainerPlus(
                isCircle: true,
                margin: EdgeInsets.only(top: 2),
                color: ColorsUtil.verdeSecundario,
                border: BorderPlus(color: ColorsUtil.verdeEscuro, width: 1),
                child: IconButton(
                  icon: Icon(
                    Icons.request_quote_outlined,
                    size: 32,
                    color: ColorsUtil.verdeEscuro,
                  ),
                  onPressed: () {
                    pagesStore.setPage(2);
                  },
                ),
              ),
              MenuItemWidget(
                  title: 'Meus gastos',
                  icon: buildIcon(icon: Icons.how_to_vote, idx: 3),
                  page: 3),
              MenuItemWidget(
                  title: 'Perfil',
                  icon: buildIcon(icon: Icons.person_outline, idx: 4),
                  page: 4)
            ],
          ),
        ),
      );
    });
  }

  Icon buildIcon({IconData icon, int idx}) {
    return Icon(
      icon,
      color: iconColor(idx),
      size: 25,
    );
  }

  Color iconColor(int page) {
    return pagesStore.page == page ? ColorsUtil.verdeEscuro : ColorsUtil.cinza;
  }
}
