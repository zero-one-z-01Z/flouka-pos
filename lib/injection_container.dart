import 'package:flouka_pos/features/auth/presentation/providers/register_provider.dart';
import 'package:get_it/get_it.dart';
import 'core/helper_function/api.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repo/user_repo_impl.dart';
import 'features/auth/domain/repo/auth_repo.dart';
import 'features/auth/domain/usecases/user_usecases.dart';
import 'features/orders/data/data_source/order_remote_data_source.dart';
import 'features/orders/data/repo/order_repo_impl.dart';
import 'features/orders/domain/repo/order_repo.dart';
import 'features/orders/domain/use_case/order_use_case.dart';

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
}
