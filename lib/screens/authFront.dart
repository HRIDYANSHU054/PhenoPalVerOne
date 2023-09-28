import 'package:animations/animations.dart';
import 'package:ayurbot/screens/loginScreen.dart';
import 'package:ayurbot/screens/registerScreen.dart';
import 'package:ayurbot/services/authSwitch.dart';
import 'package:flutter/material.dart';

class AuthFront extends StatefulWidget {
  const AuthFront({super.key});

  @override
  State<AuthFront> createState() => _AuthFrontState();
}

class _AuthFrontState extends State<AuthFront> {
  AuthSwitch aSwitch = AuthSwitch(showRegisterPage: false);

  //transition builder
  Widget buildPageTrans() {
    return PageTransitionSwitcher(
      duration: Duration(milliseconds: 2000),
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        return SharedAxisTransition(
          child: child,
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
        );
      },
      child: aSwitch.showRegisterPage!
          ? RegisterScreen(
              onTap: () {
                setState(() {
                  aSwitch.showRegisterPage = false;
                });
              },
              aSwitch: aSwitch,
            )
          : LoginScreen(
              onTap: () {
                setState(() {
                  aSwitch.showRegisterPage = true;
                });
              },
              aSwitch: aSwitch,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //backgroundImage
        ////////////////////////
        Image.asset(
          "assets/authBGidea2.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        //front
        ////////////////////////
        buildPageTrans(),
      ],
    );
  }
}
