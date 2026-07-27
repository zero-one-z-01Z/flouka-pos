import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/app_color.dart';
import '../provider/language_provider.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider =
        Provider.of(context, listen: false);
    return GestureDetector(
      onTap: () => languageProvider.showLanguageDialog(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: AppColor.canvas,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          children: [
            Text(
              languageProvider.appLocal.languageCode == 'ar' ? 'Ar' : 'En',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xff344054),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppColor.textFaint,
              size: 13,
            ),
          ],
        ),
      ),
    );
  }
}
