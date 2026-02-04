// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import '../../../../core/config/app_color.dart';
// import '../../../../core/widgets/button_widget.dart';
// import '../../../../core/widgets/text_field_widget.dart';

// class AddAttributesView extends StatefulWidget {
//   const AddAttributesView({super.key});

//   @override
//   State<AddAttributesView> createState() => _AddAttributesViewState();
// }

// class _AddAttributesViewState extends State<AddAttributesView> {
//   // Selection options for each attribute type (simulating available product options)
//   List<String> selectedRamOptions = ['8 G', '16 G'];
//   List<String> selectedStorageOptions = ['128 G', '256 G'];
//   List<String> selectedColorOptions = ['Black', 'White', 'Gray'];

//   // Form state
//   bool isFormVisible = false;
//   final TextEditingController priceController = TextEditingController(text: "1000");
//   final TextEditingController stockController = TextEditingController(text: "200");
//   final TextEditingController skuController = TextEditingController(text: "200");
//   final TextEditingController ramController = TextEditingController(text: "8 G");
//   final TextEditingController storageController = TextEditingController(
//     text: "128 G",
//   );

//   // Variants list
//   List<ProductVariant> variants = [
//     ProductVariant(
//       sku: '23423424',
//       price: '1000',
//       stock: '200',
//       ram: '8 G',
//       storage: '256 G',
//       color: 'Black',
//     ),
//     ProductVariant(
//       sku: '23423424',
//       price: '1000',
//       stock: '200',
//       ram: '8 G',
//       storage: '256 G',
//       color: 'Black',
//     ),
//     ProductVariant(
//       sku: '23423424',
//       price: '1000',
//       stock: '200',
//       ram: '8 G',
//       storage: '256 G',
//       color: 'Black',
//     ),
//     ProductVariant(
//       sku: '23423424',
//       price: '1000',
//       stock: '200',
//       ram: '8 G',
//       storage: '256 G',
//       color: 'Black',
//     ),
//     ProductVariant(
//       sku: '23423424',
//       price: '1000',
//       stock: '200',
//       ram: '8 G',
//       storage: '256 G',
//       color: 'Black',
//     ),
//     ProductVariant(
//       sku: '23423424',
//       price: '1000',
//       stock: '200',
//       ram: '8 G',
//       storage: '256 G',
//       color: 'Black',
//     ),
//     ProductVariant(
//       sku: '23423424',
//       price: '1000',
//       stock: '200',
//       ram: '8 G',
//       storage: '256 G',
//       color: 'Black',
//     ),
//     ProductVariant(
//       sku: '23423424',
//       price: '1000',
//       stock: '200',
//       ram: '8 G',
//       storage: '256 G',
//       color: 'Black',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF8F9FD), // Light gray background
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
//         child: Center(
//           child: Container(
//             constraints: BoxConstraints(maxWidth: 90.w),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 20,
//                   offset: const Offset(0, 5),
//                 ),
//               ],
//             ),
//             padding: EdgeInsets.all(3.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Add Attributes",
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 SizedBox(height: 3.h),

//                 // TOP SECTION: Choose Attribute
//                 _buildSectionTitle("Choose Attribute"),
//                 SizedBox(height: 1.5.h),
//                 Row(
//                   children: [
//                     _buildTopPill("Color"),
//                     SizedBox(width: 1.w),
//                     _buildTopPill("RAM"),
//                     SizedBox(width: 1.w),
//                     _buildTopPill("Storage"),
//                   ],
//                 ),
//                 SizedBox(height: 3.h),

//                 // ATTRIBUTE SELECTION SECTIONS
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: _buildAttributeSelection(
//                         "Choose RAM",
//                         selectedRamOptions,
//                         "16 G",
//                       ),
//                     ),
//                     SizedBox(width: 2.w),
//                     Expanded(
//                       child: _buildAttributeSelection(
//                         "Choose Storage",
//                         selectedStorageOptions,
//                         "256 G",
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 2.h),

//                 // Color Selection
//                 _buildAttributeSelection(
//                   "Choose Color",
//                   selectedColorOptions,
//                   "Gray",
//                 ),

//                 SizedBox(height: 4.h),

//                 // ADD VARIANT ACTION
//                 SizedBox(
//                   width: 15.w,
//                   child: ButtonWidget(
//                     onTap: () {
//                       setState(() {
//                         isFormVisible = !isFormVisible;
//                       });
//                     },
//                     text: 'add_variant',
//                     height: 5.h,
//                     width: 15.w,
//                     padding: EdgeInsets.symmetric(horizontal: 2.w),
//                     borderRadius: 8,
//                     widget: const Icon(Icons.add, color: Colors.white, size: 20),
//                     widgetAfterText: false,
//                   ),
//                 ),

//                 SizedBox(height: 3.h),

//                 // VARIANT DETAILS FORM
//                 _buildVariantForm(),

//                 SizedBox(height: 3.h),

//                 // VARIANTS PREVIEW
//                 Wrap(
//                   spacing: 1.w,
//                   runSpacing: 1.h,
//                   children: variants.map((v) => _buildVariantCard(v)).toList(),
//                 ),

//                 SizedBox(height: 5.h),

//                 // PUBLISH ACTION
//                 Center(
//                   child: ButtonWidget(
//                     onTap: () {},
//                     text: "publish_product",
//                     width: 40.w,
//                     height: 6.h,
//                     borderRadius: 8,
//                   ),
//                 ),
//                 SizedBox(height: 2.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTopPill(String label) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           color: Colors.grey.shade600,
//           fontSize: 11.sp,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }

//   Widget _buildAttributeSelection(
//     String title,
//     List<String> options,
//     String placeholder,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionTitle(title),
//         SizedBox(height: 1.h),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.h),
//           decoration: BoxDecoration(
//             color: const Color(0xffFAFAFA),
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: Colors.transparent),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: options
//                     .map(
//                       (opt) => Padding(
//                         padding: EdgeInsets.only(right: 1.w),
//                         child: Container(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 2.w,
//                             vertical: 0.6.h,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: Colors.grey.shade200),
//                           ),
//                           child: Text(
//                             opt,
//                             style: TextStyle(color: Colors.black54, fontSize: 10.sp),
//                           ),
//                         ),
//                       ),
//                     )
//                     .toList(),
//               ),
//               const Icon(Icons.arrow_drop_down, color: Colors.black54),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildVariantForm() {
//     return Container(
//       padding: EdgeInsets.all(2.w),
//       decoration: BoxDecoration(
//         color: const Color(0xffFAFAFA),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: _buildInput(
//                   "Price",
//                   "price",
//                   controller: priceController,
//                   prefix: "\$",
//                 ),
//               ),
//               SizedBox(width: 2.w),
//               Expanded(
//                 child: _buildInput("Stock", "stock", controller: stockController),
//               ),
//               SizedBox(width: 2.w),
//               Expanded(child: _buildInput("SKU", "sku", controller: skuController)),
//             ],
//           ),
//           SizedBox(height: 1.h),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildSectionTitle("Color"),
//                     SizedBox(height: 1.h),
//                     Container(
//                       height: 6.h,
//                       decoration: BoxDecoration(
//                         color: const Color(0xffF0F0F0),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 1.w),
//                       alignment: Alignment.centerLeft,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "   Black",
//                             style: TextStyle(fontSize: 11.sp, color: Colors.black87),
//                           ),
//                           const Icon(Icons.arrow_drop_down),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(width: 2.w),
//               Expanded(child: _buildInput("RAM", "ram", controller: ramController)),
//               SizedBox(width: 2.w),
//               Expanded(
//                 child: _buildInput(
//                   "Storage",
//                   "storage",
//                   controller: storageController,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 2.h),
//           Align(
//             alignment: Alignment.centerRight,
//             child: SizedBox(
//               width: 10.w,
//               child: ButtonWidget(
//                 onTap: () {},
//                 text: "save", // Uses 'buttons.save' which is "Save Edit" or "Save"
//                 height: 5.h,
//                 widget: const Icon(
//                   Icons.save_outlined,
//                   color: Colors.white,
//                   size: 20,
//                 ),
//                 widgetAfterText: false,
//                 borderRadius: 8,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInput(
//     String label,
//     String hint, {
//     TextEditingController? controller,
//     String? prefix,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionTitle(label),
//         TextFieldWidget(
//           controller: controller ?? TextEditingController(),
//           hintText: hint, // Uses translation key
//           verticalPadding: 0.5.h,
//           borderRadius: 8,
//           height: 6.h,
//           color: const Color(0xffF8F9FB),
//           borderColor: Colors.transparent,
//           enabledBorder: Colors.transparent,
//           prefix: prefix != null
//               ? Padding(
//                   padding: EdgeInsets.all(1.w),
//                   child: Text(
//                     prefix,
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
//                   ),
//                 )
//               : null,
//         ),
//       ],
//     );
//   }

//   Widget _buildVariantCard(ProductVariant v) {
//     return Container(
//       width: 13.w,
//       padding: EdgeInsets.all(0.8.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Stack(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildCardRow("SKU", v.sku, isBlue: true),
//               SizedBox(height: 0.5.h),
//               _buildCardRow("Price", ": ${v.price}\$"),
//               SizedBox(height: 0.5.h),
//               _buildCardRow("Stock", ": ${v.stock}"),
//               SizedBox(height: 0.5.h),
//               Divider(color: Colors.grey.shade200),
//               SizedBox(height: 0.5.h),
//               _buildCardRow("RAM", ": ${v.ram}"),
//               SizedBox(height: 0.5.h),
//               _buildCardRow("Storage", ": ${v.storage}"),
//               SizedBox(height: 0.5.h),
//               _buildCardRow("Color", ": ${v.color}"),
//             ],
//           ),
//           Positioned(
//             top: 0,
//             right: 0,
//             child: InkWell(
//               onTap: () {},
//               child: Container(
//                 padding: const EdgeInsets.all(4),
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white,
//                 ),
//                 child: const Icon(Icons.close, color: Colors.red, size: 14),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCardRow(String label, String value, {bool isBlue = false}) {
//     return RichText(
//       text: TextSpan(
//         children: [
//           TextSpan(
//             text: "$label ",
//             style: TextStyle(
//               fontSize: 9.sp,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//           TextSpan(
//             text: value,
//             style: TextStyle(
//               fontSize: 9.sp,
//               color: isBlue ? AppColor.primaryColor : Colors.black54,
//               fontWeight: isBlue ? FontWeight.w600 : FontWeight.normal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String text) {
//     return Text(
//       text,
//       style: TextStyle(
//         fontSize: 10.sp,
//         fontWeight: FontWeight.w600,
//         color: Colors.black87,
//       ),
//     );
//   }
// }

// class ProductVariant {
//   final String sku;
//   final String price;
//   final String stock;
//   final String ram;
//   final String storage;
//   final String color;

//   ProductVariant({
//     required this.sku,
//     required this.price,
//     required this.stock,
//     required this.ram,
//     required this.storage,
//     required this.color,
//   });
// }
