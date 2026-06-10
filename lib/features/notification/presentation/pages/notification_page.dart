import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_lotties.dart';
import '../../../../core/widgets/empty_animation.dart';
import '../../../../core/widgets/loading_animation_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../provider/notifications_provider.dart';
import '../widgets/notification_widget.dart';
import 'notification_details_page.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    NotificationProvider notificationProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageProvider.translate('global', 'notifications')),
        elevation: 0,
      ),
      body: Container(
        width: 100.w,
        height: 100.h,
        padding: EdgeInsets.only(top: 3.h),
        child: RefreshIndicator(
          onRefresh: () async {
            notificationProvider.refresh();
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Builder(
                    builder: (context) {
                      if (notificationProvider.notifications == null) {
                         return const Center(child: LoadingAnimationWidget(gif: Lotties.loading));
                      } else if (notificationProvider.notifications!.isEmpty) {
                        return const EmptyAnimation(
                          gif: Lotties.noSearch,
                          title: 'no_notifications',
                        );
                      } else {
                        return Wrap(
                          children: List.generate(
                            notificationProvider.notifications!.length,
                            (index) {
                              return NotificationWidget(
                                notificationEntity:
                                    notificationProvider.notifications![index],
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              if(notificationProvider.isDetails)
                IntrinsicHeight(
                child: Container(width: 0.1.w,color: Colors.grey.shade200,height: 100.h,),
              ),
              if(notificationProvider.isDetails)
              Expanded(
                child: NotificationDetailsPage(data: notificationProvider.notification?.title ??"",
                  title: notificationProvider.notification?.description ??"",),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
