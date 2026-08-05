import 'package:flouka_pos/features/auth/presentation/providers/register_provider.dart';
import 'package:flouka_pos/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:flouka_pos/features/chat/domain/repositories/chat_repository.dart';
import 'package:flouka_pos/features/chat/domain/use_cases/chat_usecases.dart';
import 'package:flouka_pos/features/notification/data/data_sources/remote.dart';
import 'package:flouka_pos/features/notification/data/repositories/notification_repo_impl.dart';
import 'package:flouka_pos/features/notification/domain/use_cases/notification_usecaese.dart';
import 'package:get_it/get_it.dart';
import 'core/helper_function/api.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repo/user_repo_impl.dart';
import 'features/auth/domain/repo/auth_repo.dart';
import 'features/auth/domain/usecases/user_usecases.dart';
import 'features/categories/data/datasource/category_remote_data_source.dart';
import 'features/categories/data/repositories/category_repo_impl.dart';
import 'features/categories/domain/repositories/category_repo.dart';
import 'features/categories/domain/usecases/category_usecase.dart';
import 'features/chat/data/data_sources/remote.dart';
import 'features/coupons/data/data_source/coupons_remote_data_source.dart';
import 'features/coupons/data/repos/coupons_repo_impl.dart';
import 'features/coupons/domain/repo/coupons_repo.dart';
import 'features/coupons/domain/user_case/coupons_use_case.dart';
import 'features/notification/domain/repositories/notification_repo.dart';
import 'features/offers/data/data_source/offers_remote_data_source.dart';
import 'features/offers/data/repos/offers_repo_impl.dart';
import 'features/offers/domain/repo/offers_repo.dart';
import 'features/offers/domain/user_case/offers_use_case.dart';
import 'features/orders/data/data_source/order_remote_data_source.dart';
import 'features/orders/data/repo/order_repo_impl.dart';
import 'features/orders/domain/repo/order_repo.dart';
import 'features/orders/domain/use_case/order_use_case.dart';
import 'features/popular_categories/data/data_source/popular_category_remote_data_source.dart';
import 'features/popular_categories/data/repos/popular_category_repo_impl.dart';
import 'features/popular_categories/domain/repo/popular_category_repo.dart';
import 'features/popular_categories/domain/user_case/popular_category_use_case.dart';
import 'features/products/data/data_source/product_remote_data_source.dart';
import 'features/products/data/repos/product_repo_impl.dart';
import 'features/products/domain/repo/product_repo.dart';
import 'features/products/domain/user_case/product_use_case.dart';
import 'features/reels/data/data_source/reels_remote_data_source.dart';
import 'features/reels/data/repos/reels_repo_impl.dart';
import 'features/reels/domain/repo/reels_repo.dart';
import 'features/reels/domain/user_case/reels_use_case.dart';
import 'features/sections/data/data_source/sections_remote_data_source.dart';
import 'features/sections/data/repos/sections_repo_impl.dart';
import 'features/sections/domain/repo/sections_repo.dart';
import 'features/sections/domain/user_case/sections_use_case.dart';
import 'features/settings/data/datasources/remote.dart';
import 'features/settings/data/repositories/settings_repo_impl.dart';
import 'features/settings/domain/repositories/settings_repo.dart';
import 'features/settings/domain/usecases/settings_usecases.dart';
import 'features/story/data/data_source/stories_remote_data_source.dart';
import 'features/story/data/repos/stories_repo_impl.dart';
import 'features/story/domain/repo/stories_repo.dart';
import 'features/story/domain/user_case/stories_use_case.dart';
import 'features/tickets/data/datasources/remote_tickets_data_source.dart';
import 'features/tickets/data/repositories/tickets_repo_impl.dart';
import 'features/tickets/domain/repositories/tickets_repository.dart';
import 'features/tickets/domain/usecases/tickets_use_case.dart';
import 'features/vendor_stores/data/data_source/vendor_stores_remote_data_source.dart';
import 'features/vendor_stores/data/repos/vendor_stores_repo_impl.dart';
import 'features/vendor_stores/domain/repo/vendor_store_repo.dart';
import 'features/vendor_stores/domain/user_case/vendor_stores_use_case.dart';
import 'features/zone/data/datasource/city_remote.dart';
import 'features/zone/data/repository/city_repo_impl.dart';
import 'features/zone/domain/repository/city_repo.dart';
import 'features/zone/domain/usecase/city_usecase.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<ApiHandel>(ApiHandel.getInstance);
  // auth
  sl.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSource(sl.get()));
  sl.registerSingleton<AuthRepo>(AuthRepoImpl(sl.get()));
  sl.registerSingleton<AuthUseCase>(AuthUseCase(sl.get()));
  sl.registerSingleton<RegisterProvider>(RegisterProvider(userUseCase: sl.get()));
  // order
  sl.registerSingleton<OrderRemoteDataSource>(OrderRemoteDataSource(sl.get()));
  sl.registerSingleton<OrderRepo>(OrderRepoImpl(sl.get()));
  sl.registerSingleton<OrderUseCase>(OrderUseCase(sl.get()));

  // product
  sl.registerSingleton<ProductRemoteDataSource>(ProductRemoteDataSource(sl.get()));
  sl.registerSingleton<ProductRepo>(ProductRepoImpl(sl.get()));
  sl.registerSingleton<ProductUseCase>(ProductUseCase(sl.get()));

  // vendor stores
  sl.registerSingleton<VendorStoresRemoteDataSource>(VendorStoresRemoteDataSource(sl.get()));
  sl.registerSingleton<VendorStoreRepo>(VendorStoresRepoImpl(sl.get()));
  sl.registerSingleton<VendorStoresUseCase>(VendorStoresUseCase(sl.get()));

  // vendor stores
  sl.registerSingleton<StoriesRemoteDataSource>(StoriesRemoteDataSource(sl.get()));
  sl.registerSingleton<StoriesRepo>(StoriesRepoImpl(sl.get()));
  sl.registerSingleton<StoriesUseCase>(StoriesUseCase(sl.get()));
  // reels
  sl.registerSingleton<ReelsRemoteDataSource>(ReelsRemoteDataSource(sl.get()));
  sl.registerSingleton<ReelsRepo>(ReelsRepoImpl(sl.get()));
  sl.registerSingleton<ReelsUseCases>(ReelsUseCases(sl.get()));

  // coupons
  sl.registerSingleton<CouponsRemoteDataSource>(CouponsRemoteDataSource(sl.get()));
  sl.registerSingleton<CouponsRepo>(CouponsRepoImpl(sl.get()));
  sl.registerSingleton<CouponsUseCase>(CouponsUseCase(sl.get()));

  //offers
  sl.registerSingleton<OffersRemoteDataSource>(OffersRemoteDataSource(sl.get()));
  sl.registerSingleton<OffersRepo>(OffersRepoImpl(sl.get()));
  sl.registerSingleton<OffersUseCase>(OffersUseCase(sl.get()));

  //popular categories
  sl.registerSingleton<PopularCategoryRemoteDataSource>(PopularCategoryRemoteDataSource(sl.get()));
  sl.registerSingleton<PopularCategoryRepo>(PopularCategoryRepoImpl(sl.get()));
  sl.registerSingleton<PopularCategoryUseCase>(PopularCategoryUseCase(sl.get()));

  //sections
  sl.registerSingleton<SectionsRemoteDataSource>(SectionsRemoteDataSource(sl.get()));
  sl.registerSingleton<SectionsRepo>(SectionsRepoImpl(sl.get()));
  sl.registerSingleton<SectionsUseCase>(SectionsUseCase(sl.get()));

  //categories
  sl.registerSingleton<CategoryRemoteDataSource>(CategoryRemoteDataSource(sl.get()));
  sl.registerSingleton<CategoryRepo>(CategoryRepoImpl(sl.get()));
  sl.registerSingleton<CategoryUsecase>(CategoryUsecase(sl.get()));

  //tickets
  sl.registerSingleton<BannersTicketsDataSource>(BannersTicketsDataSource(sl.get()));
  sl.registerSingleton<TicketsRepository>(TicketsRepoImpl(sl.get()));
  sl.registerSingleton<TicketsUseCase>(TicketsUseCase(sl.get()));

  //chats
  sl.registerSingleton<ChatRemoteDataSources>(ChatRemoteDataSources());
  sl.registerSingleton<ChatRepository>(ChatRepositoryImpl());
  sl.registerSingleton<ChatUseCases>(ChatUseCases(sl.get()));

  //notifications
  sl.registerSingleton<NotificationRemoteDataSource>(NotificationRemoteDataSource(sl.get()));
  sl.registerSingleton<NotificationRepo>(NotificationRepoImpl(sl.get()));
  sl.registerSingleton<NotificationUseCases>(NotificationUseCases(sl.get()));

  // Settings
  sl.registerSingleton<SettingsRemoteDataSource>(SettingsRemoteDataSource(sl.get()));
  sl.registerSingleton<SettingsRepo>(SettingsRepoImpl(sl.get()));
  sl.registerSingleton<SettingsUseCases>(SettingsUseCases(sl.get()));

  //city
  sl.registerSingleton<CityRemoteDataSource>(CityRemoteDataSource(sl.get()));
  sl.registerSingleton<CityRepo>(CityRepoImpl(sl.get()));
  sl.registerSingleton<CityUseCases>(CityUseCases(sl.get()));


}

