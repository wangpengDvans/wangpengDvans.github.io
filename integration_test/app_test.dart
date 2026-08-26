import 'package:flutter_test/flutter_test.dart';
import 'package:guitu_app/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('app launches and bottom tabs are visible', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.text('首页'), findsOneWidget);
    expect(find.text('发现'), findsOneWidget);
    expect(find.text('指南'), findsOneWidget);
    expect(find.text('纪念'), findsOneWidget);
    expect(find.text('我的'), findsOneWidget);
  });
}
