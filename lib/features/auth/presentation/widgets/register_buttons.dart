import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/register_provider.dart';
import '../../../language/presentation/provider/language_provider.dart';

class RegisterNavigationButtons extends StatelessWidget {
  const RegisterNavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RegisterProvider>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (provider.currentStep > 1)
          ElevatedButton(
            onPressed: provider.previousStep,
            child: const Text("Back"),
          ),
        ElevatedButton(
          onPressed: provider.nextStep,
          child: Text(
            provider.currentStep < 3
                ? LanguageProvider.translate('buttons', 'next_step')
                : LanguageProvider.translate('buttons', 'Register'),
          ),
        ),
      ],
    );
  }
}
