import 'package:flutter/material.dart';

import '../config/app_color.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({super.key, required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          width: 20,
          height: 20,
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: isSelected ? AppColor.primaryColor : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        isSelected
            ? const Positioned(
                top: 0,
                left: 0,
                child: Icon(Icons.check, color: Colors.white, size: 20),
              )
            : const SizedBox(),
      ],
    );
  }
}
