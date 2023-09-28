import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

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
