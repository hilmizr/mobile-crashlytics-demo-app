import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crashlytics_demo_v0/main.dart';

void main() {
  testWidgets('Crash Lab navigation and smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // Note: This tests the widget structure without initializing Firebase
    // because Firebase.initializeApp() is inside main() and we are pumping CrashLabApp directly.
    await tester.pumpWidget(const CrashLabApp());

    // 1. Verify we start on the Lab screen
    expect(find.text('Crash Lab'), findsOneWidget);
    expect(find.text('FATAL (app dies)'), findsOneWidget);
    expect(find.text('Force native crash (crash())'), findsOneWidget);

    // 2. Navigate to the Order screen
    await tester.tap(find.byIcon(Icons.coffee));
    await tester.pumpAndSettle();

    expect(find.text('Order Coffee'), findsOneWidget);
    expect(find.text('Coffee Type'), findsOneWidget);
    expect(find.text('Place Order'), findsOneWidget);

    // 3. Navigate to the Me (Identity) screen
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    expect(find.text('Who Am I'), findsOneWidget);
    expect(find.text('Your student ID:'), findsOneWidget);
    expect(find.text('Save Identity'), findsOneWidget);
    expect(find.text('Crash reporting enabled'), findsOneWidget);
  });
}
