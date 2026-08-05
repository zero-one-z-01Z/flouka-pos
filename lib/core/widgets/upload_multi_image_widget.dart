import 'dart:io';
import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flouka_pos/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../config/app_color.dart';
import '../helper_function/image.dart';

/// Client-side quality rules. Tune to your catalog needs.
class ImageQualityRules {
  static const int minWidth = 800;
  static const int minHeight = 800;
  static const int minSizeBytes = 20 * 1024; // 20 KB
  static const int maxSizeBytes = 8 * 1024 * 1024; // 8 MB
  static const List<String> allowedExtensions = ['jpg', 'jpeg', 'png', 'webp'];
}

/// EN / AR / FR copy for the tips row + best-practices modal.
/// Swap this for your existing translation system if you already have
/// keys for `translationSection` — this is self-contained on purpose.
class _T {
  static const Map<String, Map<String, String>> _s = {
    'en': {
      'tip_row': 'Better photos = more sales. Follow our photo guide.',
      'learn_more': 'Learn more',
      'modal_title': 'Photo guide',
      'rule_res': 'Minimum resolution 800×800px',
      'rule_ratio': 'Use a square (1:1) or 4:5 aspect ratio',
      'rule_bg': 'Plain, uncluttered background (white/light preferred)',
      'rule_angles': 'Add 3–5 photos: front, back, side, close-up detail',
      'rule_light': 'Shoot in good, even lighting — avoid harsh shadows',
      'good': 'Good',
      'bad': 'Bad',
      'good_desc': 'Sharp, well-lit, clean background, product fills frame',
      'bad_desc': 'Blurry, dark, cluttered background, cropped product',
      'got_it': 'Got it',
      'err_ext': 'Unsupported format. Use JPG, PNG or WEBP.',
      'err_size_min': 'Image file is too small / low quality.',
      'err_size_max': 'Image file is too large (max 8MB).',
      'err_dim': 'Image resolution is too low (min 800×800px).',
      'skipped': 'skipped',
    },
    'ar': {
      'tip_row': 'الصور الأفضل = مبيعات أكتر. اتبع دليل التصوير بتاعنا.',
      'learn_more': 'اعرف أكتر',
      'modal_title': 'دليل التصوير',
      'rule_res': 'أقل دقة مسموحة 800×800 بكسل',
      'rule_ratio': 'استخدم نسبة مربعة (1:1) أو (4:5)',
      'rule_bg': 'خلفية بسيطة وغير مزدحمة (يفضل أبيض/فاتح)',
      'rule_angles': 'ارفع من 3 إلى 5 صور: أمامية، خلفية، جانبية، تفاصيل قريبة',
      'rule_light': 'صوّر بإضاءة جيدة ومتساوية — تجنب الظلال الحادة',
      'good': 'صورة جيدة',
      'bad': 'صورة غير جيدة',
      'good_desc': 'واضحة، إضاءة كويسة، خلفية نظيفة، المنتج يملأ الإطار',
      'bad_desc': 'ضبابية، مظلمة، خلفية مزدحمة، المنتج مقصوص',
      'got_it': 'تمام',
      'err_ext': 'صيغة غير مدعومة. استخدم JPG أو PNG أو WEBP.',
      'err_size_min': 'حجم الصورة صغير جداً / جودة منخفضة.',
      'err_size_max': 'حجم الصورة كبير جداً (الحد الأقصى 8 ميجا).',
      'err_dim': 'دقة الصورة منخفضة جداً (الحد الأدنى 800×800).',
      'skipped': 'تم تجاهلها',
    },
    'fr': {
      'tip_row': 'De meilleures photos = plus de ventes. Suivez notre guide photo.',
      'learn_more': 'En savoir plus',
      'modal_title': 'Guide photo',
      'rule_res': 'Résolution minimale 800×800px',
      'rule_ratio': 'Utilisez un ratio carré (1:1) ou 4:5',
      'rule_bg': 'Fond simple et épuré (blanc/clair de préférence)',
      'rule_angles': 'Ajoutez 3 à 5 photos : face, dos, côté, gros plan',
      'rule_light': 'Éclairage bon et uniforme — évitez les ombres dures',
      'good': 'Bonne',
      'bad': 'Mauvaise',
      'good_desc': 'Nette, bien éclairée, fond propre, produit bien cadré',
      'bad_desc': 'Floue, sombre, fond encombré, produit coupé',
      'got_it': 'Compris',
      'err_ext': 'Format non supporté. Utilisez JPG, PNG ou WEBP.',
      'err_size_min': "Fichier image trop petit / qualité faible.",
      'err_size_max': 'Fichier image trop volumineux (max 8MB).',
      'err_dim': 'Résolution trop faible (min 800×800px).',
      'skipped': 'ignorée',
    },
  };

  static String t(String key, String lang) {
    return _s[lang]?[key] ?? _s['en']![key] ?? key;
  }
}

class UploadMultiImageWidget extends StatelessWidget {
  const UploadMultiImageWidget({
    super.key,
    required this.images,
    required this.count,
    required this.deleteImage,
    required this.imagesList,
    this.title,
    this.translationSection = 'global',
  });

  final List images;
  final String? title;
  final String translationSection;
  final int count;
  final void Function(int i) deleteImage;
  final void Function(List<XFile> images) imagesList;

  String _lang(BuildContext context) {
    // Adjust this to match your LanguageProvider's actual API.
    try {
      final code = LanguageProvider.languageCode();
      if (_T._s.containsKey(code)) return code??"ar";
    } catch (_) {}
    return 'en';
  }

  Future<Map<String, dynamic>> _readImageMeta(XFile file) async {
    final bytes = await file.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return {
      'width': frame.image.width,
      'height': frame.image.height,
      'sizeBytes': bytes.length,
    };
  }

  /// Returns the list of images that pass quality rules.
  /// Shows a snackbar summarizing anything skipped.
  Future<List<XFile>> _validateAndFilter(
      BuildContext context,
      List<XFile> picked,
      String lang,
      ) async {
    final List<XFile> valid = [];
    final List<String> reasons = [];

    for (final file in picked) {
      final ext = file.path.split('.').last.toLowerCase();
      if (!ImageQualityRules.allowedExtensions.contains(ext)) {
        reasons.add('${file.name}: ${_T.t('err_ext', lang)}');
        continue;
      }

      try {
        final meta = await _readImageMeta(file);
        final int sizeBytes = meta['sizeBytes'];
        final int width = meta['width'];
        final int height = meta['height'];

        if (sizeBytes < ImageQualityRules.minSizeBytes) {
          reasons.add('${file.name}: ${_T.t('err_size_min', lang)}');
          continue;
        }
        if (sizeBytes > ImageQualityRules.maxSizeBytes) {
          reasons.add('${file.name}: ${_T.t('err_size_max', lang)}');
          continue;
        }
        if (width < ImageQualityRules.minWidth ||
            height < ImageQualityRules.minHeight) {
          reasons.add('${file.name}: ${_T.t('err_dim', lang)}');
          continue;
        }
        valid.add(file);
      } catch (_) {
        // If decoding fails, don't block the user — just pass it through.
        valid.add(file);
      }
    }

    if (reasons.isNotEmpty && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${reasons.length} ${_T.t('skipped', lang)}:\n${reasons.join('\n')}',
          ),
          backgroundColor: Colors.orange.shade800,
          duration: const Duration(seconds: 4),
        ),
      );
    }

    return valid;
  }

  void _showPhotoGuide(BuildContext context, String lang) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.75,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          expand: false,
          builder: (ctx, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 12.w,
                      height: 0.5.h,
                      margin: EdgeInsets.only(bottom: 2.h),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Text(
                    _T.t('modal_title', lang),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  ..._checklistItems(lang).map(
                        (txt) => Padding(
                      padding: EdgeInsets.only(bottom: 1.2.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check_circle,
                              size: 16.sp, color: AppColor.primaryColor),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: Text(txt, style: TextStyle(fontSize: 11.sp)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Expanded(
                        child: _exampleCard(
                          lang: lang,
                          isGood: true,

                          imagePath: Images.exGood,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: _exampleCard(
                          lang: lang,
                          isGood: false,
                          imagePath: Images.exBad,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 1.5.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => Navigator.pop(ctx),
                      child: Text(
                        _T.t('got_it', lang),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List<String> _checklistItems(String lang) => [
    _T.t('rule_res', lang),
    _T.t('rule_ratio', lang),
    _T.t('rule_bg', lang),
    _T.t('rule_angles', lang),
    _T.t('rule_light', lang),
  ];

  Widget _exampleCard({
    required String lang,
    required bool isGood,
    required String imagePath,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imagePath,
            width: 20.w,
            height: 20.w,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey.shade200,
              child: Icon(Icons.image_not_supported,
                  color: Colors.grey.shade400),
            ),
          ),
        ),
        SizedBox(height: 0.8.h),
        Row(
          children: [
            Icon(
              isGood ? Icons.check_circle : Icons.cancel,
              size: 14.sp,
              color: isGood ? Colors.green : Colors.red,
            ),
            SizedBox(width: 1.w),
            Text(
              _T.t(isGood ? 'good' : 'bad', lang),
              style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Text(
          _T.t(isGood ? 'good_desc' : 'bad_desc', lang),
          style: TextStyle(fontSize: 9.sp, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = _lang(context);

    return Container(
      padding: EdgeInsets.all(1.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${images.length}/$count',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          // Tip row + "Learn more" -> opens best-practices modal
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.8.h),
            child: InkWell(
              onTap: () => _showPhotoGuide(context, lang),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline,
                      size: 13.sp, color: AppColor.primaryColor),
                  SizedBox(width: 1.5.w),
                  Expanded(
                    child: Text(
                      _T.t('tip_row', lang),
                      style: TextStyle(
                        fontSize: 9.5.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  Text(
                    _T.t('learn_more', lang),
                    style: TextStyle(
                      fontSize: 9.5.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 10.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length + 1, // +1 for the add button
              itemBuilder: (ctx, i) {
                // Add Image Button
                if (i == images.length) {
                  return InkWell(
                    onTap: () async {
                      List<XFile>? pickedImages =
                      await chooseImageMulti(context);
                      if (pickedImages != null && pickedImages.isNotEmpty) {
                        final validImages = await _validateAndFilter(
                          context,
                          pickedImages,
                          lang,
                        );
                        if (validImages.isNotEmpty) {
                          imagesList(validImages);
                        }
                      }
                    },
                    child: Container(
                      width: 7.w,
                      height: 12.h,
                      margin: EdgeInsets.only(left: 1.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColor.primaryColor,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 20.sp,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  );
                }

                // Image Thumbnail with Delete
                return InkWell(
                  onTap: () => deleteImage(i),
                  child: Container(
                    width: 7.w,
                    height: 12.h,
                    margin: EdgeInsets.only(left: i == 0 ? 0 : 1.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      border:
                      Border.all(color: const Color(0xFFE0E0E0), width: 1),
                      image: (images[i] is XFile)
                          ? DecorationImage(
                        image: FileImage(File(images[i].path)),
                        fit: BoxFit.cover,
                      )
                          : DecorationImage(
                        image: CachedNetworkImageProvider(
                            images[i].image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0.5.w,
                          right: 0.5.w,
                          child: Container(
                            padding: EdgeInsets.all(0.3.w),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              size: 10.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}