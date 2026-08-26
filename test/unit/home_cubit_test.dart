import 'package:flutter_test/flutter_test.dart';
import 'package:guitu_app/domain/models/home_data.dart';
import 'package:guitu_app/domain/models/merchant.dart';
import 'package:guitu_app/domain/repositories/home_repository.dart';
import 'package:guitu_app/features/home/cubit/home_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  group('HomeCubit', () {
    late HomeRepository repository;
    late HomeCubit cubit;

    setUp(() {
      repository = MockHomeRepository();
      cubit = HomeCubit(repository);
    });

    tearDown(() => cubit.close());

    test('emits loaded state when loadHome succeeds', () async {
      final data = HomeData(
        city: '上海',
        guideCompletedSteps: 2,
        guideTotalSteps: 6,
        categories: const [],
        nearbyMerchants: const [
          Merchant(
            id: 'm1',
            name: 'Test',
            city: '上海',
            distance: 1.0,
            rating: 5.0,
            reviewCount: 1,
            servedCount: 1,
            responseTime: '24h',
            tags: [],
          ),
        ],
      );
      when(() => repository.loadHomeData(city: any(named: 'city'))).thenAnswer((_) async => data);

      final states = <HomeState>[];
      final subscription = cubit.stream.listen(states.add);

      await cubit.loadHome();
      await Future.delayed(Duration.zero);

      expect(states, [isA<HomeLoading>(), isA<HomeLoaded>()]);
      subscription.cancel();
    });

    test('emits error state when loadHome fails', () async {
      when(() => repository.loadHomeData(city: any(named: 'city'))).thenThrow(Exception('error'));

      final states = <HomeState>[];
      final subscription = cubit.stream.listen(states.add);

      await cubit.loadHome();
      await Future.delayed(Duration.zero);

      expect(states, [isA<HomeLoading>(), isA<HomeError>()]);
      subscription.cancel();
    });
  });
}
