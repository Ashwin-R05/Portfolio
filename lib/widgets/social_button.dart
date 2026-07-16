/// Animated social link button with brand-color hover effects.
///
/// On hover: icon scales up, background shifts to the platform's brand color,
/// and a subtle glow appears. Works with both solid and gradient brand colors.
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/social_link.dart';

class SocialButton extends StatefulWidget {
  final SocialLink link;
  final double size;

  const SocialButton({
    super.key,
    required this.link,
    this.size = 48,
  });

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool _isHovered = false;

  Future<void> _launchUrl() async {
    final uri = Uri.parse(widget.link.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark
        ? const Color(0xFF1E293B)
        : const Color(0xFFF1F5F9);
    final brandColor = widget.link.brandColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _launchUrl,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          width: widget.size,
          height: widget.size,
          transform: Matrix4.diagonal3Values(
            _isHovered ? 1.15 : 1.0,
            _isHovered ? 1.15 : 1.0,
            1.0,
          ),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            color: _isHovered ? brandColor : surfaceColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _isHovered
                  ? brandColor.withValues(alpha: 0.6)
                  : (isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.06)),
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: brandColor.withValues(alpha: 0.4),
                      blurRadius: 16,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Icon(
              widget.link.icon,
              color: _isHovered ? Colors.white : brandColor,
              size: widget.size * 0.45,
            ),
          ),
        ),
      ),
    );
  }
}
