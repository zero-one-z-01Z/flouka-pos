import 'package:flouka_pos/core/widgets/button_widget.dart';
import 'package:flouka_pos/core/widgets/vendor/vendor_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/widgets/list_text_field_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/add_product_provider.dart';
import 'tags_widget.dart';

class AddProductBasicDetailsSection extends StatelessWidget {
  const AddProductBasicDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final AddProductProvider provider = Provider.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColor.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VendorSectionHeader(
            title: LanguageProvider.translate('product', 'basic_details'),
          ),
          const SizedBox(height: 16),
          ListTextFieldWidget(
            inputs: provider.addProductTextFields,
          ),
          const SizedBox(height: 16),
          if (provider.tags.isNotEmpty) const TagsWidget(),
          ButtonWidget(
            color: AppColor.gold,
            textStyle: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w700,
              color: AppColor.ink,
            ),
            onTap: () {
              provider.showAddWidget();
            },
            text: 'add_tags',
          ),
        ],
      ),
    );
  }
}
