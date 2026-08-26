import 'package:flutter_test/flutter_test.dart';
import 'package:guitu_app/domain/models/tomb.dart';
import 'package:guitu_app/domain/repositories/tomb_repository.dart';
import 'package:guitu_app/features/discover/cubit/tomb_discovery_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockTombRepository extends Mock implements TombRepository {}

void main() {
  group('TombDiscoveryCubit', () {
    late TombRepository repository;
    late TombDiscoveryCubit cubit;

    final tombs = [
      const Tomb(
        id: 't1',
        cemeteryId: 'c1',
        cemeteryName: '福寿园',
        city: '上海',
        area: 'A区',
        type: '双穴墓',
        status: '可售',
        price: 128000,
        size: 1.2,
        hasVr: true,
        hasPhoto: true,
        tags: ['临湖'],
        features: ['双穴位'],
      ),
      const Tomb(
        id: 't2',
        cemeteryId: 'c1',
        cemeteryName: '福寿园',
        city: '上海',
        area: 'B区',
        type: '生态葬',
        status: '可售',
        price: 38000,
        size: 0.4,
        hasVr: false,
        hasPhoto: true,
        tags: ['生态'],
        features: ['节地'],
      ),
    ];

    setUp(() {
      repository = MockTombRepository();
      cubit = TombDiscoveryCubit(repository);
    });

    tearDown(() => cubit.close());

    test('emits loaded state when loadTombs succeeds', () async {
      when(() => repository.getAvailableTombs(city: any(named: 'city'), status: any(named: 'status'), sortBy: any(named: 'sortBy')))
          .thenAnswer((_) async => tombs);

      final states = <TombDiscoveryState>[];
      final subscription = cubit.stream.listen(states.add);

      await cubit.loadTombs();
      await Future.delayed(Duration.zero);

      expect(states, [isA<TombDiscoveryLoading>(), isA<TombDiscoveryLoaded>()]);
      subscription.cancel();
    });

    test('emits error state when loadTombs fails', () async {
      when(() => repository.getAvailableTombs(city: any(named: 'city'), status: any(named: 'status'), sortBy: any(named: 'sortBy')))
          .thenThrow(Exception('error'));

      final states = <TombDiscoveryState>[];
      final subscription = cubit.stream.listen(states.add);

      await cubit.loadTombs();
      await Future.delayed(Duration.zero);

      expect(states, [isA<TombDiscoveryLoading>(), isA<TombDiscoveryError>()]);
      subscription.cancel();
    });
  });
}
