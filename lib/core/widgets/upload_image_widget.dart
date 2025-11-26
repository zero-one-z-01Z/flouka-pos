// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
// import '../../features/auth/presentation/providers/profile_provider.dart';
// import '../../features/language/presentation/provider/language_provider.dart';

// class UploadImageWidget extends StatelessWidget {
//   const UploadImageWidget({super.key, required this.fromAuth});
//   final bool fromAuth;

//   @override
//   Widget build(BuildContext context) {
//     ProfileProvider profileProvider = Provider.of(context);
//     return InkWell(
//       onTap: () async {
//         if (profileProvider.image != null) {
//           showDialog(
//             context: context,
//             builder: (ctx) {
//               return Container(
//                 height: 40.h,
//                 width: 40.w,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   image: DecorationImage(
//                     image: profileProvider.showUserImage(),
//                     fit: profileProvider.image == null
//                         ? BoxFit.fill
//                         : BoxFit.cover,
//                   ),
//                 ),
//               );
//             },
//           );
//         } else {
//           FocusScope.of(context).unfocus();
//           XFile? image = await chooseImage();
//           // completeDataProvider.updateImage(image);
//         }
//       },
//       child: Column(
//         children: [
//           SizedBox(
//             width: 12.h,
//             height: 12.h,
//             child: Stack(
//               children: [
//                 Container(
//                   width: 30.w,
//                   height: 30.w,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                       fit: profileProvider.image == null
//                           ? BoxFit.fill
//                           : BoxFit.cover,
//                       image: profileProvider.showUserImage(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 1.h),
//           fromAuth
//               ? Text(
//                   LanguageProvider.translate(
//                     'complete_data',
//                     'image',
//                   ),
//                   style: TextStyleClass.normalStyle(),
//                 )
//               : SizedBox(),
//         ],
//       ),
//     );
//   }
// }
