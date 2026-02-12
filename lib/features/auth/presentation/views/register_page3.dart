import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../providers/register_provider.dart';

class RegisterPage3 extends StatelessWidget {
  const RegisterPage3({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<RegisterProvider>();

    return Center(
      child: Column(
        children: [
          SizedBox(height: 5.h),
          Text("Final Step / Confirmation", style: TextStyle(fontSize: 12.sp)),
          SizedBox(height: 5.h),
          ElevatedButton(
            onPressed: () {
              provider.previousStep();
            },
            child: const Text("Back"),
          ),
        ],
      ),
    );
  }
}
