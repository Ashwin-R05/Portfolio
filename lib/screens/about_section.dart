/// About section with terminal-style bio reveal and glassmorphism focus cards.
///
/// Split layout:
/// - Left: Terminal-style animated bio + info chips
/// - Right: Glassmorphism focus-area cards with icon and category gradient accent
/// (stacks vertically on mobile)
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
    final primaryColor = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final secondaryColor = isDark ? AppColors.darkSecondary : AppColors.lightSecondary;

    return SectionWrapper(
      sectionId: 'about',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(title: 'About Me', color: primaryColor),
          const SizedBox(height: 56),

          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TerminalBio(
                      theme: theme,
                      isDark: isDark,
                      primaryColor: primaryColor,
                      secondaryColor: secondaryColor,
                    ),
                    const SizedBox(height: 28),
                    _InfoCards(isDark: isDark, primaryColor: primaryColor, theme: theme),
                    const SizedBox(height: 40),
                    _FocusAreas(isDark: isDark, primaryColor: primaryColor, secondaryColor: secondaryColor, theme: theme),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _TerminalBio(
                            theme: theme,
                            isDark: isDark,
                            primaryColor: primaryColor,
                            secondaryColor: secondaryColor,
                          ),
                          const SizedBox(height: 28),
                          _InfoCards(isDark: isDark, primaryColor: primaryColor, theme: theme),
                        ],
                      ),
                    ),
                    const SizedBox(width: 56),
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

// ── Section title ──────────────────────────────────────────────────────────────

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
            gradient: LinearGradient(colors: [color, color.withValues(alpha: 0.3)]),
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

// ── Terminal-style bio card ────────────────────────────────────────────────────

class _TerminalBio extends StatefulWidget {
  final ThemeData theme;
  final bool isDark;
  final Color primaryColor;
  final Color secondaryColor;

  const _TerminalBio({
    required this.theme,
    required this.isDark,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  State<_TerminalBio> createState() => _TerminalBioState();
}

class _TerminalBioState extends State<_TerminalBio>
    with SingleTickerProviderStateMixin {
  late AnimationController _cursorCtrl;

  @override
  void initState() {
    super.initState();
    _cursorCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _cursorCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final terminalBg = widget.isDark
        ? const Color(0xFF0D1117)
        : const Color(0xFFF0F4F8);

    return Container(
      decoration: BoxDecoration(
        color: terminalBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: widget.primaryColor.withValues(alpha: 0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: widget.primaryColor.withValues(alpha: 0.06),
            blurRadius: 24,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Terminal title bar ───────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: widget.isDark
                  ? Colors.white.withValues(alpha: 0.04)
                  : Colors.black.withValues(alpha: 0.04),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              border: Border(
                bottom: BorderSide(
                  color: widget.primaryColor.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: Row(
              children: [
                // Traffic lights
                _Dot(color: const Color(0xFFFF5F57)),
                const SizedBox(width: 8),
                _Dot(color: const Color(0xFFFFBD2E)),
                const SizedBox(width: 8),
                _Dot(color: const Color(0xFF28C840)),
                const SizedBox(width: 16),
                Text(
                  'ashwin@portfolio ~ %',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: widget.isDark
                        ? Colors.white.withValues(alpha: 0.4)
                        : Colors.black.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
          ),

          // ── Terminal body ────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TerminalLine(
                  prompt: '→',
                  command: 'cat bio.md',
                  promptColor: widget.secondaryColor,
                  isDark: widget.isDark,
                ).animate().fadeIn(duration: 400.ms, delay: 200.ms),

                const SizedBox(height: 14),

                Text(
                  ProfileData.bio,
                  style: widget.theme.textTheme.bodyLarge?.copyWith(
                    height: 1.85,
                    color: widget.isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ).animate().fadeIn(duration: 600.ms, delay: 400.ms),

                const SizedBox(height: 16),

                Row(
                  children: [
                    _TerminalLine(
                      prompt: '→',
                      command: '',
                      promptColor: widget.secondaryColor,
                      isDark: widget.isDark,
                    ),
                    AnimatedBuilder(
                      animation: _cursorCtrl,
                      builder: (context, child) => Opacity(
                        opacity: _cursorCtrl.value,
                        child: Container(
                          width: 9,
                          height: 18,
                          color: widget.secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 400.ms, delay: 800.ms),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 300.ms).slideY(begin: 0.1, end: 0, duration: 600.ms);
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  const _Dot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class _TerminalLine extends StatelessWidget {
  final String prompt;
  final String command;
  final Color promptColor;
  final bool isDark;

  const _TerminalLine({
    required this.prompt,
    required this.command,
    required this.promptColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          prompt,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: promptColor,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          command,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            color: isDark
                ? Colors.white.withValues(alpha: 0.55)
                : Colors.black.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}

// ── Info chips ─────────────────────────────────────────────────────────────────

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
      spacing: 12,
      runSpacing: 12,
      children: [
        _InfoChip(
          icon: Icons.location_on_rounded,
          label: ProfileData.location,
          isDark: isDark,
          color: primaryColor,
          theme: theme,
        ).animate().fadeIn(duration: 500.ms, delay: 400.ms).slideX(begin: -0.1, end: 0),
        _InfoChip(
          icon: Icons.school_rounded,
          label: ProfileData.education,
          isDark: isDark,
          color: primaryColor,
          theme: theme,
        ).animate().fadeIn(duration: 500.ms, delay: 500.ms).slideX(begin: -0.1, end: 0),
        _InfoChip(
          icon: Icons.shield_outlined,
          label: 'Practicing Recon, Security Tools & TryHackMe',
          isDark: isDark,
          color: primaryColor,
          theme: theme,
        ).animate().fadeIn(duration: 500.ms, delay: 600.ms).slideX(begin: -0.1, end: 0),
      ],
    );
  }
}

class _InfoChip extends StatefulWidget {
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
  State<_InfoChip> createState() => _InfoChipState();
}

class _InfoChipState extends State<_InfoChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: _hovered
              ? widget.color.withValues(alpha: 0.14)
              : widget.color.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovered
                ? widget.color.withValues(alpha: 0.4)
                : widget.color.withValues(alpha: 0.15),
          ),
          boxShadow: _hovered
              ? [BoxShadow(color: widget.color.withValues(alpha: 0.12), blurRadius: 12)]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.icon, size: 17, color: widget.color),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                widget.label,
                style: widget.theme.textTheme.bodySmall?.copyWith(
                  color: widget.theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Focus areas — glassmorphism cards ─────────────────────────────────────────

// Each area gets its own gradient
const List<List<Color>> _areaGradients = [
  [Color(0xFF6366F1), Color(0xFF818CF8)],
  [Color(0xFF22D3EE), Color(0xFF0891B2)],
  [Color(0xFF10B981), Color(0xFF059669)],
];

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
        ).animate().fadeIn(duration: 500.ms, delay: 300.ms),
        const SizedBox(height: 20),
        ...ProfileData.focusAreas.asMap().entries.map((entry) {
          final index = entry.key;
          final area = entry.value;
          final delay = 400 + (index * 150);
          final gradColors = _areaGradients[index % _areaGradients.length];

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _GlassFocusBadge(
              icon: area['icon'] as IconData,
              label: area['label'] as String,
              isDark: isDark,
              gradColors: gradColors,
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

class _GlassFocusBadge extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isDark;
  final List<Color> gradColors;
  final ThemeData theme;

  const _GlassFocusBadge({
    required this.icon,
    required this.label,
    required this.isDark,
    required this.gradColors,
    required this.theme,
  });

  @override
  State<_GlassFocusBadge> createState() => _GlassFocusBadgeState();
}

class _GlassFocusBadgeState extends State<_GlassFocusBadge> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final primary = widget.gradColors[0];
    final secondary = widget.gradColors[1];

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: widget.isDark
              ? AppColors.darkSurface
              : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? primary.withValues(alpha: 0.6)
                : primary.withValues(alpha: 0.15),
            width: _isHovered ? 1.5 : 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: primary.withValues(alpha: 0.18),
                    blurRadius: 22,
                    spreadRadius: 0,
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: _isHovered
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [primary, secondary],
                      )
                    : null,
                color: _isHovered ? null : primary.withValues(alpha: 0.1),
                boxShadow: _isHovered
                    ? [BoxShadow(color: primary.withValues(alpha: 0.4), blurRadius: 14)]
                    : [],
              ),
              child: Icon(
                widget.icon,
                color: _isHovered ? Colors.white : primary,
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                widget.label,
                style: widget.theme.textTheme.titleMedium?.copyWith(
                  color: widget.theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: _isHovered ? primary : primary.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
