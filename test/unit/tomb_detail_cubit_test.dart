import 'package:flutter_test/flutter_test.dart';
import 'package:guitu_app/domain/models/tomb.dart';
import 'package:guitu_app/domain/repositories/tomb_repository.dart';
import 'package:guitu_app/features/discover/cubit/tomb_detail_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockTombRepository extends Mock implements TombRepository {}

void main() {
  group('TombDetailCubit', () {
    late TombRepository repository;
    late TombDetailCubit cubit;

    const tomb = Tomb(
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
    );

    setUp(() {
      repository = MockTombRepository();
      cubit = TombDetailCubit(repository);
    });

    tearDown(() => cubit.close());

    test('emits loaded state when loadDetail succeeds', () async {
      when(() => repository.getTombDetail('t1')).thenAnswer((_) async => tomb);

      final states = <TombDetailState>[];
      final subscription = cubit.stream.listen(states.add);

      await cubit.loadDetail('t1');
      await Future.delayed(Duration.zero);

      expect(states, [isA<TombDetailLoading>(), isA<TombDetailLoaded>()]);
      subscription.cancel();
    });

    test('emits error state when loadDetail fails', () async {
      when(() => repository.getTombDetail('t1')).thenThrow(Exception('error'));

      final states = <TombDetailState>[];
      final subscription = cubit.stream.listen(states.add);

      await cubit.loadDetail('t1');
      await Future.delayed(Duration.zero);

      expect(states, [isA<TombDetailLoading>(), isA<TombDetailError>()]);
      subscription.cancel();
    });
  });
}
