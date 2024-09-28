import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movies_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Movies app', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.text('Movie'), findsOneWidget);

    final Finder textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);

    await tester.enterText(textFieldFinder, 'a');
    await tester.pumpAndSettle();
  });
}
