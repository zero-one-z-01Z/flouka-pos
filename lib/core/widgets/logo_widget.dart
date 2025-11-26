import 'package:flutter/material.dart';
import '../constants/app_images.dart';

class LogoWidget extends StatelessWidget {
  final double? width, height;
  final BoxFit? fit;
  final bool? isWhite;
  const LogoWidget({this.height, this.width, super.key, this.fit, this.isWhite});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          Images.logo,
          fit: fit ?? BoxFit.contain,
          width: width,
          height: height,
        ),
      ],
    );
  }
}
