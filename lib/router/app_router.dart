/// GoRouter configuration for the portfolio app.
///
/// Uses a simple route structure since this is a single-page scroll app.
/// The router still provides proper URL handling for web deployment
/// and supports direct deep links if sections are ever split into pages.
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';

/// Creates the GoRouter instance.
///
/// [isDarkMode] and [onThemeToggle] are passed through to the HomeScreen
/// so the theme state can be managed at the app level.
GoRouter createRouter({
  required bool isDarkMode,
  required VoidCallback onThemeToggle,
}) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: HomeScreen(
              isDarkMode: isDarkMode,
              onThemeToggle: onThemeToggle,
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
          );
        },
      ),
    ],
  );
}
