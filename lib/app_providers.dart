import 'package:flouka_pos/features/products/presentation/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/auth/presentation/providers/account_type_provider.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/auth/presentation/providers/otp_provider.dart';
import 'features/auth/presentation/providers/register_provider.dart';
import 'features/categories/presentation/providers/brands_provider.dart';
import 'features/categories/presentation/providers/categories_provider.dart';
import 'features/categories/presentation/providers/category_attributes_provider.dart';
import 'features/categories/presentation/providers/subcategory_provider.dart';
import 'features/chat/presentation/provider/message_provider.dart';
import 'features/coupons/presentation/providers/coupons_operations_provider.dart';
import 'features/coupons/presentation/providers/coupons_provider.dart';
import 'features/home/presentation/providers/home_provider.dart';
import 'features/language/presentation/provider/language_provider.dart';
import 'features/notification/presentation/provider/notifications_provider.dart';
import 'features/offers/presentation/providers/offers_operations_provider.dart';
import 'features/offers/presentation/providers/offers_provider.dart';
import 'features/orders/presentation/providers/order_details_provider.dart';
import 'features/orders/presentation/providers/orders_provider.dart';
import 'features/popular_categories/presentation/providers/popular_category_provider.dart';
import 'features/products/presentation/providers/add_product_provider.dart';
import 'features/products/presentation/providers/add_variant_provider.dart';
import 'features/products/presentation/providers/product_options_provider.dart';
import 'features/products/presentation/providers/store_operation_provider.dart';
import 'features/products/presentation/providers/tags_options_provider.dart';
import 'features/reels/presentation/providers/reels_operations_provider.dart';
import 'features/reels/presentation/providers/reels_provider.dart';
import 'features/sections/presentation/providers/sections_provider.dart';
import 'features/settings/presentation/provider/settings_provider.dart';
import 'features/splash/provider/splash_provider.dart';
import 'features/story/presentation/providers/stories_operations_provider.dart';
import 'features/story/presentation/providers/stories_provider.dart';
import 'features/tickets/presentation/provider/add_ticket_provider.dart';
import 'features/tickets/presentation/provider/important_ticket_values_provider.dart';
import 'features/tickets/presentation/provider/ticket_message_provider.dart';
import 'features/tickets/presentation/provider/tickets_category_provider.dart';
import 'features/tickets/presentation/provider/tickets_provider.dart';
import 'features/vendor_stores/presentation/providers/store_operations_provider.dart';
import 'features/vendor_stores/presentation/providers/store_options_provider.dart';
import 'features/vendor_stores/presentation/providers/vendor_stores_provider.dart';
import 'injection_container.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({super.key, required this.child, required this.language});
  final Widget child;
  final LanguageProvider language;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => language),
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => AccountTypeProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => CategoryProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => OtpProvider()),
        ChangeNotifierProvider(create: (_) => OrderDetailsProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => AddProductProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => TagsOptionsProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => AuthProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => AddVariantProvider(sl.get(),sl.get())),
        ChangeNotifierProvider(create: (_) => RegisterProvider(userUseCase: sl.get()),),
        ChangeNotifierProvider(create: (_) => CouponsProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => CouponsOperationsProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => VendorStoresProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => StoreOperationProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => SubcategoryProvider()),
        ChangeNotifierProvider(create: (_) => StoreOperationsProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => CategoryAttributesProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => BrandsProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => ProductsProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => StoriesOperationsProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => ProductOptionsProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => StoriesProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => ReelsProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => SectionsProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => ReelsOperationsProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => TicketsProvider()),
        ChangeNotifierProvider(create: (_) => AddTicketProvider()),
        ChangeNotifierProvider(create: (_) => ImportantTicketValuesProvider()),
        ChangeNotifierProvider(create: (_) => TicketMessageProvider()),
        ChangeNotifierProvider(create: (_) => TicketsCategoryProvider()),
        ChangeNotifierProvider(create: (_) => StoreOptionsProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => MessageProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => NotificationProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => OffersProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => OffersOperationsProvider(sl.get())),
        ChangeNotifierProvider(create: (_) => PopularCategoryProvider(sl.get())),
      ],
      child: child,
    );
  }
}
