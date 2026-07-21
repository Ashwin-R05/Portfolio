// Basic smoke test for the portfolio app.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/app.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    // Set the visibility detector update interval to zero for tests to avoid pending timers
    VisibilityDetectorController.instance.updateInterval = Duration.zero;

    // Set a standard desktop screen size to prevent text overflow from fallback fonts
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const PortfolioApp());
    // Verify the app renders by checking for the nav bar "ASHWIN R" logo.
    expect(find.text('ASHWIN R'), findsOneWidget);

    // Dispose of the widget tree to cancel periodic timers and animation controllers
    await tester.pumpWidget(const SizedBox.shrink());
    // Advance clock to let any scheduled VisibilityDetector timers complete
    await tester.pump(const Duration(milliseconds: 500));
  });
}
