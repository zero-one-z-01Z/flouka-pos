// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../../core/config/app_color.dart';
// import '../../../../../core/config/app_styles.dart';
// import '../../../../../features/auth/presentation/providers/otp_provider.dart';
// import '../../../../../features/auth/presentation/providers/auth_provider.dart';
// import '../../../../core/constants/assets.gen.dart';
// import '../../../language/presentation/provider/language_provider.dart';

// class SettingsHeaderWidget extends StatelessWidget {
//   const SettingsHeaderWidget({super.key});  

//   @override
//   Widget build(BuildContext context) {
//     final AuthProvider auth = Provider.of<AuthProvider>(context);

//     final OtpProvider otpProvider = Provider.of<OtpProvider>(context);
//     return InkWell(
//       onTap: () {},
//       child: Row(
//         spacing: 16,
//         children: [
//           CircleAvatar(radius: 25, backgroundColor: AppColor.secondaryColor),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 auth.userEntity?.firstName ?? "guest",
//                 style: TextStyleClass.normalStyle(),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 LanguageProvider.translate("settings", "edit_profile"),
//                 style: TextStyleClass.normalStyle().copyWith(color: Colors.grey),
//               ),
//             ],
//           ),
//           const Spacer(),
//           InkWell(
//             onTap: () {
//               auth.showLogoutDialog();
//             },
//             child: Assets.images.settings.off.svg(),
//           ),
//         ],
//       ),
//     );
//   }
// }
