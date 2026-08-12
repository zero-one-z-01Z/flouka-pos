import 'package:flouka_pos/core/constants/constants.dart';
import 'package:flouka_pos/core/helper_function/navigation.dart';
import 'package:flouka_pos/core/helper_function/prefs.dart';
import 'package:flouka_pos/features/auth/presentation/providers/auth_provider.dart';
import 'package:flouka_pos/features/home/presentation/views/home_view.dart';
import 'package:flouka_pos/features/wallet/presentation/providers/wallet_provider.dart';
import 'package:flouka_pos/features/withdraw/presentation/providers/withdraw_operations_provider.dart';
import 'package:flouka_pos/features/withdraw/presentation/providers/withdraw_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_images.dart';
import '../../../categories/presentation/providers/categories_provider.dart';
import '../../../chat/presentation/provider/message_provider.dart';
import '../../../coupons/presentation/providers/coupons_operations_provider.dart';
import '../../../coupons/presentation/providers/coupons_provider.dart';
import '../../../offers/presentation/providers/offers_operations_provider.dart';
import '../../../offers/presentation/providers/offers_provider.dart';
import '../../../orders/presentation/providers/orders_provider.dart';
import '../../../popular_categories/presentation/providers/popular_category_provider.dart';
import '../../../products/presentation/providers/add_product_provider.dart';
import '../../../products/presentation/providers/product_options_provider.dart';
import '../../../products/presentation/providers/product_provider.dart';
import '../../../products/presentation/providers/tags_options_provider.dart';
import '../../../reels/presentation/providers/reels_operations_provider.dart';
import '../../../reels/presentation/providers/reels_provider.dart';
import '../../../sections/presentation/providers/sections_provider.dart';
import '../../../settings/presentation/provider/settings_provider.dart';
import '../../../story/presentation/providers/stories_operations_provider.dart';
import '../../../story/presentation/providers/stories_provider.dart';
import '../../../tickets/presentation/provider/ticket_message_provider.dart';
import '../../../tickets/presentation/provider/tickets_provider.dart';
import '../../../vendor_stores/presentation/providers/store_operations_provider.dart';
import '../../../vendor_stores/presentation/providers/vendor_stores_provider.dart';
import '../../domain/entity/navigation_entity.dart';

class HomeProvider extends ChangeNotifier {
  void goToHomeView() {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(Constants.globalContext(), listen: false);
    settingsProvider.getSettings();
    prepareNavigationList();
    navPARU(const HomeView());
  }
  void rebuild() {
    notifyListeners();
  }

  void prepareNavigationList(){
    OrdersProvider ordersProvider = Provider.of<OrdersProvider>(Constants.globalContext(), listen: false);

    bool isStore = sharedPreferences.getBool("isStore") ?? false;
    if(isStore){
      navigationList = [
        NavigationEntity(title: "Overview", svgImage: Images.overView, onTap: (){
          ordersProvider.changeSelectedTab(ordersProvider.tabs.first,isHome: true);
        }),
        NavigationEntity(title: "Orders", svgImage: Images.orders, onTap: (){
          ordersProvider.changeSelectedTab(ordersProvider.tabs.first);
        }),
        NavigationEntity(title: "Products", svgImage: Images.products, onTap: (){
          Provider.of<ProductsProvider>(Constants.globalContext(), listen: false).refresh();
        }),
        NavigationEntity(title: "support", svgImage: Images.tickets, onTap: (){
          Provider.of<TicketsProvider>(Constants.globalContext(), listen: false).refresh();
        }),
        NavigationEntity(title: "Settings", svgImage: Images.settings, onTap: (){}),
      ];
    }
    else{
      Provider.of<TagsOptionsProvider>(Constants.globalContext(), listen: false).getTags();
      Provider.of<CategoryProvider>(Constants.globalContext(), listen: false).refresh();
      Provider.of<ProductOptionsProvider>(Constants.globalContext(), listen: false).getVendorProductsOption();
      var auth = Provider.of<AuthProvider>(Constants.globalContext(), listen: false);

      navigationList = [
        NavigationEntity(title: "Overview", svgImage: Images.overView, onTap: (){
          ordersProvider.changeSelectedTab(ordersProvider.tabs.first,isHome: true);
        }),
        NavigationEntity(title: "Orders", svgImage: Images.orders, onTap: (){
          ordersProvider.changeSelectedTab(ordersProvider.tabs.first);
        }),
        NavigationEntity(title: "Products", svgImage: Images.products, onTap: (){
          Provider.of<ProductsProvider>(Constants.globalContext(), listen: false).refresh();
        }),
        NavigationEntity(title: "add_products", svgImage: Images.addProduct, onTap: (){
          Provider.of<AddProductProvider>(Constants.globalContext(), listen: false).initFields();
        }),
        // NavigationEntity(title: "popular_categories", svgImage: Images.popularCategories, onTap: (){
        //   Provider.of<PopularCategoryProvider>(Constants.globalContext(), listen: false).refresh();
        // }),
        // NavigationEntity(title: "sections", svgImage: Images.sections, onTap: (){
        //   Provider.of<SectionsProvider>(Constants.globalContext(), listen: false).refresh();
        // }),
        NavigationEntity(title: "video", svgImage: Images.video, onTap: (){
          Provider.of<ReelsOperationsProvider>(Constants.globalContext(), listen: false).addTextField();
          Provider.of<ReelsProvider>(Constants.globalContext(), listen: false).refresh();
        }),
        NavigationEntity(title: "stories", svgImage: Images.video, onTap: (){
          Provider.of<StoriesOperationsProvider>(Constants.globalContext(), listen: false).addTextField();
          Provider.of<StoriesProvider>(Constants.globalContext(), listen: false).refresh();
        }),
        NavigationEntity(title: "offers", svgImage: Images.offers, onTap: (){
          Provider.of<OffersOperationsProvider>(Constants.globalContext(), listen: false).addTextField();
          Provider.of<OffersProvider>(Constants.globalContext(), listen: false).refresh();

        }),
        NavigationEntity(title: "wallet", svgImage: Images.wallet, onTap: (){
          Provider.of<WalletProvider>(Constants.globalContext(), listen: false).refresh();
        }),
        NavigationEntity(title: "withdraw", svgImage: Images.wallet, onTap: (){
          Provider.of<WithdrawOperationsProvider>(Constants.globalContext(), listen: false).addTextField();
          Provider.of<WithdrawProvider>(Constants.globalContext(), listen: false).refresh();
        }),
        if(auth.userEntity!.accountType=='company')NavigationEntity(title: "vendor_stores", svgImage: Images.home, onTap: (){
          Provider.of<StoreOperationsProvider>(Constants.globalContext(), listen: false).addTextField();
          Provider.of<VendorStoresProvider>(Constants.globalContext(), listen: false).refresh();
        }),
        NavigationEntity(title: "coupons", svgImage: Images.coupons, onTap: (){
          Provider.of<CouponsOperationsProvider>(Constants.globalContext(), listen: false).addTextField();
          Provider.of<CouponsProvider>(Constants.globalContext(), listen: false).refresh();
        }),
        // if(sharedPreferences.getBool('isStore')??false)NavigationEntity(title: "tickets", svgImage: Images.support, onTap: (){
        //   Provider.of<TicketsProvider>(Constants.globalContext(), listen: false).goToTicketsPage();
        // }),
        if(auth.userEntity!.accountType=='individual')NavigationEntity(title: "support", svgImage: Images.tickets, onTap: (){
          Provider.of<TicketsProvider>(Constants.globalContext(), listen: false).refresh();
        }),
        NavigationEntity(title: "Settings", svgImage: Images.settings, onTap: (){}),
      ];
    }
    ordersProvider.getHomeOrders();
  }

  bool isDrawerOpen = true;

  void toggleDrawer() {
    isDrawerOpen = !isDrawerOpen;
    notifyListeners();
  }

  List<NavigationEntity> navigationList = [];
  late NavigationEntity selectedNavigation = navigationList.first;
  void setSelectedNavigation(NavigationEntity navigation) {
    if(navigation.title!=selectedNavigation.title){
      MessageProvider messageProvider = Provider.of(Constants.globalContext(),listen: false);
      messageProvider.setIsShowChat(false);
      TicketMessageProvider ticketMessageProvider = Provider.of(Constants.globalContext(),listen:false);
      ticketMessageProvider.setIsShowTicket(false);
      selectedNavigation = navigation;
      navigation.onTap();
      notifyListeners();
    }

  }
  void setAddProductNavigation(NavigationEntity navigation) {
    selectedNavigation = navigation;
    notifyListeners();
  }


  bool isSelected(NavigationEntity navigation) {
    return selectedNavigation.title == navigation.title;
  }
}
