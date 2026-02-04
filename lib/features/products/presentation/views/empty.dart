// // Right section - Upload Product Images
//           Expanded(
//             flex: 4,
//             child: SingleChildScrollView(
//               padding: EdgeInsets.all(3.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Upload Product Image Section
//                   Container(
//                     padding: EdgeInsets.all(3.w),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 10,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Upload Product Image',
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         SizedBox(height: 2.h),

//                         // Main Product Image Label
//                         Text(
//                           'Product Image',
//                           style: TextStyle(
//                             fontSize: 11.sp,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         SizedBox(height: 1.h),

//                         // Multiple Images Upload Widget
//                         UploadMultiImageWidget(
//                           images: productImages,
//                           count: 5,
//                           deleteImage: _deleteImage,
//                           imagesList: _addImages,
//                           title: 'upload_product_images',
//                         ),
//                         SizedBox(height: 2.h),

//                         // Categories Section
//                         Text(
//                           'Categories',
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         SizedBox(height: 2.h),

//                         // Product Categories
//                         _buildTextField(
//                           label: 'Product Categories',
//                           controller: TextEditingController(text: 'Mobiles'),
//                         ),
//                         SizedBox(height: 2.h),

//                         // Brand
//                         _buildTextField(
//                           label: 'Brand',
//                           controller: TextEditingController(text: 'iPhone'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),