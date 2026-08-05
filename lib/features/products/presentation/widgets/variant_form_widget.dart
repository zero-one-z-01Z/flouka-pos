import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import 'section_title_widget.dart';

class VariantFormWidget extends StatelessWidget {
  final TextEditingController priceController;
  final TextEditingController stockController;
  final TextEditingController skuController;
  final TextEditingController ramController;
  final TextEditingController storageController;

  const VariantFormWidget({
    super.key,
    required this.priceController,
    required this.stockController,
    required this.skuController,
    required this.ramController,
    required this.storageController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: const Color(0xffFAFAFA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildInput(
                  "Price",
                  "price",
                  controller: priceController,
                  prefix: LanguageProvider.translate('global', 'currency'),
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: _buildInput(
                  "Stock",
                  "stock",
                  controller: stockController,
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: _buildInput(
                  "SKU",
                  "sku",
                  controller: skuController,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitleWidget(text: "Color"),
                    SizedBox(height: 1.h),
                    Container(
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: const Color(0xffF0F0F0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                      alignment: Alignment.centerLeft,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("   Black"),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: _buildInput(
                  "RAM",
                  "ram",
                  controller: ramController,
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: _buildInput(
                  "Storage",
                  "storage",
                  controller: storageController,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 10.w,
              child: ButtonWidget(
                onTap: () {},
                text: "save",
                height: 5.h,
                widget: const Icon(
                  Icons.save_outlined,
                  color: Colors.white,
                  size: 20,
                ),
                widgetAfterText: false,
                borderRadius: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(
    String label,
    String hint, {
    TextEditingController? controller,
    String? prefix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(text: label),
        TextFieldWidget(
          controller: controller ?? TextEditingController(),
          hintText: hint,
          verticalPadding: 0.5.h,
          borderRadius: 8,
          height: 6.h,
          color: const Color(0xffF8F9FB),
          borderColor: Colors.transparent,
          enabledBorder: Colors.transparent,
          prefix: prefix != null
              ? Padding(
                  padding: EdgeInsets.all(1.w),
                  child: Text(
                    prefix,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                )
              : null,
        ),
      ],
    );
  }
}
