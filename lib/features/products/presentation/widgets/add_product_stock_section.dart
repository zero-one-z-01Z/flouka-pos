import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/add_product_provider.dart';
import 'add_product_text_field.dart';

class AddProductStockSection extends StatelessWidget {
  const AddProductStockSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<AddProductProvider>(context, listen: false);

    return Row(
      children: [
        Expanded(
          child: AddProductTextField(
            label:
                LanguageProvider.translate('product', 'stock_quantity'),
            controller: provider.stockController,
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Consumer<AddProductProvider>(
            builder: (context, provider, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LanguageProvider.translate('global', 'status'),
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  DropdownButtonFormField<String>(
                    value: provider.status,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 1.5.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                    ),
                    items: ['Active', 'Inactive']
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              LanguageProvider.translate(
                                  'global', e.toLowerCase()),
                              style: TextStyle(fontSize: 11.sp),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) =>
                        provider.updateStatus(value!),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
