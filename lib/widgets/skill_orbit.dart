/// Interactive orbital skill visualization.
///
/// Skills orbit around a central "core" node in concentric rings grouped
/// by category (Languages → Frameworks → Databases → Cloud).
/// Features:
/// - Comet-tail trailing arcs drawn behind each orbiting node
/// - Ring segments that glow in the category color
/// - Hover tooltips with animated glow
/// - Mobile fallback: categorized grid with animated proficiency bars
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

// ── Desktop orbital visualization ─────────────────────────────────────────────

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

  // One accent color per ring category
  static const List<Color> _ringColors = [
    Color(0xFF6366F1), // indigo — Languages
    Color(0xFF22D3EE), // cyan   — Frameworks
    Color(0xFF10B981), // emerald — Databases
    Color(0xFFF59E0B), // amber  — Cloud
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

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
              animValue: controller.value,
              ringColors: _ringColors,
              isDark: isDark,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // ── Center core node ────────────────────────────────
                _CoreNode(primaryColor: primaryColor, animValue: controller.value),

                // ── Orbiting skill nodes ─────────────────────────────
                ...categories.asMap().entries.expand((entry) {
                  final ringIndex = entry.key;
                  final category = entry.value;
                  final ringSkills = grouped[category] ?? [];
                  final ringRadius = 80.0 + (ringIndex * 60.0);
                  final ringColor = _ringColors[ringIndex];
                  final speed = (ringIndex.isEven ? 1 : -1) * (1.0 - ringIndex * 0.15);

                  return ringSkills.asMap().entries.map((skillEntry) {
                    final skillIndex = skillEntry.key;
                    final skill = skillEntry.value;
                    final totalInRing = ringSkills.length;
                    final baseAngle = 2 * pi * skillIndex / totalInRing;
                    final angle = baseAngle + controller.value * 2 * pi * speed;

                    final x = ringRadius * cos(angle);
                    final y = ringRadius * sin(angle);
                    final isHovered = hoveredSkill == skill.name;
                    final nodeSize = isHovered ? 56.0 : 48.0;
                    final halfNode = nodeSize / 2;

                    return Positioned(
                      left: 300 + x - halfNode,
                      top: 300 + y - halfNode,
                      child: MouseRegion(
                        onEnter: (_) => onHover(skill.name),
                        onExit: (_) => onExit(),
                        child: Tooltip(
                          message: skill.name,
                          preferBelow: false,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: nodeSize,
                            height: nodeSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                              border: Border.all(
                                color: isHovered
                                    ? ringColor
                                    : ringColor.withValues(alpha: 0.35),
                                width: isHovered ? 2 : 1,
                              ),
                              boxShadow: isHovered
                                  ? [
                                      BoxShadow(
                                        color: ringColor.withValues(alpha: 0.55),
                                        blurRadius: 20,
                                        spreadRadius: 2,
                                      ),
                                      BoxShadow(
                                        color: ringColor.withValues(alpha: 0.2),
                                        blurRadius: 40,
                                      ),
                                    ]
                                  : [
                                      BoxShadow(
                                        color: ringColor.withValues(alpha: 0.12),
                                        blurRadius: 8,
                                      ),
                                    ],
                            ),
                            child: Center(
                              child: Icon(
                                skill.icon,
                                size: isHovered ? 22 : 18,
                                color: isHovered ? ringColor : ringColor.withValues(alpha: 0.7),
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

// ── Core pulsing node ──────────────────────────────────────────────────────────

class _CoreNode extends StatelessWidget {
  final Color primaryColor;
  final double animValue;

  const _CoreNode({required this.primaryColor, required this.animValue});

  @override
  Widget build(BuildContext context) {
    final pulseScale = 1.0 + sin(animValue * 2 * pi * 2) * 0.04;

    return Transform.scale(
      scale: pulseScale,
      child: Container(
        width: 82,
        height: 82,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              primaryColor,
              primaryColor.withValues(alpha: 0.35),
            ],
            stops: const [0.4, 1.0],
          ),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withValues(alpha: 0.55),
              blurRadius: 28,
              spreadRadius: 3,
            ),
            BoxShadow(
              color: primaryColor.withValues(alpha: 0.2),
              blurRadius: 60,
              spreadRadius: 8,
            ),
          ],
        ),
        child: const Center(
          child: Text(
            '</>',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Orbit ring painter with comet arcs ────────────────────────────────────────

class _OrbitRingPainter extends CustomPainter {
  final int ringCount;
  final double animValue;
  final List<Color> ringColors;
  final bool isDark;

  _OrbitRingPainter({
    required this.ringCount,
    required this.animValue,
    required this.ringColors,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < ringCount; i++) {
      final radius = 80.0 + (i * 60.0);
      final ringColor = ringColors[i];

      // ── Base ring track ──────────────────────────────────────────
      final trackPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = ringColor.withValues(alpha: isDark ? 0.1 : 0.07);
      canvas.drawCircle(center, radius, trackPaint);

      // ── Comet arc — glowing arc that travels around the ring ─────
      final speed = (i.isEven ? 1.0 : -1.0) * (1.0 - i * 0.15);
      final arcStart = animValue * 2 * pi * speed;
      const arcSweep = pi / 2.5; // ~72° comet tail

      final arcPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round
        ..shader = SweepGradient(
          colors: [
            ringColor.withValues(alpha: 0.0),
            ringColor.withValues(alpha: 0.7),
            ringColor.withValues(alpha: 0.0),
          ],
          stops: const [0.0, 0.5, 1.0],
          transform: GradientRotation(arcStart),
        ).createShader(
          Rect.fromCircle(center: center, radius: radius),
        );

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        arcStart,
        arcSweep,
        false,
        arcPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _OrbitRingPainter old) =>
      old.animValue != animValue;
}

// ── Mobile fallback ────────────────────────────────────────────────────────────

class _MobileSkillGrid extends StatelessWidget {
  final List<Skill> skills;
  const _MobileSkillGrid({required this.skills});

  static const List<Color> _catColors = [
    Color(0xFF6366F1),
    Color(0xFF22D3EE),
    Color(0xFF10B981),
    Color(0xFFF59E0B),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final grouped = <SkillCategory, List<Skill>>{};
    for (final cat in SkillCategory.values) {
      grouped[cat] = skills.where((s) => s.category == cat).toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: grouped.entries.toList().asMap().entries.map((outer) {
        final catIndex = outer.key;
        final entry = outer.value;
        final catColor = _catColors[catIndex % _catColors.length];

        return Padding(
          padding: const EdgeInsets.only(bottom: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: catColor,
                      boxShadow: [
                        BoxShadow(color: catColor.withValues(alpha: 0.5), blurRadius: 6),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    entry.key.label,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: catColor,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ...entry.value.map((skill) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: catColor.withValues(alpha: 0.1),
                            border: Border.all(color: catColor.withValues(alpha: 0.3)),
                          ),
                          child: Icon(skill.icon, size: 16, color: catColor),
                        ),
                        const SizedBox(width: 12),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 130),
                          child: Text(
                            skill.name,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _AnimatedBar(
                            proficiency: skill.proficiency,
                            color: catColor,
                            isDark: isDark,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${(skill.proficiency * 100).round()}%',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: catColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ── Animated proficiency bar ───────────────────────────────────────────────────

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
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _anim = Tween<double>(begin: 0, end: widget.proficiency).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, _) => Container(
        height: 7,
        decoration: BoxDecoration(
          color: widget.isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.black.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(4),
        ),
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: _anim.value,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                colors: [widget.color, widget.color.withValues(alpha: 0.55)],
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withValues(alpha: 0.4),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
