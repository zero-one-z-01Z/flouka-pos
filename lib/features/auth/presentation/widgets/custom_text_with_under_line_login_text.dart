import 'package:flutter/material.dart';

import '../../../../core/config/app_styles.dart';
import '../../../language/presentation/provider/language_provider.dart';

class CustomTextWithUnderLineText extends StatelessWidget {
  const CustomTextWithUnderLineText({
    super.key,
    required this.customText,
    required this.underLineText,
    this.onTap,
  });
  final String customText;
  final String underLineText;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LanguageProvider.translate("auth", customText),
          style: TextStyleClass.normalStyle(),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            LanguageProvider.translate("auth", underLineText),
            style: TextStyleClass.normalStyle().copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
