import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flouka_pos/core/constants/constants.dart';
import 'package:flouka_pos/core/widgets/vendor/vendor_widgets.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_lotties.dart';
import '../../../../core/widgets/empty_animation.dart';
import '../providers/coupons_operations_provider.dart';
import '../providers/coupons_provider.dart';
import '../widgets/add_coupon_widget.dart';

class CouponsView extends StatelessWidget {
  const CouponsView({super.key});

  Widget _list(
    BuildContext context,
    CouponsProvider couponsProvider,
    CouponsOperationsProvider ops,
  ) {
    if (couponsProvider.data == null) {
      return const Center(
        child: CircularProgressIndicator(color: AppColor.sidebar),
      );
    }
    if (couponsProvider.data!.isEmpty) {
      return const Center(
        child: EmptyAnimation(title: '', gif: Lotties.noSearch),
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = constraints.maxWidth > 700 ? 2 : 1;
        const gap = 12.0;
        final w = cols == 1
            ? constraints.maxWidth
            : (constraints.maxWidth - gap) / 2;
        return SingleChildScrollView(
          child: Wrap(
            spacing: gap,
            runSpacing: gap,
            children: List.generate(couponsProvider.data!.length, (index) {
              final coupon = couponsProvider.data![index];
              return Container(
                width: w,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColor.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColor.hairline),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${LanguageProvider.translate('inputs', 'coupon_name')} : ${coupon.name}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyleClass.captionStyle(),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${LanguageProvider.translate('inputs', 'coupon_code')} : ${coupon.coupon}',
                            maxLines: 1,
                            style: TextStyleClass.captionStyle(),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${LanguageProvider.translate('inputs', 'coupon_type')} : ${LanguageProvider.translate('global', '${coupon.type}')}',
                            maxLines: 1,
                            style: TextStyleClass.captionStyle(),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${LanguageProvider.translate('inputs', 'count')} : ${coupon.count}',
                            maxLines: 1,
                            style: TextStyleClass.captionStyle(),
                          ),
                          if (coupon.min != null &&
                              coupon.min! > 0 &&
                              coupon.type == 'fixed')
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                '${LanguageProvider.translate('inputs', 'min')} : ${coupon.min}',
                                maxLines: 1,
                                style: TextStyleClass.captionStyle(),
                              ),
                            ),
                          if (coupon.max != null &&
                              coupon.max! > 0 &&
                              coupon.type == 'percentage')
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                '${LanguageProvider.translate('inputs', 'max')} : ${coupon.max}',
                                maxLines: 1,
                                style: TextStyleClass.captionStyle(),
                              ),
                            ),
                          const SizedBox(height: 8),
                          Text(
                            LanguageProvider.translate(
                              'global',
                              'stores_selections',
                            ),
                            style: TextStyleClass.captionStyle(),
                          ),
                          Text(
                            coupon.stores.map((e) => e.name).join('\n'),
                            style: TextStyleClass.captionStyle(
                              color: AppColor.sidebar,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => ops.selectToEdit(coupon: coupon),
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      color: AppColor.sidebar,
                    ),
                    IconButton(
                      onPressed: () =>
                          ops.deleteCouponDialog(id: coupon.id),
                      icon: const Icon(Icons.delete_outline, size: 18),
                      color: Colors.red,
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final CouponsProvider couponsProvider =
        Provider.of<CouponsProvider>(context);
    final CouponsOperationsProvider ops =
        Provider.of<CouponsOperationsProvider>(context);
    final compact = Constants.isCompactShell(context);

    return Scaffold(
      backgroundColor: AppColor.canvas,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              compact ? 16 : 20,
              16,
              compact ? 16 : 20,
              0,
            ),
            child: Text(
              LanguageProvider.translate('navbar', 'coupons'),
              style: GoogleFonts.bricolageGrotesque(
                fontSize: compact ? 22 : 18,
                fontWeight: FontWeight.w800,
                color: AppColor.ink,
              ),
            ),
          ),
          Expanded(
            child: compact
                ? ListView(
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.45,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                          child: _list(context, couponsProvider, ops),
                        ),
                      ),
                      if (couponsProvider.data != null)
                        const Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
                          child: AddCouponWidget(),
                        ),
                    ],
                  )
                : MasterDetailScaffold(
                    master: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 12, 16),
                      child: _list(context, couponsProvider, ops),
                    ),
                    detail: couponsProvider.data == null
                        ? const SizedBox.shrink()
                        : const Padding(
                            padding: EdgeInsets.fromLTRB(12, 12, 20, 16),
                            child: AddCouponWidget(),
                          ),
                    showDetail: couponsProvider.data != null,
                  ),
          ),
        ],
      ),
    );
  }
}
