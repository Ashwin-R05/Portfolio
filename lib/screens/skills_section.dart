/// Skills section with interactive orbital visualization.
///
/// Desktop: orbital ring visualization where skills orbit a central node.
/// Mobile: categorized grid with animated proficiency bars.
/// Wrapped in SectionWrapper for scroll-triggered entrance.
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../data/profile_data.dart';
import '../theme/app_colors.dart';
import '../widgets/section_wrapper.dart';
import '../widgets/skill_orbit.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final primaryColor =
        isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

    return SectionWrapper(
      sectionId: 'skills',
      child: Column(
        children: [
          // Section title (centered)
          _SectionHeader(primaryColor: primaryColor, theme: theme),
          const SizedBox(height: 16),
          Text(
            'Technologies I work with, visualized.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 200.ms),
          SizedBox(height: isMobile ? 40 : 64),

          // Skill visualization
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isMobile ? double.infinity : 600,
              ),
              child: SkillOrbit(skills: ProfileData.skills)
                  .animate()
                  .fadeIn(duration: 800.ms, delay: 400.ms)
                  .scale(
                    begin: const Offset(0.9, 0.9),
                    end: const Offset(1, 1),
                    duration: 800.ms,
                  ),
            ),
          ),

          if (!isMobile) ...[
            const SizedBox(height: 48),
            // Category legend for desktop
            _CategoryLegend(
              isDark: isDark,
              primaryColor: primaryColor,
              theme: theme,
            ),
          ],
        ],
      ),
    );
  }
}

/// Section header with centered title and accent underline.
class _SectionHeader extends StatelessWidget {
  final Color primaryColor;
  final ThemeData theme;

  const _SectionHeader({
    required this.primaryColor,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Skills & Technologies',
          style: theme.textTheme.displaySmall?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        )
            .animate()
            .fadeIn(duration: 500.ms)
            .slideY(begin: 0.1, end: 0, duration: 500.ms),
        const SizedBox(height: 12),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: LinearGradient(
              colors: [primaryColor, primaryColor.withValues(alpha: 0.3)],
            ),
          ),
        ).animate().scaleX(
              begin: 0,
              end: 1,
              duration: 600.ms,
              delay: 200.ms,
            ),
      ],
    );
  }
}

/// Legend showing what each orbital ring represents.
class _CategoryLegend extends StatelessWidget {
  final bool isDark;
  final Color primaryColor;
  final ThemeData theme;

  const _CategoryLegend({
    required this.isDark,
    required this.primaryColor,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final categories = ['Languages', 'Frameworks', 'Databases', 'Cloud & Tools'];

    return Wrap(
      spacing: 24,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: categories.asMap().entries.map((entry) {
        final index = entry.key;
        final label = entry.value;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withValues(
                  alpha: 0.3 + (index * 0.2),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '$label (Ring ${index + 1})',
              style: theme.textTheme.labelMedium,
            ),
          ],
        );
      }).toList(),
    )
        .animate()
        .fadeIn(duration: 500.ms, delay: 800.ms);
  }
}
