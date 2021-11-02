import 'package:cash_control/screens/perfil/my_data_screen.dart';
import 'package:cash_control/screens/spents_report/spents_report_screen.dart';
import 'package:cash_control/shared/global.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:cash_control/widget/custom_app_bar.dart';
import 'package:cash_control/widget/profile_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: ContainerPlus(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: _buildBody()),
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: 'Meu perfil',
      showBackButton: false,
      actionIcon: Icons.meeting_room,
      callback: () async {
        await auth.logout();
      },
      showAction: true,
    );
  }

  Column _buildBody() {
    return Column(
      children: [
        _buildPhotoAndName(),
        _buildOptions(),
        _buildVersionTxt(),
      ],
    );
  }

  Row _buildPhotoAndName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ProfileImageWidget(
          height: 140,
          width: 155,
        ),
        TextPlus(
          auth.user.displayName,
          fontSize: 24,
          color: ColorsUtil.verdeEscuro,
        )
      ],
    );
  }

  Widget _buildOptions() {
    return Column(
      children: [
        SizedBox(height: 40),
        _buildOption(
            title: 'Meus dados',
            icon: Icons.person_outline,
            screen: MyDataScreen()),
        Divider(
          height: 0.1,
          color: ColorsUtil.verdeEscuro,
        ),
        _buildOption(
            title: 'Relatório financeiro',
            icon: Icons.insert_chart_outlined,
            screen: SpentsReportScreen()),
        Divider(
          height: 0.1,
          color: ColorsUtil.verdeEscuro,
        ),
      ],
    );
  }

  Widget _buildOption({String title, IconData icon, Widget screen}) {
    return ContainerPlus(
        padding: EdgeInsets.fromLTRB(0, 15, 5, 15),
        onTap: () => navigatorPlus.show(screen),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              ContainerPlus(
                skeleton: SkeletonPlus.automatic(enabled: loading.isLoading),
                radius: RadiusPlus.all(10),
                color: ColorsUtil.verdeSecundario,
                width: 50,
                height: 45,
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  color: ColorsUtil.verdeEscuro,
                  size: 40,
                ),
              ),
              SizedBox(
                width: 18,
              ),
              TextPlus(
                title,
                fontSize: 18,
                color: ColorsUtil.verdeEscuro,
                fontWeight: FontWeight.w800,
              ),
            ],
          ),
          SizedBox(width: 18),
          Icon(
            Icons.keyboard_arrow_right_outlined,
            color: ColorsUtil.verdeClaro,
            size: 28,
          ),
        ]));
  }

  Widget _buildVersionTxt() {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[
        ColorsUtil.verdeEscuro,
        ColorsUtil.getColorByHex('#006E7D')
      ],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 180.0, 70.0));

    return ContainerPlus(
      margin: EdgeInsets.only(top: 250),
      child: Text(
        apkVersion,
        style: new TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            foreground: Paint()..shader = linearGradient),
      ),
    );
  }
}
