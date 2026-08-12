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
import '../providers/stories_operations_provider.dart';
import '../providers/stories_provider.dart';

class StoriesView extends StatelessWidget {
  const StoriesView({super.key});

  int _cols(double maxWidth) {
    if (maxWidth < 520) return 2;
    if (maxWidth < 900) return 3;
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    final StoriesProvider storiesProvider =
        Provider.of<StoriesProvider>(context);
    final StoriesOperationsProvider ops =
        Provider.of<StoriesOperationsProvider>(context);
    final compact = Constants.isCompactShell(context);

    return Scaffold(
      backgroundColor: AppColor.canvas,
      body: RefreshIndicator(
        color: AppColor.sidebar,
        onRefresh: () async => storiesProvider.refresh(),
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
                      LanguageProvider.translate('navbar', 'stories'),
                      style: GoogleFonts.bricolageGrotesque(
                        fontSize: compact ? 22 : 18,
                        fontWeight: FontWeight.w800,
                        color: AppColor.ink,
                      ),
                    ),
                  ),
                  if (storiesProvider.data != null)
                    VendorQuickAction(
                      label: LanguageProvider.translate('buttons', 'add_story'),
                      icon: Icons.add_rounded,
                      filled: true,
                      onTap: () => ops.showAddWidget(),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Builder(
                builder: (context) {
                  if (storiesProvider.data == null) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 80),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColor.sidebar,
                        ),
                      ),
                    );
                  }
                  if (storiesProvider.data!.isEmpty) {
                    return Column(
                      children: [
                        const EmptyAnimation(
                          title: '',
                          gif: Lotties.noSearch,
                        ),
                        const SizedBox(height: 12),
                        _AddStoryTile(
                          label: LanguageProvider.translate(
                            'buttons',
                            'add_story',
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
                            child: _AddStoryTile(
                              label: LanguageProvider.translate(
                                'buttons',
                                'add_story',
                              ),
                              onTap: () => ops.showAddWidget(),
                            ),
                          ),
                          ...List.generate(storiesProvider.data!.length,
                              (index) {
                            final story = storiesProvider.data![index];
                            return SizedBox(
                              width: cardW,
                              height: cardH,
                              child: _StoryCard(
                                title: story.title,
                                imageUrl: story.image,
                                onDelete: () =>
                                    ops.deleteStory(id: story.id),
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

class _AddStoryTile extends StatelessWidget {
  const _AddStoryTile({required this.label, required this.onTap});

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

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    required this.title,
    required this.imageUrl,
    required this.onDelete,
  });

  final String title;
  final String imageUrl;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColor.hairline,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColor.hairline),
            image: imageUrl.isEmpty
                ? null
                : DecorationImage(
                    image: CachedNetworkImageProvider(imageUrl),
                    fit: BoxFit.cover,
                    onError: (_, __) {},
                  ),
          ),
          child: imageUrl.isEmpty
              ? const Center(
                  child: Icon(Icons.image_outlined, color: AppColor.textMuted),
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
                        style: TextStyleClass.captionStyle(color: Colors.white),
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
