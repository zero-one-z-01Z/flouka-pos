import 'package:flutter/material.dart';

import 'svg_widget.dart';

class CircleActionButtonWidget extends StatelessWidget {
  const CircleActionButtonWidget({super.key, this.onTap, required this.svgImage});
  final VoidCallback? onTap;
  final String svgImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: const Color(0xffefeff3),
        child: SvgWidget(svg: svgImage, color: Colors.grey),
      ),
    );
  }
}
