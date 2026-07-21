/// Expandable project case-study card with holographic animated border.
///
/// Collapsed: shows title, subtitle, number label, tech stack chips.
/// Expanded: reveals problem statement, key features, and action buttons.
/// Features:
/// - Animated conic-gradient border that rotates on hover/expand
/// - Subtle glass-surface card background
/// - Smooth AnimatedCrossFade expand/collapse
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project.dart';
import '../theme/app_colors.dart';

// Each project gets its own two-color gradient identity.
const List<List<Color>> _projectGradients = [
  [Color(0xFF6366F1), Color(0xFF22D3EE)], // Summarizit: indigo → cyan
  [Color(0xFF10B981), Color(0xFF6366F1)], // Task_Flow: emerald → indigo
];

class ProjectCard extends StatefulWidget {
  final Project project;
  final int index;

  const ProjectCard({
    super.key,
    required this.project,
    required this.index,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  bool _isHovered = false;
  late AnimationController _borderCtrl;

  List<Color> get _gradColors =>
      _projectGradients[widget.index % _projectGradients.length];

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  void initState() {
    super.initState();
    _borderCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _borderCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = _gradColors[0];
    final secondary = _gradColors[1];
    final surfaceColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedBuilder(
        animation: _borderCtrl,
        builder: (context, child) {
          final active = _isHovered || _isExpanded;
          return Stack(
            children: [
              // ── Animated rotating gradient border ────────────────────
              if (active)
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(21),
                    child: CustomPaint(
                      painter: _RotatingBorderPainter(
                        progress: _borderCtrl.value,
                        colors: _gradColors,
                        borderRadius: 21,
                        borderWidth: 2,
                      ),
                    ),
                  ),
                ),

              // ── Card body (inset by border width) ────────────────────
              Padding(
                padding: EdgeInsets.all(active ? 2.0 : 0.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 280),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(20),
                    border: active
                        ? null
                        : Border.all(
                            color: borderColor.withValues(alpha: 0.25),
                            width: 1,
                          ),
                    boxShadow: active
                        ? [
                            BoxShadow(
                              color: primary.withValues(alpha: 0.18),
                              blurRadius: 32,
                              spreadRadius: 0,
                            ),
                            BoxShadow(
                              color: secondary.withValues(alpha: 0.08),
                              blurRadius: 60,
                              spreadRadius: 0,
                            ),
                          ]
                        : [],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => setState(() => _isExpanded = !_isExpanded),
                      splashColor: primary.withValues(alpha: 0.08),
                      highlightColor: primary.withValues(alpha: 0.04),
                      child: Padding(
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ── Header ────────────────────────────────
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Gradient project number badge
                                Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: _gradColors,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primary.withValues(alpha: 0.4),
                                        blurRadius: 14,
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Icon(
                                      widget.index == 0
                                          ? Icons.auto_awesome_rounded
                                          : Icons.task_alt_rounded,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 18),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.project.title,
                                        style: theme.textTheme.headlineSmall?.copyWith(
                                          color: theme.colorScheme.onSurface,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      ShaderMask(
                                        shaderCallback: (bounds) =>
                                            LinearGradient(colors: _gradColors)
                                                .createShader(bounds),
                                        child: Text(
                                          widget.project.subtitle,
                                          style: theme.textTheme.bodyMedium?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                AnimatedRotation(
                                  turns: _isExpanded ? 0.5 : 0,
                                  duration: const Duration(milliseconds: 300),
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: primary.withValues(alpha: 0.1),
                                    ),
                                    child: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: primary,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // ── Tech Stack Chips ───────────────────────
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: widget.project.stack.map((tech) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: primary.withValues(alpha: 0.08),
                                    border: Border.all(
                                      color: primary.withValues(alpha: 0.22),
                                    ),
                                  ),
                                  child: Text(
                                    tech,
                                    style: theme.textTheme.labelMedium?.copyWith(
                                      color: primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            // ── Expanded content ───────────────────────
                            AnimatedCrossFade(
                              firstChild: const SizedBox.shrink(),
                              secondChild: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 24),
                                  _GradientDivider(colors: _gradColors),
                                  const SizedBox(height: 20),

                                  _ExpandedLabel('The Problem', theme: theme),
                                  const SizedBox(height: 8),
                                  Text(
                                    widget.project.problem,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      height: 1.7,
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.75),
                                    ),
                                  ),
                                  const SizedBox(height: 24),

                                  _ExpandedLabel('Key Features', theme: theme),
                                  const SizedBox(height: 12),
                                  ...widget.project.features.map((f) => Padding(
                                        padding: const EdgeInsets.only(bottom: 9),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(top: 5),
                                              width: 7,
                                              height: 7,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: LinearGradient(
                                                  colors: _gradColors,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Text(
                                                f,
                                                style: theme.textTheme.bodyMedium
                                                    ?.copyWith(height: 1.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),

                                  const SizedBox(height: 20),

                                  Wrap(
                                    spacing: 12,
                                    children: [
                                      if (widget.project.githubUrl != null)
                                        _ActionChip(
                                          icon: Icons.code_rounded,
                                          label: 'View Source',
                                          onTap: () => _launchUrl(widget.project.githubUrl!),
                                          gradColors: _gradColors,
                                        ),
                                      if (widget.project.liveUrl != null)
                                        _ActionChip(
                                          icon: Icons.launch_rounded,
                                          label: 'Live Demo',
                                          onTap: () => _launchUrl(widget.project.liveUrl!),
                                          gradColors: [_gradColors[1], _gradColors[0]],
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              crossFadeState: _isExpanded
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              duration: const Duration(milliseconds: 400),
                              sizeCurve: Curves.easeInOut,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ── Rotating gradient border painter ──────────────────────────────────────────

class _RotatingBorderPainter extends CustomPainter {
  final double progress;
  final List<Color> colors;
  final double borderRadius;
  final double borderWidth;

  const _RotatingBorderPainter({
    required this.progress,
    required this.colors,
    required this.borderRadius,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    final paint = Paint()
      ..shader = SweepGradient(
        colors: [
          ...colors,
          colors.first.withValues(alpha: 0.3),
          colors.last.withValues(alpha: 0),
          ...colors.reversed,
          colors.first,
        ],
        transform: GradientRotation(progress * 2 * pi),
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _RotatingBorderPainter old) =>
      old.progress != progress;
}

// ── Gradient divider ──────────────────────────────────────────────────────────

class _GradientDivider extends StatelessWidget {
  final List<Color> colors;
  const _GradientDivider({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors[0].withValues(alpha: 0.6),
            colors[1].withValues(alpha: 0.6),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}

// ── Expanded section label ────────────────────────────────────────────────────

class _ExpandedLabel extends StatelessWidget {
  final String text;
  final ThemeData theme;
  const _ExpandedLabel(this.text, {required this.theme});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: theme.textTheme.titleMedium?.copyWith(
        color: theme.colorScheme.onSurface,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    );
  }
}

// ── Action chip ───────────────────────────────────────────────────────────────

class _ActionChip extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final List<Color> gradColors;

  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.gradColors,
  });

  @override
  State<_ActionChip> createState() => _ActionChipState();
}

class _ActionChipState extends State<_ActionChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: _isHovered
                ? LinearGradient(colors: widget.gradColors)
                : null,
            color: _isHovered
                ? null
                : widget.gradColors[0].withValues(alpha: 0.08),
            border: Border.all(
              color: _isHovered
                  ? Colors.transparent
                  : widget.gradColors[0].withValues(alpha: 0.3),
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.gradColors[0].withValues(alpha: 0.35),
                      blurRadius: 14,
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon,
                  size: 16,
                  color: _isHovered ? Colors.white : widget.gradColors[0]),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  color: _isHovered ? Colors.white : widget.gradColors[0],
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
