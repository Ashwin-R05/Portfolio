/// Entry point for the Ashwin R Portfolio app.
///
/// Supports Flutter Web (responsive), Android, and iOS from a single
/// codebase. The app starts in dark mode by default.
import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp());
}
