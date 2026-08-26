import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guitu_app/app.dart';
import 'package:guitu_app/core/di/injection.dart';
import 'package:guitu_app/domain/models/home_data.dart';
import 'package:guitu_app/domain/repositories/home_repository.dart';
import 'package:guitu_app/features/home/cubit/home_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  setUp(() {
    getIt.reset();
  });

  testWidgets('HomeScreen shows loading then content', (tester) async {
    final repository = MockHomeRepository();
    final data = HomeData(
      city: '上海',
      guideCompletedSteps: 2,
      guideTotalSteps: 6,
      categories: const [],
      nearbyMerchants: const [],
    );
    when(() => repository.loadHomeData(city: any(named: 'city'))).thenAnswer((_) async => data);

    getIt.registerLazySingleton<HomeRepository>(() => repository);
    getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepository>()));

    await tester.pumpWidget(const GuituApp());
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.text('治丧指南'), findsOneWidget);
  });
}
