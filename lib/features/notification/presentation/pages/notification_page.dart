import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/constants/constants.dart';
import 'package:flouka_pos/core/widgets/vendor/vendor_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
    final NotificationProvider notificationProvider = Provider.of(context);
    final compact = Constants.isCompactShell(context);

    final list = RefreshIndicator(
      color: AppColor.sidebar,
      onRefresh: () async {
        notificationProvider.refresh();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          compact ? 16 : 20,
          12,
          compact ? 16 : 12,
          24,
        ),
        child: Builder(
          builder: (context) {
            if (notificationProvider.notifications == null) {
              return const Center(
                child: LoadingAnimationWidget(gif: Lotties.loading),
              );
            }
            if (notificationProvider.notifications!.isEmpty) {
              return const EmptyAnimation(
                gif: Lotties.noSearch,
                title: 'no_notifications',
              );
            }
            return Column(
              children: List.generate(
                notificationProvider.notifications!.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: NotificationWidget(
                      notificationEntity:
                          notificationProvider.notifications![index],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColor.canvas,
      appBar: AppBar(
        backgroundColor: AppColor.surface,
        foregroundColor: AppColor.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          LanguageProvider.translate('global', 'notifications'),
          style: GoogleFonts.bricolageGrotesque(
            fontWeight: FontWeight.w800,
            color: AppColor.ink,
          ),
        ),
      ),
      body: compact
          ? (notificationProvider.isDetails
              ? Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () {
                          notificationProvider.setIsDetails(false);
                        },
                        icon: const Icon(Icons.arrow_back_rounded),
                        label: Text(
                          LanguageProvider.translate('buttons', 'cancel'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: NotificationDetailsPage(
                        data: notificationProvider.notification?.title ?? '',
                        title:
                            notificationProvider.notification?.description ??
                                '',
                      ),
                    ),
                  ],
                )
              : list)
          : MasterDetailScaffold(
              master: list,
              detail: notificationProvider.isDetails
                  ? NotificationDetailsPage(
                      data: notificationProvider.notification?.title ?? '',
                      title:
                          notificationProvider.notification?.description ?? '',
                    )
                  : Center(
                      child: Text(
                        LanguageProvider.translate('global', 'notifications'),
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColor.textMuted,
                        ),
                      ),
                    ),
              showDetail: true,
            ),
    );
  }
}
