/// Data model for social/contact links.
///
/// Stores platform info, URL, icon, and brand color for animated buttons.
import 'package:flutter/material.dart';

class SocialLink {
  final String platform;
  final String url;
  final IconData icon;
  final Color brandColor;
  /// Optional secondary color for gradient effects (e.g. Instagram).
  final Color? brandColorEnd;

  const SocialLink({
    required this.platform,
    required this.url,
    required this.icon,
    required this.brandColor,
    this.brandColorEnd,
  });
}
