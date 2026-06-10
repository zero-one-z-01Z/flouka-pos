// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
// import '../../../../config/text_style.dart';
// import '../../../../core/widget/button_widget.dart';
// import '../../../ads/presentation/provider/ads_details_provider.dart';
// import '../../../ads/presentation/provider/ads_user_profile_provider.dart';
// import '../../../auth/domain/entities/user_entity.dart';
// import '../provider/ticket_message_provider.dart';
//
//
// class UserCardWidget extends StatelessWidget {
//   const UserCardWidget({super.key, this.leftWidget, this.color,required this.belowWidget,
//     this.user, required this.isChat, this.onTap});
//   final Widget? leftWidget;
//   final Widget belowWidget;
//   final Color? color;
//   final UserEntity? user ;
//   final bool isChat;
//   final void Function()? onTap;
//   @override
//   Widget build(BuildContext context) {
//     MessageProvider messageProvider = Provider.of(context);
//     return InkWell(
//       onTap: onTap??(){
//
//       },
//       child: Container(
//         width: 100.w,
//         decoration: BoxDecoration(
//           color: color??Colors.grey.shade100,
//           borderRadius: BorderRadius.circular(2.w)
//         ),
//         padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.h),
//         child: Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//
//               children: [
//                 Stack(
//                   alignment: Alignment.bottomCenter,
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(bottom: 2.h),
//                       width: 16.w,
//                       height: 16.w,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.grey.shade300),
//                         image: DecorationImage(
//                           image: CachedNetworkImageProvider(
//                               isChat ?
//                               messageProvider.chatEntity!.userFun().image : user!.image),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(width: 3.w,),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                   "${isChat ? messageProvider.chatEntity!.userFun().name :user!.name}",style: TextStyleClass.normalStyle(),),
//                       SizedBox(height: 1.h,),
//                       belowWidget,
//                       // RateWidget(read: true,rate: messageProvider.chatEntity!.user().rate,),
//                     ],
//                   ),
//                 ),
//                 SizedBox(width: 3.w,),
//                 leftWidget?? const SizedBox(),
//               ],
//             ),
//             if(isChat)
//               SizedBox(height: 2.h,),
//             if(isChat)
//               Row(children: [
//               Expanded(child: ButtonWidget(
//                 height: 5.h,
//                 text: "go_to_ad",
//                 onTap: (){
//                   Provider.of<AdsDetailsProvider>(context,listen: false).goToAdsDetailsPage(id: messageProvider.chatEntity!.adEntity.id, similar: false);
//
//                 },
//               )),
//               SizedBox(width: 4.w,),
//               Expanded(child: ButtonWidget(
//                 height: 5.h,
//                 text: "go_to_profile",
//                 onTap: (){
//                   Provider.of<AdsUserProfileProvider>(context,listen: false).goToAdsUserProfilePage(userId: messageProvider.chatEntity!.adEntity.userId);
//                 },
//               )),
//             ],) ,
//           ],
//         ),
//       ),
//     );
//   }
// }
