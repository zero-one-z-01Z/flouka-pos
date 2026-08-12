import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/helper_function/kyc.dart';
import 'package:flouka_pos/core/helper_function/navigation.dart';
import 'package:flouka_pos/features/auth/presentation/providers/auth_provider.dart';
import 'package:flouka_pos/features/auth/presentation/views/kyc_docs_view.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class KycDocsBanner extends StatelessWidget {
  const KycDocsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    if (isKycDocsComplete(auth.userEntity)) return const SizedBox.shrink();
    final company = isCompanyAccount(auth.userEntity);

    return Material(
      color: const Color(0xFFFFF8E8),
      child: InkWell(
        onTap: () => navP(const KycDocsView()),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFEBD69B))),
          ),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFF2C14E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LanguageProvider.translate('auth', 'kyc_missing_eyebrow'),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                        color: const Color(0xFF8A6A18),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      LanguageProvider.translate(
                        'auth',
                        company ? 'kyc_missing_company' : 'kyc_missing',
                      ),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColor.ink,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                LanguageProvider.translate('auth', 'kyc_add_docs'),
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: AppColor.sidebar,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
