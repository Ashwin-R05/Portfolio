/// Interactive orbital skill visualization.
///
/// Skills orbit around a central "core" node in concentric rings grouped
/// by category (Languages → Frameworks → Databases → Cloud).
/// On desktop: full orbital animation with hover tooltips.
/// On mobile: falls back to a categorized grid with proficiency bars.
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/skill.dart';
import '../theme/app_colors.dart';

class SkillOrbit extends StatefulWidget {
  final List<Skill> skills;

  const SkillOrbit({super.key, required this.skills});

  @override
  State<SkillOrbit> createState() => _SkillOrbitState();
}

class _SkillOrbitState extends State<SkillOrbit>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String? _hoveredSkill;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // On mobile, use the grid fallback instead of orbital.
    if (screenWidth < 768) {
      return _MobileSkillGrid(skills: widget.skills);
    }

    return _DesktopOrbit(
      skills: widget.skills,
      controller: _controller,
      hoveredSkill: _hoveredSkill,
      onHover: (name) => setState(() => _hoveredSkill = name),
      onExit: () => setState(() => _hoveredSkill = null),
    );
  }
}

/// Desktop: full orbital visualization.
class _DesktopOrbit extends StatelessWidget {
  final List<Skill> skills;
  final AnimationController controller;
  final String? hoveredSkill;
  final ValueChanged<String> onHover;
  final VoidCallback onExit;

  const _DesktopOrbit({
    required this.skills,
    required this.controller,
    required this.hoveredSkill,
    required this.onHover,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor =
        isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final secondaryColor =
        isDark ? AppColors.darkSecondary : AppColors.lightSecondary;

    // Group skills by category for ring assignment.
    final categories = SkillCategory.values;
    final grouped = <SkillCategory, List<Skill>>{};
    for (final cat in categories) {
      grouped[cat] = skills.where((s) => s.category == cat).toList();
    }

    return SizedBox(
      width: 600,
      height: 600,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _OrbitRingPainter(
              ringCount: categories.length,
              primaryColor: primaryColor,
              isDark: isDark,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Center core node
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        primaryColor,
                        primaryColor.withValues(alpha: 0.3),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withValues(alpha: 0.4),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '</>',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                // Orbiting skill nodes
                ...categories.asMap().entries.expand((entry) {
                  final ringIndex = entry.key;
                  final category = entry.value;
                  final ringSkills = grouped[category] ?? [];
                  final ringRadius = 80.0 + (ringIndex * 60.0);

                  // Different rotation speeds per ring.
                  final speed = (ringIndex.isEven ? 1 : -1) *
                      (1.0 - ringIndex * 0.15);

                  return ringSkills.asMap().entries.map((skillEntry) {
                    final skillIndex = skillEntry.key;
                    final skill = skillEntry.value;
                    final totalInRing = ringSkills.length;

                    // Distribute evenly around the ring.
                    final baseAngle =
                        (2 * pi * skillIndex / totalInRing);
                    final angle =
                        baseAngle + (controller.value * 2 * pi * speed);

                    final x = ringRadius * cos(angle);
                    final y = ringRadius * sin(angle);
                    final isHovered = hoveredSkill == skill.name;

                    return Positioned(
                      left: 300 + x - (isHovered ? 28 : 24),
                      top: 300 + y - (isHovered ? 28 : 24),
                      child: MouseRegion(
                        onEnter: (_) => onHover(skill.name),
                        onExit: (_) => onExit(),
                        child: Tooltip(
                          message: skill.name,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: isHovered ? 56 : 48,
                            height: isHovered ? 56 : 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDark
                                  ? AppColors.darkSurface
                                  : AppColors.lightSurface,
                              border: Border.all(
                                color: isHovered
                                    ? secondaryColor
                                    : primaryColor.withValues(alpha: 0.3),
                                width: isHovered ? 2 : 1,
                              ),
                              boxShadow: isHovered
                                  ? [
                                      BoxShadow(
                                        color: secondaryColor
                                            .withValues(alpha: 0.4),
                                        blurRadius: 16,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Center(
                              child: Icon(
                                skill.icon,
                                size: isHovered ? 22 : 18,
                                color: isHovered
                                    ? secondaryColor
                                    : primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Paints the concentric orbital ring lines.
class _OrbitRingPainter extends CustomPainter {
  final int ringCount;
  final Color primaryColor;
  final bool isDark;

  _OrbitRingPainter({
    required this.ringCount,
    required this.primaryColor,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 0; i < ringCount; i++) {
      final radius = 80.0 + (i * 60.0);
      paint.color = primaryColor.withValues(
        alpha: isDark ? 0.08 + (i * 0.02) : 0.06 + (i * 0.02),
      );
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _OrbitRingPainter oldDelegate) => false;
}

/// Mobile fallback: categorized grid with animated proficiency bars.
class _MobileSkillGrid extends StatelessWidget {
  final List<Skill> skills;

  const _MobileSkillGrid({required this.skills});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor =
        isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

    // Group by category.
    final grouped = <SkillCategory, List<Skill>>{};
    for (final cat in SkillCategory.values) {
      grouped[cat] = skills.where((s) => s.category == cat).toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: grouped.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key.label,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: primaryColor,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              ...entry.value.map((skill) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Icon(skill.icon, size: 18, color: primaryColor),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 80,
                        child: Text(
                          skill.name,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _AnimatedBar(
                          proficiency: skill.proficiency,
                          color: primaryColor,
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      }).toList(),
    );
  }
}

/// Animated proficiency bar that fills on scroll entry.
class _AnimatedBar extends StatefulWidget {
  final double proficiency;
  final Color color;
  final bool isDark;

  const _AnimatedBar({
    required this.proficiency,
    required this.color,
    required this.isDark,
  });

  @override
  State<_AnimatedBar> createState() => _AnimatedBarState();
}

class _AnimatedBarState extends State<_AnimatedBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = Tween<double>(begin: 0, end: widget.proficiency).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    // Small delay for staggered effect.
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Container(
          height: 8,
          decoration: BoxDecoration(
            color: widget.isDark
                ? Colors.white.withValues(alpha: 0.06)
                : Colors.black.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _animation.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: LinearGradient(
                  colors: [
                    widget.color,
                    widget.color.withValues(alpha: 0.6),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withValues(alpha: 0.3),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
