import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flouka_pos/core/constants/constants.dart';
import 'package:flouka_pos/core/widgets/vendor/vendor_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/constants/app_lotties.dart';
import '../../../../core/widgets/empty_animation.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/offers_operations_provider.dart';
import '../providers/offers_provider.dart';
import '../widgets/add_offer_widget.dart';

class OffersView extends StatelessWidget {
  const OffersView({super.key});

  Widget _list(
    BuildContext context,
    OffersProvider offersProvider,
    OffersOperationsProvider ops,
  ) {
    if (offersProvider.data == null) {
      return const Center(
        child: CircularProgressIndicator(color: AppColor.sidebar),
      );
    }
    if (offersProvider.data!.isEmpty) {
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
            children: List.generate(offersProvider.data!.length, (index) {
              final offer = offersProvider.data![index];
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
                            '${LanguageProvider.translate('inputs', 'offer_name')} : ${offer.name}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyleClass.captionStyle(),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${LanguageProvider.translate('inputs', 'offer_percentage')} : ${offer.percentage}',
                            maxLines: 1,
                            style: TextStyleClass.captionStyle(),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            LanguageProvider.translate(
                              'global',
                              'products_selections',
                            ),
                            style: TextStyleClass.captionStyle(),
                          ),
                          Text(
                            offer.products.map((e) => e.title).join('\n'),
                            style: TextStyleClass.captionStyle(
                              color: AppColor.sidebar,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => ops.selectToEdit(offer: offer),
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      color: AppColor.sidebar,
                    ),
                    IconButton(
                      onPressed: () =>
                          ops.deleteCouponDialog(id: offer.id),
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
    final OffersProvider offersProvider = Provider.of<OffersProvider>(context);
    final OffersOperationsProvider ops =
        Provider.of<OffersOperationsProvider>(context);
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
              LanguageProvider.translate('navbar', 'offers'),
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
                          child: _list(context, offersProvider, ops),
                        ),
                      ),
                      if (offersProvider.data != null)
                        const Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
                          child: AddOfferWidget(),
                        ),
                    ],
                  )
                : MasterDetailScaffold(
                    master: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 12, 16),
                      child: _list(context, offersProvider, ops),
                    ),
                    detail: offersProvider.data == null
                        ? const SizedBox.shrink()
                        : const Padding(
                            padding: EdgeInsets.fromLTRB(12, 12, 20, 16),
                            child: AddOfferWidget(),
                          ),
                    showDetail: offersProvider.data != null,
                  ),
          ),
        ],
      ),
    );
  }
}
