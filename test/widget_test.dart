// Basic smoke test for the portfolio app.
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/app.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());
    // Verify the app renders by checking for the nav bar "AR" logo.
    expect(find.text('AR'), findsOneWidget);
  });
}
