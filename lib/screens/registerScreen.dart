import 'package:ayurbot/screens/homeScreen.dart';
import 'package:ayurbot/screens/loginScreen.dart';
import 'package:ayurbot/services/userModel.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:ayurbot/services/userAuth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool showPassword = false;
  UserAuth _auth = UserAuth();
  late UserModel _userModel;

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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //backgroundImage
        //////////////////////
        Image.asset(
          "assets/authBGidea2.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        //front
        //////////////////////
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: buildRegisterMaterial(context),
          ),
        ),
      ],
    );
  }

  Padding buildRegisterMaterial(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.03,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // banner heading
          //////////////////////
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.18,
              ),
              Row(
                children: [
                  Text(
                    "Let's ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.08,
                    ),
                  ),
                  TextGradient(
                    text: "BEGIN ",
                    sizeFactor: 0.04,
                  ),
                  Text(
                    "your",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.08,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "health journey ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.08,
                    ),
                  ),
                  TextGradient(
                    text: "NOW!",
                    sizeFactor: 0.04,
                  ),
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
          //textfields
          //////////////////////

          Column(
            children: [
              //name
              //////////////////////
              Padding(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.04,
                  top: MediaQuery.of(context).size.height * 0.04,
                  bottom: MediaQuery.of(context).size.height * 0.02,
                ),
                child: authTextField(
                  context: context,
                  hintText: "Name",
                  cntrl: _nameController,
                ),
              ),

              //email
              //////////////////////
              Padding(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.04,
                  bottom: MediaQuery.of(context).size.height * 0.02,
                ),
                child: authTextField(
                  context: context,
                  cntrl: _emailController,
                ),
              ),

              //passWord
              //////////////////////
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
          //register buttons
          //////////////////////
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //registerWithEmail
              //////////////////////

              TextButton(
                onPressed: () {
                  _userModel = UserModel.fromMap({
                    'email': _emailController.text.trim(),
                    'password': _passwordController.text.trim(),
                    'name': _nameController.text.trim(),
                  });
                  _auth.registerUser(userModel: _userModel);
                  _nameController.clear();
                  _passwordController.clear();
                  _emailController.clear();
                  showPassword = false;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.15,
                    vertical: MediaQuery.of(context).size.height * 0.02,
                  )),
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child: Text("Join in"),
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

                  //signInWithGoogle
                  //////////////////////
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

          //leads to login page
          //////////////////////
          Padding(
            padding: const EdgeInsets.only(
              top: 40.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Already have an account?",
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
                      _nameController.clear();
                      _passwordController.clear();
                    });

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const LoginScreen()),
                      ),
                    );
                  },
                  child: TextGradient(
                    text: "Login",
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

class TextGradient extends StatelessWidget {
  String? text;
  double? sizeFactor;
  TextGradient({
    required this.text,
    this.sizeFactor = 0.033,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GradientText(
      text!,
      gradientDirection: GradientDirection.rtl,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: MediaQuery.of(context).size.height * sizeFactor!,
      ),
      colors: [
        Color(0xFFd61557),
        Color(0xFFBF2BDD),
      ],
    );
  }
}

class RegisterClass extends StatefulWidget {
  Padding? registerPad;
  RegisterClass({required this.registerPad, super.key});

  @override
  State<RegisterClass> createState() => _RegisterClassState();
}

class _RegisterClassState extends State<RegisterClass> {
  @override
  Widget build(BuildContext context) {
    return widget.registerPad!;
  }
}
