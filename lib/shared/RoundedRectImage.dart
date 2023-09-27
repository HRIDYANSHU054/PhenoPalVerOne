import 'package:flutter/material.dart';

class RoundedRectImage extends StatelessWidget {
  double? radius;
  late String imagePath;
  double? wd;
  double? ht;
  RoundedRectImage({
    required this.imagePath,
    required this.wd,
    required this.ht,
    this.radius = 10,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius!)),
      child: Image(
        width: wd,
        height: ht,
        image: AssetImage(
          imagePath,
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}
