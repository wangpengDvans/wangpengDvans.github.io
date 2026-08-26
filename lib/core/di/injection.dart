import 'package:get_it/get_it.dart';
import '../../data/repositories/mock/mock_guide_repository.dart';
import '../../data/repositories/mock/mock_home_repository.dart';
import '../../data/repositories/mock/mock_merchant_repository.dart';
import '../../data/repositories/mock/mock_memorial_repository.dart';
import '../../data/repositories/mock/mock_order_repository.dart';
import '../../data/repositories/mock/mock_tomb_repository.dart';
import '../../domain/repositories/guide_repository.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/repositories/merchant_repository.dart';
import '../../domain/repositories/memorial_repository.dart';
import '../../domain/repositories/order_repository.dart';
import '../../domain/repositories/tomb_repository.dart';
import '../../features/auth/cubit/auth_cubit.dart';
import '../../features/discover/cubit/discover_cubit.dart';
import '../../features/discover/cubit/merchant_detail_cubit.dart';
import '../../features/discover/cubit/tomb_detail_cubit.dart';
import '../../features/discover/cubit/tomb_discovery_cubit.dart';
import '../../features/guide/cubit/guide_cubit.dart';
import '../../features/home/cubit/home_cubit.dart';
import '../../features/memorial/cubit/memorial_cubit.dart';
import '../../features/profile/cubit/orders_cubit.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() {
  // Repositories
  getIt.registerLazySingleton<HomeRepository>(() => MockHomeRepository());
  getIt.registerLazySingleton<MerchantRepository>(() => MockMerchantRepository());
  getIt.registerLazySingleton<GuideRepository>(() => MockGuideRepository());
  getIt.registerLazySingleton<MemorialRepository>(() => MockMemorialRepository());
  getIt.registerLazySingleton<OrderRepository>(() => MockOrderRepository());
  getIt.registerLazySingleton<TombRepository>(() => MockTombRepository());

  // Cubits
  getIt.registerFactory<AuthCubit>(() => AuthCubit());
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepository>()));
  getIt.registerFactory<DiscoverCubit>(() => DiscoverCubit(getIt<MerchantRepository>()));
  getIt.registerFactory<MerchantDetailCubit>(() => MerchantDetailCubit(getIt<MerchantRepository>()));
  getIt.registerFactory<TombDetailCubit>(() => TombDetailCubit(getIt<TombRepository>()));
  getIt.registerFactory<TombDiscoveryCubit>(() => TombDiscoveryCubit(getIt<TombRepository>()));
  getIt.registerFactory<GuideCubit>(() => GuideCubit(getIt<GuideRepository>()));
  getIt.registerFactory<MemorialCubit>(() => MemorialCubit(getIt<MemorialRepository>()));
  getIt.registerFactory<OrdersCubit>(() => OrdersCubit(getIt<OrderRepository>()));
}
