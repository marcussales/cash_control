import 'package:cash_control/base/base_screen.dart';
import 'package:cash_control/controllers/user_controller.dart';
import 'package:cash_control/shared/snackbar_message.dart';
import 'package:cash_control/util/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  UserController _controller = UserController();

  @override
  void initState() {
    _logoutCurrentUser();
    super.initState();
  }

  Future<void> _logoutCurrentUser() async {
    if (_googleSignIn.currentUser == null) {
      await _googleSignIn.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.verdeEscuro,
      body: ContainerPlus(
        width: 320,
        padding: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextPlus(
              'Suas finanças',
              fontSize: 40,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            TextPlus(
              'na palma',
              fontSize: 40,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            TextPlus(
              'da sua mão',
              fontSize: 40,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            SizedBox(height: 60),
            TextPlus(
              'A forma mais simples de controlar seus gastos e melhorar seu planejamento financeiro',
              fontSize: 24,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold,
              wordSpacing: 4,
              color: Colors.white,
            ),
            SizedBox(height: 60),
            _buildLoginButton(),
            SizedBox(height: 20),
            TextPlus(
              'ou',
              fontSize: 22,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
              wordSpacing: 4,
              color: ColorsUtil.verdeSecundario,
            ),
            SizedBox(height: 20),
            ContainerPlus(
                onTap: _signUp,
                child: (TextPlus(
                  'Cadastre-se',
                  fontSize: 22,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                  wordSpacing: 4,
                  color: ColorsUtil.verdeSecundario,
                ))),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return ButtonPlus(
      onPressed: _login,
      color: Colors.white,
      radius: RadiusPlus.all(50),
      splashColor: ColorsUtil.verdeSecundario,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextPlus(
            'Acesse sua conta',
            padding: EdgeInsets.only(left: 15),
            color: ColorsUtil.verdeEscuro,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          Observer(builder: (_) {
            if (_controller.doLogin) {
              return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(ColorsUtil.verdeEscuro));
            }
            return ContainerPlus(
                child: Image.asset(
              'assets/images/gmail.png',
              width: 50.0,
              height: 40,
            ));
          })
        ],
      ),
    );
  }

  Future _login() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      var user = await _controller.loginOrSignUp(googleSignInAccount);
      if (user != null) {
        navigatorPlus.show(BaseScreen());
      }
      return;
    } catch (error) {
      SnackBarMessage()
          .errorMsg('Não foi possivel realizar o login, tente novamente');
    }
  }

  Future _signUp() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      var user = await _controller.signUpUser(googleSignInAccount);
      if (user != null) {
        navigatorPlus.show(BaseScreen());
        return;
      }
    } catch (error) {
      SnackBarMessage()
          .errorMsg('Não foi possivel realizar o login, tente novamente');
    }
  }
}
