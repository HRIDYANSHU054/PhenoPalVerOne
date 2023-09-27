import 'dart:async';

import 'package:ayurbot/screens/homeScreen.dart';
import 'package:ayurbot/screens/loginScreen.dart';
import 'package:ayurbot/services/userAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? _currentUser = UserAuth().getCurrentUser();

  _NextPage() async {
    Future.delayed(Duration(milliseconds: 7000), () {});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              _currentUser != null ? HomeScreen() : LoginScreen(),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    Timer(Duration(milliseconds: 5000), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                _currentUser != null ? HomeScreen() : LoginScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Center(
              child: Image(
                  image: AssetImage(
                "assets/appGIF.gif",
              )),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.072,
              child: Column(
                children: [
                  Text(
                    "Developed by",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.008,
                  ),
                  Text(
                    "300_SEE_OTHERS",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
