import 'package:ayurbot/firebase_options.dart';
import 'package:ayurbot/screens/splash.dart';
import 'package:ayurbot/services/userAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  User? _currentUser = UserAuth().getCurrentUser();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      // Override the canvasColor to be transparent
      canvasColor: Colors.transparent,
    ),
    // home: SplashScreen(),
    home: SplashScreen(),
  ));
}
