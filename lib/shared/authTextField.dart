import 'package:flutter/material.dart';

class authTextField extends StatelessWidget {
  late BuildContext context;
  late TextEditingController cntrl;
  bool? obscureText;
  String? hintText;
  Widget? suffixIcon;
  authTextField(
      {required this.context,
      required this.cntrl,
      this.hintText = "Email",
      this.obscureText = false,
      this.suffixIcon,
      super.key});

  @override
  Widget build(BuildContext context) {
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
}
