import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../providers/add_product_provider.dart';
import '../widgets/add_product_basic_details_section.dart';
import '../widgets/product_images_section.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final addProductProvider = Provider.of<AddProductProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Form(
        key: addProductProvider.formKey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(1.w),
                child:const AddProductBasicDetailsSection(),
              ),
            ),
            const Expanded(
              flex: 3,
              child: ProductImagesSection(),
            ),
          ],
        ),
      ),
    );
  }
}
