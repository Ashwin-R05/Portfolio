/// Projects section with expandable case-study cards.
///
/// Each project is displayed as an interactive card that expands
/// to reveal problem statement, key features, and links.
/// Cards enter from alternating sides with staggered animation.
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../data/profile_data.dart';
import '../theme/app_colors.dart';
import '../widgets/project_card.dart';
import '../widgets/section_wrapper.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor =
        isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final screenWidth = MediaQuery.of(context).size.width;

    return SectionWrapper(
      sectionId: 'projects',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Featured Projects',
                style: theme.textTheme.displaySmall?.copyWith(
                  color: theme.colorScheme.onSurface,
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
                    colors: [primaryColor, primaryColor.withValues(alpha: 0.3)],
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
          ),
          const SizedBox(height: 16),
          Text(
            'Click on a project to explore the details.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.7),
            ),
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 200.ms),
          const SizedBox(height: 48),

          // Project cards — constrained width for readability
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: screenWidth > 1200 ? 800 : double.infinity,
              ),
              child: Column(
                children: ProfileData.projects.asMap().entries.map((entry) {
                  final index = entry.key;
                  final project = entry.value;
                  final delay = 400 + (index * 200);
                  // Alternate entrance direction
                  final slideX = index.isEven ? -0.05 : 0.05;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: ProjectCard(
                      project: project,
                      index: index,
                    )
                        .animate()
                        .fadeIn(
                          duration: 600.ms,
                          delay: Duration(milliseconds: delay),
                        )
                        .slideX(
                          begin: slideX,
                          end: 0,
                          duration: 600.ms,
                          delay: Duration(milliseconds: delay),
                        ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
