import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/notification_entity.dart';
import '../provider/notifications_provider.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationEntity notificationEntity;

  const NotificationWidget({super.key, required this.notificationEntity});

  @override
  Widget build(BuildContext context) {
    final NotificationProvider notificationProvider = Provider.of(context);
    return Material(
      color: AppColor.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () {
          notificationProvider.setNotification(notificationEntity);
        },
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColor.hairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notificationEntity.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColor.ink,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                notificationEntity.description,
                style: GoogleFonts.lato(
                  fontSize: 13,
                  color: AppColor.textMuted,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
