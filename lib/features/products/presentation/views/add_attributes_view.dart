import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../domain/entities/product_variant.dart';
import '../widgets/attribute_top_pill_widget.dart';
import '../widgets/attribute_selection_widget.dart';
import '../widgets/section_title_widget.dart';
import '../widgets/variant_card_widget.dart';
import '../widgets/variant_form_widget.dart';

class AddAttributesView extends StatefulWidget {
  const AddAttributesView({super.key});

  @override
  State<AddAttributesView> createState() => _AddAttributesViewState();
}

class _AddAttributesViewState extends State<AddAttributesView> {
  List<String> selectedRamOptions = ['8 G', '16 G'];
  List<String> selectedStorageOptions = ['128 G', '256 G'];
  List<String> selectedColorOptions = ['Black', 'White', 'Gray'];

  bool isFormVisible = false;

  final priceController = TextEditingController(text: "1000");
  final stockController = TextEditingController(text: "200");
  final skuController = TextEditingController(text: "200");
  final ramController = TextEditingController(text: "8 G");
  final storageController = TextEditingController(text: "128 G");

  List<ProductVariant> variants = List.generate(
    8,
    (_) => ProductVariant(
      sku: '23423424',
      price: '1000',
      stock: '200',
      ram: '8 G',
      storage: '256 G',
      color: 'Black',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 90.w),
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitleWidget(
                  text: "Add Attributes",
                  isLarge: true,
                ),
                SizedBox(height: 3.h),

                const SectionTitleWidget(text: "Choose Attribute"),
                SizedBox(height: 1.5.h),

                const Row(
                  children: [
                    AttributeTopPillWidget(label: "Color"),
                    SizedBox(width: 5),
                    AttributeTopPillWidget(label: "RAM"),
                    SizedBox(width: 5),
                    AttributeTopPillWidget(label: "Storage"),
                  ],
                ),

                SizedBox(height: 3.h),

                Row(
                  children: [
                    Expanded(
                      child: AttributeSelectionWidget(
                        title: "Choose RAM",
                        options: selectedRamOptions,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: AttributeSelectionWidget(
                        title: "Choose Storage",
                        options: selectedStorageOptions,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 2.h),

                AttributeSelectionWidget(
                  title: "Choose Color",
                  options: selectedColorOptions,
                ),

                SizedBox(height: 4.h),

                SizedBox(
                  width: 15.w,
                  child: ButtonWidget(
                    onTap: () {
                      setState(() {
                        isFormVisible = !isFormVisible;
                      });
                    },
                    text: 'add_variant',
                    height: 5.h,
                    borderRadius: 8,
                    widget: const Icon(Icons.add, color: Colors.white),
                    widgetAfterText: false,
                  ),
                ),

                SizedBox(height: 3.h),

                if (isFormVisible)
                  VariantFormWidget(
                    priceController: priceController,
                    stockController: stockController,
                    skuController: skuController,
                    ramController: ramController,
                    storageController: storageController,
                  ),

                SizedBox(height: 3.h),

                Wrap(
                  spacing: 1.w,
                  runSpacing: 1.h,
                  children:
                      variants.map((v) => VariantCardWidget(variant: v)).toList(),
                ),

                SizedBox(height: 5.h),

                Center(
                  child: ButtonWidget(
                    onTap: () {},
                    text: "publish_product",
                    width: 40.w,
                    height: 6.h,
                    borderRadius: 8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
