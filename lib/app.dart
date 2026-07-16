/// Root application widget with theme management.
///
/// Manages the dark/light mode state and provides the MaterialApp.router
/// with the appropriate theme. Dark mode is the default.
import 'package:flutter/material.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  /// Dark mode is the default — this is a design choice to showcase
  /// the cyber-midnight palette and particle canvas at their best.
  bool _isDarkMode = true;

  void _toggleTheme() {
    setState(() => _isDarkMode = !_isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    // GoRouter must be recreated when theme state changes so that
    // the HomeScreen receives the updated isDarkMode value.
    final router = createRouter(
      isDarkMode: _isDarkMode,
      onThemeToggle: _toggleTheme,
    );

    return MaterialApp.router(
      title: 'Ashwin R — Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: router,
    );
  }
}
