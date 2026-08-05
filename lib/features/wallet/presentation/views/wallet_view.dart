import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_lotties.dart';
import '../../../../core/widgets/empty_animation.dart';
import '../providers/wallet_provider.dart';
import '../widgets/wallet_operation_widget.dart';
import '../widgets/wallet_summary_widget.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    final WalletProvider walletProvider = Provider.of<WalletProvider>(context,);
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Builder(builder: (context) {
        if (walletProvider.data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // first thing: the 4 wallet containers
              WalletSummaryWidget(summary: walletProvider.wallet),
              SizedBox(height: 2.h),
              // second thing: the wallet operations list
              Expanded(
                child: walletProvider.data!.isEmpty
                    ? const Center(child: EmptyAnimation(title: "", gif: Lotties.noSearch))
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
      }),
    );
  }
}
