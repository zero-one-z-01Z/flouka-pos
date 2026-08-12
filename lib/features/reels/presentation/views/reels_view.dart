import 'package:cached_network_image/cached_network_image.dart';
import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flouka_pos/core/constants/constants.dart';
import 'package:flouka_pos/core/widgets/empty_animation.dart';
import 'package:flouka_pos/core/widgets/vendor/vendor_widgets.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_lotties.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../../core/widgets/video_view_page.dart';
import '../providers/reels_operations_provider.dart';
import '../providers/reels_provider.dart';

class ReelsView extends StatelessWidget {
  const ReelsView({super.key});

  int _cols(double maxWidth) {
    if (maxWidth < 520) return 2;
    if (maxWidth < 900) return 3;
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    final ReelsProvider reelsProvider = Provider.of<ReelsProvider>(context);
    final ReelsOperationsProvider ops =
        Provider.of<ReelsOperationsProvider>(context);
    final compact = Constants.isCompactShell(context);

    return Scaffold(
      backgroundColor: AppColor.canvas,
      body: RefreshIndicator(
        color: AppColor.sidebar,
        onRefresh: () async => reelsProvider.refresh(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            compact ? 16 : 20,
            16,
            compact ? 16 : 20,
            28,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      LanguageProvider.translate('navbar', 'video'),
                      style: GoogleFonts.bricolageGrotesque(
                        fontSize: compact ? 22 : 18,
                        fontWeight: FontWeight.w800,
                        color: AppColor.ink,
                      ),
                    ),
                  ),
                  if (reelsProvider.data != null)
                    VendorQuickAction(
                      label: LanguageProvider.translate('buttons', 'add_reel'),
                      icon: Icons.add_rounded,
                      filled: true,
                      onTap: () => ops.showAddWidget(),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Builder(
                builder: (context) {
                  if (reelsProvider.data == null) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 80),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColor.sidebar,
                        ),
                      ),
                    );
                  }
                  if (reelsProvider.data!.isEmpty) {
                    return Column(
                      children: [
                        const EmptyAnimation(
                          title: '',
                          gif: Lotties.noSearch,
                        ),
                        const SizedBox(height: 12),
                        _AddStudioTile(
                          label: LanguageProvider.translate(
                            'buttons',
                            'add_reel',
                          ),
                          onTap: () => ops.showAddWidget(),
                        ),
                      ],
                    );
                  }
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final cols = _cols(constraints.maxWidth);
                      const gap = 12.0;
                      final cardW =
                          (constraints.maxWidth - gap * (cols - 1)) / cols;
                      final cardH = cardW * 1.55;
                      return Wrap(
                        spacing: gap,
                        runSpacing: gap,
                        children: [
                          SizedBox(
                            width: cardW,
                            height: cardH,
                            child: _AddStudioTile(
                              label: LanguageProvider.translate(
                                'buttons',
                                'add_reel',
                              ),
                              onTap: () => ops.showAddWidget(),
                            ),
                          ),
                          ...List.generate(reelsProvider.data!.length, (index) {
                            final reel = reelsProvider.data![index];
                            final preview =
                                reel.cover.isNotEmpty ? reel.cover : reel.video;
                            final playUrl =
                                reel.video.isNotEmpty ? reel.video : reel.cover;
                            return SizedBox(
                              width: cardW,
                              height: cardH,
                              child: _StudioMediaCard(
                                title: reel.title,
                                previewUrl: preview,
                                emptyIcon: Icons.videocam_outlined,
                                onTap: () {
                                  if (playUrl.isEmpty) return;
                                  navP(VideoViewPage(video: playUrl));
                                },
                                onDelete: () =>
                                    ops.deleteReelDialog(id: reel.id),
                              ),
                            );
                          }),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddStudioTile extends StatelessWidget {
  const _AddStudioTile({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColor.gold, width: 1.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: AppColor.gold,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add_rounded, color: AppColor.ink),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w700,
                  color: AppColor.ink,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StudioMediaCard extends StatelessWidget {
  const _StudioMediaCard({
    required this.title,
    required this.previewUrl,
    required this.emptyIcon,
    required this.onTap,
    required this.onDelete,
  });

  final String title;
  final String previewUrl;
  final IconData emptyIcon;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Material(
          color: AppColor.surface,
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(14),
            child: Ink(
              decoration: BoxDecoration(
                color: AppColor.hairline,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColor.hairline),
                image: previewUrl.isEmpty
                    ? null
                    : DecorationImage(
                        image: CachedNetworkImageProvider(previewUrl),
                        fit: BoxFit.cover,
                        onError: (_, __) {},
                      ),
              ),
              child: previewUrl.isEmpty
                  ? Center(
                      child: Icon(emptyIcon, color: AppColor.textMuted),
                    )
                  : DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0.05),
                            Colors.black.withValues(alpha: 0.55),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            title,
                            textAlign: TextAlign.end,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyleClass.captionStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: Material(
            color: AppColor.surface,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: onDelete,
              borderRadius: BorderRadius.circular(8),
              child: const Padding(
                padding: EdgeInsets.all(6),
                child: Icon(Icons.delete_outline, color: Colors.red, size: 18),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
