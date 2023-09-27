import 'package:ayurbot/shared/RoundedRectImage.dart';
import 'package:flutter/material.dart';

class profilePic extends StatelessWidget {
  late String imagePath;
  double? width;
  double? height;
  double? radius;
  BoxShadow? boxShadow;
  profilePic({
    required this.imagePath,
    this.width = 40,
    this.height = 40,
    this.radius = 5,
    this.boxShadow = const BoxShadow(
      color: Color.fromARGB(255, 15, 17, 27),
      offset: Offset(4, 4),
      blurRadius: 5,
    ),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius!),
        ),
        boxShadow: [
          boxShadow!,
        ],
      ),
      child: RoundedRectImage(
        imagePath: imagePath,
        radius: radius,
        wd: width,
        ht: height,
      ),
    );
  }
}
