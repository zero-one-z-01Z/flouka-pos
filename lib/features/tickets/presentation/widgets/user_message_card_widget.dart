// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
// import '../../../../config/text_style.dart';
// import '../../../../core/widget/button_widget.dart';
// import '../provider/ticket_message_provider.dart';
//
// class UserMessageCardWidget extends StatelessWidget {
//   const UserMessageCardWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     MessageProvider messageProvider = Provider.of(context);
//     return messageProvider.chatEntity!=null? InkWell(
//       onTap: ()async{
//         messageProvider.stopAllControllers('');
//         // Provider.of<ProfileProvider>(context,listen: false).goToAccountPage(userEntity: messageProvider.chatEntity!.user());
//       },
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Container(
//           //   width: 12.w,
//           //   height: 12.w,
//           //   decoration: BoxDecoration(
//           //     shape: BoxShape.circle,
//           //     image: DecorationImage(
//           //       image: CachedNetworkImageProvider(messageProvider.chatEntity!.employee.image),
//           //       fit: BoxFit.cover,
//           //     ),
//           //   ),
//           // ),
//           SizedBox(width: 2.w,),
//           // Expanded(child: Text(messageProvider.chatEntity!.employee.name,style: TextStyleClass.normalStyle(),)),
//           SizedBox(width: 2.w,),
//           ButtonWidget(onTap: (){
//           }, text: "end_chat",takeSmallestWidth: true,isGradient: false,height: 5.h,)
//         ],
//       ),
//     ) : const SizedBox();
//   }
// }
