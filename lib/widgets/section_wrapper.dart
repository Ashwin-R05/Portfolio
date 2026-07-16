/// Scroll-triggered section wrapper with entrance animations.
///
/// Wraps each portfolio section and uses [VisibilityDetector] to trigger
/// a staggered fade + slide-in animation when the section scrolls into
/// the viewport. The animation only fires once (no re-triggering on
/// scroll back up).
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SectionWrapper extends StatefulWidget {
  /// Unique identifier for the section (used as scroll anchor & visibility key).
  final String sectionId;

  /// The section content to animate in.
  final Widget child;

  /// Delay before the entrance animation starts (for staggering).
  final Duration delay;

  /// Optional background color override.
  final Color? backgroundColor;

  /// Optional padding override. Defaults to responsive horizontal padding.
  final EdgeInsetsGeometry? padding;

  const SectionWrapper({
    super.key,
    required this.sectionId,
    required this.child,
    this.delay = Duration.zero,
    this.backgroundColor,
    this.padding,
  });

  @override
  State<SectionWrapper> createState() => _SectionWrapperState();
}

class _SectionWrapperState extends State<SectionWrapper> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive horizontal padding: more on desktop, less on mobile.
    final horizontalPadding = screenWidth > 1200
        ? screenWidth * 0.1
        : screenWidth > 768
            ? 48.0
            : 24.0;

    return VisibilityDetector(
      key: Key(widget.sectionId),
      onVisibilityChanged: (info) {
        // Trigger when at least 15% of the section is visible.
        if (info.visibleFraction > 0.15 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: Container(
        width: double.infinity,
        color: widget.backgroundColor,
        padding: widget.padding ??
            EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 80,
            ),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOut,
          opacity: _isVisible ? 1.0 : 0.0,
          child: AnimatedSlide(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOut,
            offset: _isVisible ? Offset.zero : const Offset(0, 0.05),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
