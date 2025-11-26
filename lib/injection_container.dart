import 'package:get_it/get_it.dart';
import 'core/helper_function/api.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repo/user_repo_impl.dart';
import 'features/auth/domain/repo/auth_repo.dart';
import 'features/auth/domain/usecases/user_usecases.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<ApiHandel>(ApiHandel.getInstance);
   // auth
  sl.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSource(sl.get()));
  sl.registerSingleton<AuthRepo>(AuthRepoImpl(sl.get()));
  sl.registerSingleton<AuthUseCase>(AuthUseCase(sl.get()));
 

}
