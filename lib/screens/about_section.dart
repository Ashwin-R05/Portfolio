/// About section with visual representation of focus areas.
///
/// Split layout: animated focus-area badges with icons on the left,
/// bio text on the right (stacks vertically on mobile).
/// Each item enters with a staggered animation on scroll.
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../data/profile_data.dart';
import '../theme/app_colors.dart';
import '../widgets/section_wrapper.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;
    final primaryColor =
        isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final secondaryColor =
        isDark ? AppColors.darkSecondary : AppColors.lightSecondary;

    return SectionWrapper(
      sectionId: 'about',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          _SectionTitle(title: 'About Me', color: primaryColor),
          const SizedBox(height: 48),

          // Main content — responsive split
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _BioText(theme: theme),
                    const SizedBox(height: 40),
                    _FocusAreas(
                      isDark: isDark,
                      primaryColor: primaryColor,
                      secondaryColor: secondaryColor,
                      theme: theme,
                    ),
                    const SizedBox(height: 32),
                    _InfoCards(
                      isDark: isDark,
                      primaryColor: primaryColor,
                      theme: theme,
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left: Bio + Info cards
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _BioText(theme: theme),
                          const SizedBox(height: 32),
                          _InfoCards(
                            isDark: isDark,
                            primaryColor: primaryColor,
                            theme: theme,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 64),
                    // Right: Focus areas
                    Expanded(
                      flex: 4,
                      child: _FocusAreas(
                        isDark: isDark,
                        primaryColor: primaryColor,
                        secondaryColor: secondaryColor,
                        theme: theme,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

/// Section title with accent underline.
class _SectionTitle extends StatelessWidget {
  final String title;
  final Color color;

  const _SectionTitle({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        )
            .animate()
            .fadeIn(duration: 500.ms)
            .slideX(begin: -0.1, end: 0, duration: 500.ms),
        const SizedBox(height: 12),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: LinearGradient(
              colors: [color, color.withValues(alpha: 0.3)],
            ),
          ),
        ).animate().scaleX(
              begin: 0,
              end: 1,
              duration: 600.ms,
              delay: 200.ms,
              alignment: Alignment.centerLeft,
            ),
      ],
    );
  }
}

/// Bio paragraph text.
class _BioText extends StatelessWidget {
  final ThemeData theme;

  const _BioText({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Text(
      ProfileData.bio,
      style: theme.textTheme.bodyLarge?.copyWith(height: 1.8),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 300.ms)
        .slideY(begin: 0.1, end: 0, duration: 600.ms);
  }
}

/// Location and Education info cards.
class _InfoCards extends StatelessWidget {
  final bool isDark;
  final Color primaryColor;
  final ThemeData theme;

  const _InfoCards({
    required this.isDark,
    required this.primaryColor,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _InfoChip(
          icon: Icons.location_on_rounded,
          label: ProfileData.location,
          isDark: isDark,
          color: primaryColor,
          theme: theme,
        )
            .animate()
            .fadeIn(duration: 500.ms, delay: 400.ms)
            .slideX(begin: -0.1, end: 0),
        _InfoChip(
          icon: Icons.school_rounded,
          label: ProfileData.education,
          isDark: isDark,
          color: primaryColor,
          theme: theme,
        )
            .animate()
            .fadeIn(duration: 500.ms, delay: 500.ms)
            .slideX(begin: -0.1, end: 0),
        _InfoChip(
          icon: Icons.auto_stories_rounded,
          label: 'Currently learning Java & DSA',
          isDark: isDark,
          color: primaryColor,
          theme: theme,
        )
            .animate()
            .fadeIn(duration: 500.ms, delay: 600.ms)
            .slideX(begin: -0.1, end: 0),
      ],
    );
  }
}

/// Small info chip with icon.
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;
  final Color color;
  final ThemeData theme;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.isDark,
    required this.color,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Animated focus area badges.
class _FocusAreas extends StatelessWidget {
  final bool isDark;
  final Color primaryColor;
  final Color secondaryColor;
  final ThemeData theme;

  const _FocusAreas({
    required this.isDark,
    required this.primaryColor,
    required this.secondaryColor,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What I Do',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        )
            .animate()
            .fadeIn(duration: 500.ms, delay: 300.ms),
        const SizedBox(height: 20),
        ...ProfileData.focusAreas.asMap().entries.map((entry) {
          final index = entry.key;
          final area = entry.value;
          final delay = 400 + (index * 150);

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _FocusBadge(
              icon: area['icon'] as IconData,
              label: area['label'] as String,
              isDark: isDark,
              primaryColor: primaryColor,
              secondaryColor: secondaryColor,
              theme: theme,
            )
                .animate()
                .fadeIn(duration: 500.ms, delay: Duration(milliseconds: delay))
                .slideX(begin: 0.2, end: 0, duration: 500.ms),
          );
        }),
      ],
    );
  }
}

/// Individual focus area badge with icon and animated hover.
class _FocusBadge extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isDark;
  final Color primaryColor;
  final Color secondaryColor;
  final ThemeData theme;

  const _FocusBadge({
    required this.icon,
    required this.label,
    required this.isDark,
    required this.primaryColor,
    required this.secondaryColor,
    required this.theme,
  });

  @override
  State<_FocusBadge> createState() => _FocusBadgeState();
}

class _FocusBadgeState extends State<_FocusBadge> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: widget.isDark
              ? AppColors.darkSurface
              : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? widget.secondaryColor.withValues(alpha: 0.5)
                : (widget.isDark
                    ? AppColors.darkBorder
                    : AppColors.lightBorder)
                    .withValues(alpha: 0.3),
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.secondaryColor.withValues(alpha: 0.15),
                    blurRadius: 20,
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _isHovered
                    ? widget.secondaryColor.withValues(alpha: 0.15)
                    : widget.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                widget.icon,
                color: _isHovered
                    ? widget.secondaryColor
                    : widget.primaryColor,
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                widget.label,
                style: widget.theme.textTheme.titleMedium?.copyWith(
                  color: widget.theme.colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
