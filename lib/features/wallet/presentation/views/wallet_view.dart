import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_lotties.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/empty_animation.dart';
import '../../../../core/widgets/vendor/vendor_widgets.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/wallet_provider.dart';
import '../widgets/wallet_operation_widget.dart';
import '../widgets/wallet_summary_widget.dart';
import 'package:flouka_pos/core/config/app_color.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    final WalletProvider walletProvider = Provider.of<WalletProvider>(context);
    final compact = Constants.isCompactShell(context);

    return Scaffold(
      backgroundColor: AppColor.canvas,
      body: Builder(
        builder: (context) {
          if (walletProvider.data == null) {
            return const Center(
              child: CircularProgressIndicator(color: AppColor.sidebar),
            );
          }
          return Padding(
            padding: EdgeInsets.fromLTRB(
              compact ? 16 : 20,
              16,
              compact ? 16 : 20,
              16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LanguageProvider.translate('navbar', 'wallet'),
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: compact ? 22 : 18,
                    fontWeight: FontWeight.w800,
                    color: AppColor.ink,
                  ),
                ),
                const SizedBox(height: 14),
                WalletSummaryWidget(summary: walletProvider.wallet),
                const SizedBox(height: 16),
                VendorSectionHeader(
                  title: LanguageProvider.translate('global', 'operations'),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: walletProvider.data!.isEmpty
                      ? const Center(
                          child: EmptyAnimation(
                            title: '',
                            gif: Lotties.noSearch,
                          ),
                        )
                      : ListView.builder(
                          controller: walletProvider.controller,
                          itemCount: walletProvider.data!.length,
                          itemBuilder: (context, index) {
                            return WalletOperationWidget(
                              operation: walletProvider.data![index],
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
