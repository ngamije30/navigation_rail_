// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:navigation_rail/main.dart';

void main() {
  testWidgets('NavigationRail displays and switches sections', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NavigationRailDemoApp());

    // Verify that the NavigationRail and Home section are present.
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.text('Home'), findsWidgets); // label and content

    // Tap the 'Users' destination
    await tester.tap(find.text('Users').first);
    await tester.pump();

    // Verify that the content updates to Users section
    expect(find.textContaining('Users section'), findsOneWidget);
  });
}
