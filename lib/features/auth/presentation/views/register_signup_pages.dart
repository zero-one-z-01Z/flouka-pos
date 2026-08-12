import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flouka_pos/core/dialog/drop_down_dialog.dart';
import 'package:flouka_pos/core/widgets/button_widget.dart';
import 'package:flouka_pos/features/auth/presentation/providers/account_type_provider.dart';
import 'package:flouka_pos/features/auth/presentation/providers/otp_provider.dart';
import 'package:flouka_pos/features/auth/presentation/views/otp_widget.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flouka_pos/features/zone/presentation/providers/area_provider.dart';
import 'package:flouka_pos/features/zone/presentation/providers/city_provider.dart';
import 'package:flouka_pos/features/zone/presentation/providers/neighborhood_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/register_provider.dart';
import '../widgets/have_account_section.dart';

const _ink = Color(0xFF14261F);
const _muted = Color(0xFF7C8A80);
const _label = Color(0xFF5F6F64);
const _border = Color(0xFFDCD4C1);
const _card = Color(0xFFFCFAF3);
const _footer = Color(0xFFF9F6EC);
const _teal = Color(0xFF0E3B2E);
const _gold = Color(0xFFF2C14E);

class SignupProgress extends StatelessWidget {
  const SignupProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final step = context.watch<RegisterProvider>().currentStep;
    final captions = [
      LanguageProvider.translate('auth', 'reg_step1'),
      LanguageProvider.translate('auth', 'reg_step2'),
      LanguageProvider.translate('auth', 'reg_step3'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LanguageProvider.translate('global', 'create_account'),
          style: TextStyleClass.headStyle().copyWith(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: _teal,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          captions[(step - 1).clamp(0, 2)],
          style: const TextStyle(fontSize: 14, color: _muted),
        ),
        const SizedBox(height: 14),
        Row(
          children: List.generate(3, (i) {
            final on = step >= i + 1;
            return Expanded(
              child: Container(
                height: 5,
                margin: EdgeInsetsDirectional.only(end: i < 2 ? 8 : 0),
                decoration: BoxDecoration(
                  color: on ? _teal : const Color(0xFFE3DCCB),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class SignupPage1 extends StatelessWidget {
  const SignupPage1({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RegisterProvider>();
    final accountType = context.watch<AccountTypeProvider>();
    if (provider.registerTextFieldList.isEmpty) {
      return const SizedBox.shrink();
    }
    final name = provider.field('name');
    final phone = provider.field('phone');
    final email = provider.field('email');
    final password = provider.field('password');

    return Form(
      key: provider.registerFormKey,
      child: Column(
        children: [
          const SignupProgress(),
          const SizedBox(height: 20),
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _LabeledField(
                  label: LanguageProvider.translate('auth', 'full_name'),
                  child: _BoxField(
                    controller: name.controller,
                    hint: 'Ktita',
                    validator: name.validator,
                  ),
                ),
                const SizedBox(height: 16),
                _LabeledField(
                  label: LanguageProvider.translate('inputs', 'phone_number'),
                  child: _PhoneField(controller: phone.controller, validator: phone.validator),
                ),
                Text(
                  LanguageProvider.translate('auth', 'phone_verify_later'),
                  style: const TextStyle(fontSize: 12, color: Color(0xFF8A9A8F)),
                ),
                const SizedBox(height: 16),
                _LabeledField(
                  label: LanguageProvider.translate('inputs', 'email'),
                  child: _BoxField(
                    controller: email.controller,
                    hint: 'nom@email.com',
                    keyboard: TextInputType.emailAddress,
                    validator: email.validator,
                  ),
                ),
                const SizedBox(height: 16),
                _LabeledField(
                  label: LanguageProvider.translate('inputs', 'password'),
                  child: _BoxField(
                    controller: password.controller,
                    hint: LanguageProvider.translate('auth', 'password_min'),
                    obscure: true,
                    validator: password.validator,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  LanguageProvider.translate('inputs', 'account_type'),
                  style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: _label),
                ),
                const SizedBox(height: 9),
                Row(
                  children: [
                    Expanded(
                      child: _TypeCard(
                        label: LanguageProvider.translate('global', 'individual'),
                        hint: LanguageProvider.translate('auth', 'type_individual_hint'),
                        selected: accountType.value() == 'individual',
                        onTap: () => accountType.onTap('individual'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _TypeCard(
                        label: LanguageProvider.translate('auth', 'seller_type'),
                        hint: LanguageProvider.translate('auth', 'type_vendor_hint'),
                        selected: accountType.value() == 'company',
                        onTap: () => accountType.onTap('company'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _Footer(
            showBack: false,
            nextLabel: 'next',
            onNext: () {
              if (provider.registerFormKey.currentState?.validate() ?? false) {
                provider.nextStep();
              }
            },
          ),
          const SizedBox(height: 16),
          const HaveAccountSection(isLogin: false),
        ],
      ),
    );
  }
}

class SignupPage2 extends StatelessWidget {
  const SignupPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RegisterProvider>();
    final city = context.watch<CityProvider>();
    final area = context.watch<AreaProvider>();
    final neighborhood = context.watch<NeighborhoodProvider>();
    if (provider.registerPage2TextFields.isEmpty) {
      return const SizedBox.shrink();
    }
    final address = provider.field('address');

    return Form(
      key: provider.registerForm2Key,
      child: Column(
        children: [
          const SignupProgress(),
          const SizedBox(height: 20),
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _LabeledField(
                  label: LanguageProvider.translate('inputs', 'address'),
                  child: _BoxField(
                    controller: address.controller,
                    hint: LanguageProvider.translate('auth', 'address_placeholder'),
                    validator: address.validator,
                  ),
                ),
                const SizedBox(height: 16),
                _LabeledField(
                  label: LanguageProvider.translate('auth', 'governorate'),
                  child: _SelectBox(
                    value: city.displayedName(),
                    onTap: () => showDropDownDialog(city),
                  ),
                ),
                const SizedBox(height: 16),
                _LabeledField(
                  label: LanguageProvider.translate('auth', 'delegation'),
                  child: _SelectBox(
                    value: area.displayedName(),
                    onTap: () => showDropDownDialog(area),
                  ),
                ),
                const SizedBox(height: 16),
                _LabeledField(
                  label: LanguageProvider.translate('global', 'neighborhood'),
                  child: _SelectBox(
                    value: neighborhood.displayedName(),
                    onTap: () => showDropDownDialog(neighborhood),
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () => provider.setAcceptedTerms(!provider.acceptedTerms),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: provider.acceptedTerms,
                        activeColor: _teal,
                        onChanged: (v) => provider.setAcceptedTerms(v ?? false),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            LanguageProvider.translate('auth', 'accept_terms'),
                            style: const TextStyle(fontSize: 13.5, height: 1.45, color: _label),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _Footer(
            showBack: true,
            onBack: provider.previousStep,
            nextLabel: 'create_my_account',
            onNext: () async {
              if (!(provider.registerForm2Key.currentState?.validate() ?? false)) return;
              if (!provider.acceptedTerms) return;
              final otp = context.read<OtpProvider>();
              final ok = await otp.sendOtp(isReg: true);
              if (ok) provider.nextStep();
            },
          ),
        ],
      ),
    );
  }
}

class SignupOtpPage extends StatelessWidget {
  const SignupOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RegisterProvider>();
    final otp = context.watch<OtpProvider>();
    return Column(
      children: [
        const SignupProgress(),
        const SizedBox(height: 20),
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                LanguageProvider.translate('auth', 'enter_otp_code'),
                style: const TextStyle(fontSize: 14, color: _muted),
              ),
              const SizedBox(height: 8),
              Text(
                LanguageProvider.translate('auth', 'otp_email_hint'),
                style: const TextStyle(fontSize: 12.5, height: 1.4, color: Color(0xFF8A9A8F)),
              ),
              const SizedBox(height: 16),
              const OtpWidget(),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _Footer(
          showBack: true,
          onBack: provider.previousStep,
          nextLabel: 'verify',
          onNext: () {
            if (otp.otpController.text.length != 4) return;
            _normalizePhone(provider);
            provider.register();
          },
        ),
      ],
    );
  }

  void _normalizePhone(RegisterProvider provider) {
    final c = provider.field('phone').controller;
    var d = c.text.replaceAll(RegExp(r'\D'), '');
    if (d.startsWith('0')) d = d.substring(1);
    if (!d.startsWith('216') && d.isNotEmpty) d = '216$d';
    c.text = d;
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE3DCCB)),
      ),
      child: child,
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({
    required this.showBack,
    required this.nextLabel,
    required this.onNext,
    this.onBack,
  });
  final bool showBack;
  final String nextLabel;
  final VoidCallback onNext;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: _footer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEDE6D6)),
      ),
      child: Row(
        children: [
          if (showBack)
            OutlinedButton(
              onPressed: onBack,
              style: OutlinedButton.styleFrom(
                foregroundColor: _teal,
                side: const BorderSide(color: _border),
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(LanguageProvider.translate('buttons', 'back')),
            )
          else
            const SizedBox(width: 88),
          const Spacer(),
          ButtonWidget(
            color: _gold,
            borderRadius: 12,
            takeSmallestWidth: true,
            onTap: onNext,
            text: nextLabel,
            textStyle: TextStyleClass.smallStyle().copyWith(
              color: _teal,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({required this.label, required this.child});
  final String label;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: _label)),
        const SizedBox(height: 7),
        child,
      ],
    );
  }
}

class _BoxField extends StatelessWidget {
  const _BoxField({
    required this.controller,
    this.hint,
    this.obscure = false,
    this.keyboard,
    this.validator,
  });
  final TextEditingController controller;
  final String? hint;
  final bool obscure;
  final TextInputType? keyboard;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboard,
      validator: validator,
      style: const TextStyle(fontSize: 15, color: _ink),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFA9B3AC)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: _border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: _border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: _teal),
        ),
      ),
    );
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField({required this.controller, this.validator});
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      validator: validator,
      style: const TextStyle(fontSize: 15, color: _ink),
      decoration: InputDecoration(
        hintText: '20 000 000',
        hintStyle: const TextStyle(color: Color(0xFFA9B3AC)),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Container(
          margin: const EdgeInsetsDirectional.only(end: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0xFFF4F0E6),
            border: Border(right: BorderSide(color: Color(0xFFE7E0CE))),
          ),
          child: const Text('+216', style: TextStyle(fontWeight: FontWeight.w600, color: _label)),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 64, minHeight: 48),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: _border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: _border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: _teal),
        ),
      ),
    );
  }
}

class _SelectBox extends StatelessWidget {
  const _SelectBox({required this.value, required this.onTap});
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(color: _border),
        ),
        child: Row(
          children: [
            Expanded(child: Text(value, style: const TextStyle(fontSize: 15, color: _ink))),
            const Icon(Icons.keyboard_arrow_down, color: _muted),
          ],
        ),
      ),
    );
  }
}

class _TypeCard extends StatelessWidget {
  const _TypeCard({
    required this.label,
    required this.hint,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final String hint;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFEEF4F0) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? _teal : _border, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: _ink)),
            const SizedBox(height: 4),
            Text(hint, style: const TextStyle(fontSize: 12.5, color: _muted)),
          ],
        ),
      ),
    );
  }
}
