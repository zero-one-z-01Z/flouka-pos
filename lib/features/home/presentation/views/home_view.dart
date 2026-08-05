import 'package:flouka_pos/features/offers/presentation/views/offers_view.dart';
import 'package:flouka_pos/features/products/presentation/views/add_product_view.dart';
import 'package:flouka_pos/features/wallet/presentation/views/wallet_view.dart';
import 'package:flouka_pos/features/withdraw/presentation/views/withdraw_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/custom_app_bat.dart';
import '../../../coupons/presentation/views/coupons_view.dart';
import '../../../popular_categories/presentation/views/popular_category_view.dart';
import '../../../reels/presentation/views/reels_view.dart';
import '../../../sections/presentation/views/sections_view.dart';
import '../../../settings/presentation/views/settings_view.dart';
import '../../../story/presentation/views/stories_view.dart';
import '../../../tickets/presentation/pages/tickets_page.dart';
import '../../../vendor_stores/presentation/views/vendor_stores_view.dart';
import '../providers/home_provider.dart';
import '../widgets/navigation_rail_widget.dart';
import 'tabs/order_tab.dart';
import 'tabs/overview_tab.dart';
import 'tabs/performance_tab.dart';
import 'tabs/products_tab.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of(context);
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fd),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Row(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const NavigationRailWidget(),
            Expanded(
              child: Column(
                children: [
                  const CustomAppBar(),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Main Content Area
                        Expanded(
                          child: _buildTabContent(
                            homeProvider.selectedNavigation.title,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(String tabName) {
    switch (tabName) {
      case 'Overview':
        return const OverviewTab();
      case 'Products':
        return const ProductsTab();
      case 'Settings':
        return const SettingsView();
      case 'Orders':
        return const OrderTab();
      case 'add_products':
        return const AddProductView();
      case 'Performance':
        return const PerformanceTab();
      case 'video':
        return const ReelsView();
      case 'offers':
        return const OffersView();
      case 'withdraw':
        return const WithdrawView();
      case 'popular_categories':
        return const PopularCategoryView();
      case 'sections':
        return const SectionsView();
      case 'vendor_stores':
        return const VendorStoresView();
      case 'stories':
        return const StoriesView();
      case 'coupons':
        return const CouponsView();
      case 'support':
        return const TicketsPage();
      case 'wallet':
        return const WalletView();

      default:
        return const OverviewTab();
    }
  }
}
