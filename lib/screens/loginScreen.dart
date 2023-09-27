import 'package:animations/animations.dart';
import 'package:ayurbot/screens/homeScreen.dart';
import 'package:ayurbot/screens/registerScreen.dart';
import 'package:ayurbot/services/userAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool showPassword = false;
  bool _showRegisterPage = false;
  UserAuth _auth = UserAuth();

  OutlineInputBorder borderDecoration(
      {double radius = 30,
      double width = 1,
      Color color = const Color(0xFFd61557)}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
      borderSide: BorderSide(
        width: width,
        color: color,
      ),
    );
  }

  //transition builder
  Widget buildPageTrans() {
    return PageTransitionSwitcher(
      duration: Duration(milliseconds: 3000),
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        return SharedAxisTransition(
          child: child,
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
        );
      },
      child: _showRegisterPage
          ? Center(
              child: Text(
                "Hi this shows",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          : LoginClass(loginPad: buildLoginMaterial(context)),
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
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: buildLoginMaterial(context),
          ),
        ),
      ],
    );
  }

  Padding buildLoginMaterial(BuildContext context) {
    return Padding(
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
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
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
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                        vertical: MediaQuery.of(context).size.height * 0.012,
                      )),
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
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
                    setState(() {
                      _emailController.clear();
                      _passwordController.clear();
                      showPassword = false;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const RegisterScreen()),
                        ),
                      );
                    });
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
    );
  }

  TextFormField authTextField({
    required BuildContext context,
    required TextEditingController cntrl,
    String? hintText = "Email",
    bool? obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: cntrl,
      obscureText: obscureText!,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Color.fromARGB(255, 245, 61, 125),
        ),
        suffixIcon: suffixIcon,
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(20, 12, 12, 12),
        focusedBorder: borderDecoration(),
        border: borderDecoration(),
        errorBorder: borderDecoration(),
        enabledBorder: borderDecoration(),
      ),
      style: TextStyle(
        color: Color.fromARGB(255, 245, 61, 125),
        fontWeight: FontWeight.bold,
      ),
      cursorColor: Color(0xFFd61557),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}

class LoginClass extends StatefulWidget {
  Padding? loginPad;
  LoginClass({
    required this.loginPad,
    super.key,
  });

  @override
  State<LoginClass> createState() => _LoginClassState();
}

class _LoginClassState extends State<LoginClass> {
  @override
  Widget build(BuildContext context) {
    return widget.loginPad!;
  }
}
