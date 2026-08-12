import 'package:cached_network_image/cached_network_image.dart';
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
import '../providers/withdraw_provider.dart';
import '../widgets/add_withdraw_widget.dart';

class WithdrawView extends StatelessWidget {
  const WithdrawView({super.key});

  void _showImage(BuildContext context, String image) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: CachedNetworkImage(imageUrl: image, fit: BoxFit.contain),
        );
      },
    );
  }

  Widget _list(BuildContext context, WithdrawProvider withdrawProvider) {
    if (withdrawProvider.data == null) {
      return const Center(
        child: CircularProgressIndicator(color: AppColor.sidebar),
      );
    }
    if (withdrawProvider.data!.isEmpty) {
      return const Center(
        child: EmptyAnimation(title: '', gif: Lotties.noSearch),
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = constraints.maxWidth > 700
            ? 2
            : 1;
        const gap = 12.0;
        final w = cols == 1
            ? constraints.maxWidth
            : (constraints.maxWidth - gap) / 2;
        return SingleChildScrollView(
          controller: withdrawProvider.controller,
          padding: const EdgeInsets.only(bottom: 16),
          child: Wrap(
            spacing: gap,
            runSpacing: gap,
            children: List.generate(withdrawProvider.data!.length, (index) {
              final withdraw = withdrawProvider.data![index];
              return Container(
                width: w,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColor.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColor.hairline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${LanguageProvider.translate('inputs', 'name')} : ${withdraw.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleClass.captionStyle(),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${LanguageProvider.translate('inputs', 'amount')} : ${withdraw.amount}',
                      maxLines: 1,
                      style: TextStyleClass.captionStyle(),
                    ),
                    if (withdraw.paypal != null && withdraw.paypal!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          'Paypal : ${withdraw.paypal}',
                          maxLines: 1,
                          style: TextStyleClass.captionStyle(),
                        ),
                      ),
                    if (withdraw.iban != null && withdraw.iban!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          'IBAN : ${withdraw.iban}',
                          maxLines: 1,
                          style: TextStyleClass.captionStyle(),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      LanguageProvider.translate('global', withdraw.status),
                      style: TextStyleClass.captionStyle(
                        color: AppColor.sidebar,
                      ),
                    ),
                    if (withdraw.image != null && withdraw.image!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: InkWell(
                          onTap: () => _showImage(context, withdraw.image!),
                          child: Text(
                            LanguageProvider.translate('global', 'show_image'),
                            style: TextStyleClass.captionStyle(
                              color: AppColor.sidebar,
                            ),
                          ),
                        ),
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
    final WithdrawProvider withdrawProvider =
        Provider.of<WithdrawProvider>(context);
    final compact = Constants.isCompactShell(context);

    final header = Padding(
      padding: EdgeInsets.fromLTRB(
        compact ? 16 : 20,
        16,
        compact ? 16 : 20,
        0,
      ),
      child: Text(
        LanguageProvider.translate('navbar', 'withdraw'),
        style: GoogleFonts.bricolageGrotesque(
          fontSize: compact ? 22 : 18,
          fontWeight: FontWeight.w800,
          color: AppColor.ink,
        ),
      ),
    );

    final master = Padding(
      padding: EdgeInsets.fromLTRB(
        compact ? 16 : 20,
        12,
        compact ? 16 : 12,
        16,
      ),
      child: _list(context, withdrawProvider),
    );

    final detail = withdrawProvider.data == null
        ? const SizedBox.shrink()
        : const Padding(
            padding: EdgeInsets.fromLTRB(12, 12, 20, 16),
            child: AddWithdrawWidget(),
          );

    return Scaffold(
      backgroundColor: AppColor.canvas,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header,
          Expanded(
            child: compact
                ? ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.45,
                        child: master,
                      ),
                      if (withdrawProvider.data != null)
                        const Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
                          child: AddWithdrawWidget(),
                        ),
                    ],
                  )
                : MasterDetailScaffold(
                    master: master,
                    detail: detail,
                    showDetail: withdrawProvider.data != null,
                  ),
          ),
        ],
      ),
    );
  }
}
