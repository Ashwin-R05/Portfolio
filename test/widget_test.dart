// Basic smoke test for the portfolio app.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/app.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    // Set a standard desktop screen size to prevent text overflow from fallback fonts
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const PortfolioApp());
    // Verify the app renders by checking for the nav bar "AR" logo.
    expect(find.text('AR'), findsOneWidget);
  });
}
