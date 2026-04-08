import 'package:flouka_pos/features/home/presentation/views/tabs/settings_tab.dart';
import 'package:flouka_pos/features/products/presentation/views/add_product_view.dart';
import 'package:flouka_pos/features/video/presentation/views/video_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/custom_app_bat.dart';
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
      body: Row(
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
    );
  }

  Widget _buildTabContent(String tabName) {
    switch (tabName) {
      case 'Overview':
        return const OverviewTab();
      case 'Products':
        return const ProductsTab();
      case 'Settings':
        return const SettingsTab();
      case 'Orders':
        return const OrderTab();
      case 'add_products':
        return const AddProductView();
      case 'Performance':
        return const PerformanceTab();
      case 'video':
        return const VideosPage();

      default:
        return const OverviewTab();
    }
  }
}
