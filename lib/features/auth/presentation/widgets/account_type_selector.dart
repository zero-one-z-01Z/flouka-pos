import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/widgets/validation_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/register_provider.dart';

class AccountTypeSelector extends StatelessWidget {
  final String? label;
  const AccountTypeSelector({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    final registerProvider = context.watch<RegisterProvider>();
    final selected = registerProvider.selectedAccountType;

    // Same width as one field in 2-column layout
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = 12.w;
    final spacing = 4.w;
    final fieldWidth = (screenWidth - horizontalPadding - spacing) / 2;

    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 25.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (label != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: Text(
                        label!,
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  GestureDetector(
                    onTap: () => _showAccountTypeSheet(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selected ?? "Select Account Type",
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Row(
          children: [
            ValidationWidget(conditions: [
              {"value": registerProvider.selectedAccountType == null,
                "text": LanguageProvider.translate("auth", "select_account_type")}
            ]),
          ],
        ),
      ],
    );
  }

  void _showAccountTypeSheet(BuildContext context) {
    final registerProvider = context.read<RegisterProvider>();
    final options = registerProvider.accountTypes;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ListView.separated(
          padding: EdgeInsets.all(4.w),
          itemCount: options.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final option = options[index];
            return ListTile(
              title: Text(option),
              onTap: () {
                registerProvider.setAccountType(option);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
