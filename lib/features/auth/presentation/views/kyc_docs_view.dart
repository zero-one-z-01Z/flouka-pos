import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/dialog/snack_bar.dart';
import 'package:flouka_pos/core/dialog/success_dialog.dart';
import 'package:flouka_pos/core/helper_function/kyc.dart';
import 'package:flouka_pos/core/helper_function/loading.dart';
import 'package:flouka_pos/core/helper_function/navigation.dart';
import 'package:flouka_pos/features/auth/presentation/providers/auth_provider.dart';
import 'package:flouka_pos/features/auth/presentation/providers/register_provider.dart';
import 'package:flouka_pos/features/auth/presentation/widgets/file_picker/document_pick_file_widget.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class KycDocsView extends StatefulWidget {
  const KycDocsView({super.key});

  @override
  State<KycDocsView> createState() => _KycDocsViewState();
}

class _KycDocsViewState extends State<KycDocsView> {
  late final TextEditingController _cin;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthProvider>().userEntity;
    _cin = TextEditingController(text: user?.nationalId ?? '');
  }

  @override
  void dispose() {
    _cin.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final register = context.read<RegisterProvider>();
    final auth = context.read<AuthProvider>();
    final company = isCompanyAccount(auth.userEntity);
    final data = <String, dynamic>{
      'national_id': _cin.text.trim(),
    };
    if (register.frontIdCard != null) {
      data['front_id_card'] =
          await MultipartFile.fromFile(register.frontIdCard!.path);
    }
    if (register.backIdCard != null) {
      data['back_id_card'] =
          await MultipartFile.fromFile(register.backIdCard!.path);
    }
    if (company && register.businessLicense != null) {
      data['business_license'] =
          await MultipartFile.fromFile(register.businessLicense!.path);
    }

    loading();
    final result = await register.userUseCase.updateProfile(data);
    navPop();
    result.fold(
      (l) => showToast(l.message ?? ''),
      (r) {
        auth.updateUser(r);
        successDialog(msg: 'kyc_docs_saved', then: navPop);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final register = context.watch<RegisterProvider>();
    final company = isCompanyAccount(auth.userEntity);
    final user = auth.userEntity;

    return Scaffold(
      backgroundColor: AppColor.canvas,
      appBar: AppBar(
        backgroundColor: AppColor.surface,
        foregroundColor: AppColor.ink,
        elevation: 0,
        title: Text(
          LanguageProvider.translate('auth', 'kyc_docs_title'),
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w800,
            color: AppColor.ink,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 4.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LanguageProvider.translate(
                'auth',
                company ? 'kyc_docs_hint_company' : 'kyc_docs_hint_individual',
              ),
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                height: 1.45,
                color: AppColor.textMuted,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              LanguageProvider.translate('inputs', 'national_id'),
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColor.textMuted,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _cin,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '01234567',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(color: Color(0xFFDCD4C1)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(color: Color(0xFFDCD4C1)),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            DocumentPickFileWidget(
              label: 'front_id_card',
              file: register.frontIdCard,
              url: isKycMedia(user?.frontIdCard) ? user?.frontIdCard : null,
              onFileSelected: (File file) => register.selectFrontIdCardImage(file),
              onFileRemoved: register.removeFrontIdCard,
            ),
            SizedBox(height: 1.5.h),
            DocumentPickFileWidget(
              label: 'back_id_card',
              file: register.backIdCard,
              url: isKycMedia(user?.backIdCard) ? user?.backIdCard : null,
              onFileSelected: (File file) => register.selectBackIdCardImage(file),
              onFileRemoved: register.removeBackIdCard,
            ),
            if (company) ...[
              SizedBox(height: 1.5.h),
              DocumentPickFileWidget(
                label: 'business_license',
                file: register.businessLicense,
                url: isKycMedia(user?.businessLicense)
                    ? user?.businessLicense
                    : null,
                onFileSelected: (File file) =>
                    register.selectBusinessLicenseImage(file),
                onFileRemoved: register.removeBusinessLicense,
              ),
            ],
            SizedBox(height: 3.h),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _save,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColor.sidebar,
                  foregroundColor: const Color(0xFFF7F3E8),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  LanguageProvider.translate('buttons', 'save'),
                  style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
