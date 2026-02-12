import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../providers/register_provider.dart';

class RegisterStepIndicator extends StatelessWidget {
  const RegisterStepIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RegisterProvider>();
    final currentStep = provider.currentStep;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: List.generate(3, (index) {
        final stepNum = index + 1;
        final isActive = stepNum == currentStep;
        final isCompleted = stepNum < currentStep;

        return Row(
          children: [
            // Circle
            Container(
              width: 2.w,
              height: 2.w,
              decoration: BoxDecoration(
                color: isActive || isCompleted ? Colors.blue : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                stepNum.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Line (except for last circle)
            if (index != 2)
              Container(
                width: 3.w,
                height: 2,
                color: isCompleted ? Colors.blue : Colors.grey[300],
              ),
          ],
        );
      }),
    );
  }
}
