import 'package:ayurbot/screens/homeScreen.dart';
import 'package:ayurbot/services/authSwitch.dart';
import 'package:ayurbot/services/userAuth.dart';
import 'package:ayurbot/shared/authTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LoginScreen extends StatefulWidget {
  AuthSwitch? aSwitch;
  Function? onTap;
  LoginScreen({
    this.onTap,
    this.aSwitch,
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool showPassword = false;
  UserAuth _auth = UserAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //banner heading
              ////////////////////////
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                  ),
                  Row(
                    children: [
                      Text(
                        "Discover your ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.08,
                        ),
                      ),
                      GradientText(
                        "Prakruti",
                        gradientDirection: GradientDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.08,
                        ),
                        colors: [
                          Color(0xFFd61557),
                          Color(0xFFBF2BDD),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "with the power of",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.08,
                    ),
                  ),
                  GradientText(
                    "PhenoPal",
                    gradientDirection: GradientDirection.rtl,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.08,
                    ),
                    colors: [
                      Color(0xFFd61557),
                      Color(0xFFBF2BDD),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Text(
                "Enter your credentials to continue",
                style: TextStyle(
                  color: Color(0xFF8f93a5),
                  fontSize: MediaQuery.of(context).size.height * 0.027,
                ),
              ),
              //textFields
              ////////////////////////
              Column(
                children: [
                  //email
                  ////////////////////////
                  Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.04,
                      top: MediaQuery.of(context).size.height * 0.04,
                      bottom: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: authTextField(
                      context: context,
                      cntrl: _emailController,
                    ),
                  ),

                  //password
                  ////////////////////////
                  Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.04,
                      bottom: MediaQuery.of(context).size.height * 0.04,
                    ),
                    child: authTextField(
                      context: context,
                      cntrl: _passwordController,
                      obscureText: !showPassword,
                      hintText: "Password",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        child: showPassword
                            ? Icon(
                                Icons.remove_red_eye_outlined,
                                color: Color.fromARGB(255, 245, 61, 125),
                              )
                            : Icon(
                                Icons.remove_red_eye,
                                color: Color.fromARGB(255, 245, 61, 125),
                              ),
                      ),
                    ),
                  ),
                ],
              ),

              //signIn buttons
              ////////////////////////
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //signInWithEmail
                  ////////////////////////
                  TextButton(
                    onPressed: () async {
                      //////////////////////
                      User? user = await _auth.signInUser(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim());
                      // if everything works correct leads to the login page
                      if (user != null) {
                        print(user.email);
                        _emailController.clear();
                        _passwordController.clear();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      }
                      ;
                      //////////////////////
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.15,
                        vertical: MediaQuery.of(context).size.height * 0.02,
                      )),
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: Text("Log in"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Text(
                        "or",
                        style: TextStyle(
                          color: Color(0xFF8f93a5),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),

                      //signInWithGoogle button
                      ////////////////////////
                      TextButton(
                        onPressed: () async {
                          if (await _auth.signInWithGoogle() == true) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          }
                        },
                        style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all(EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.1,
                            vertical:
                                MediaQuery.of(context).size.height * 0.012,
                          )),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Log in with",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Image.asset(
                              "assets/GoogleLogo.png",
                              width: MediaQuery.of(context).size.width * 0.08,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              //leads to register page
              ////////////////////////
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Color(0xFF8f93a5),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.onTap!();
                        _emailController.clear();
                        _passwordController.clear();
                        showPassword = false;
                        widget.aSwitch!.showRegisterPage = true;
                      },
                      child: GradientText(
                        "Create Account",
                        gradientDirection: GradientDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.033,
                        ),
                        colors: [
                          Color(0xFFd61557),
                          Color(0xFFBF2BDD),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
