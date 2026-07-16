/// Color palette constants for the portfolio app.
///
/// Defines a curated "Cyber-Midnight" palette with full dark + light mode
/// support. Colors are chosen for high contrast, readability, and a premium
/// tech aesthetic.
import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // Prevent instantiation

  // ── Dark Mode (Default) ──────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF0A0E1A);
  static const Color darkSurface = Color(0xFF111827);
  static const Color darkSurfaceVariant = Color(0xFF1E293B);
  static const Color darkPrimary = Color(0xFF6366F1); // Electric indigo
  static const Color darkSecondary = Color(0xFF22D3EE); // Electric cyan
  static const Color darkAccent = Color(0xFFF59E0B); // Warm amber
  static const Color darkTextPrimary = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkBorder = Color(0xFF1E293B);

  // ── Light Mode ───────────────────────────────────────────────────────
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF1F5F9);
  static const Color lightPrimary = Color(0xFF4F46E5); // Deeper indigo
  static const Color lightSecondary = Color(0xFF0891B2); // Deeper cyan
  static const Color lightAccent = Color(0xFFD97706); // Deeper amber
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);
  static const Color lightBorder = Color(0xFFE2E8F0);

  // ── Shared / Brand Colors ───────────────────────────────────────────
  static const Color githubColor = Color(0xFF333333);
  static const Color linkedinColor = Color(0xFF0A66C2);
  static const Color instagramGradientStart = Color(0xFFF58529);
  static const Color instagramGradientEnd = Color(0xFFDD2A7B);
  static const Color emailColor = Color(0xFFEA4335);

  // ── Glow / Effect Colors ────────────────────────────────────────────
  static const Color particleGlow = Color(0xFF6366F1);
  static const Color particleLine = Color(0x336366F1); // 20% opacity indigo
  static const Color cyanGlow = Color(0x4422D3EE); // 27% opacity cyan
}
