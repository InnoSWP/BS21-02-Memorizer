// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:memorizer_flutter/main.dart';

void main() {
  testWidgets('Show back button on text field press test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap the text field to enable edit mode.
    await tester.tap(find.byType(TextField));
    await tester.pump();

    // Verify that the back arrow has appeared on screen.
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });

  testWidgets('Show new screen on play button press test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap the play icon to go to the next screen.
    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.pump();

    // Verify that the repeat button has appeared on screen.
    // (means that a new screen was pushed)
    expect(find.byIcon(Icons.play_arrow), findsOneWidget);
  });
}
