/// Hero / Landing section.
///
/// Full-viewport-height introduction with:
/// - Animated particle canvas background with aurora vortex
/// - Gradient-shimmer name in Space Grotesk (shader animation)
/// - Animated availability badge with pulsing border
/// - Simple role title
/// - Typewriter tagline cycling through phrases
/// - Glowing CTA + Download Resume button
/// - Staggered entrance animations
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../animations/particle_canvas.dart';
import '../data/profile_data.dart';
import '../theme/app_colors.dart';
import '../widgets/animated_text.dart';
import '../widgets/glow_button.dart';
import '../widgets/id_card.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onExplorePressed;
  const HeroSection({super.key, required this.onExplorePressed});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  Future<void> _downloadResume() async {
    final Uri url = Uri.parse('resume.pdf');
    try {
      await launchUrl(
        url,
        webOnlyWindowName: '_blank',
      );
    } catch (_) {
      final Uri assetUrl = Uri.parse('assets/resume.pdf');
      await launchUrl(
        assetUrl,
        webOnlyWindowName: '_blank',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;
    final primaryColor = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final secondaryColor = isDark ? AppColors.darkSecondary : AppColors.lightSecondary;

    // Text content column
    final textContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // ── Animated badge ──────────────────────────────────
        _PulsingBadge(
          text: '⚡ Available for opportunities',
          primaryColor: primaryColor,
          secondaryColor: secondaryColor,
          isDark: isDark,
        )
            .animate()
            .fadeIn(duration: 700.ms, delay: 100.ms)
            .slideY(begin: -0.3, end: 0, duration: 700.ms),

        const SizedBox(height: 20),

        // ── Greeting ──────────────────────────────────────
        Text(
          'Hello, I\'m',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: primaryColor,
            fontWeight: FontWeight.w400,
            letterSpacing: 2,
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 200.ms)
            .slideX(begin: -0.2, end: 0, duration: 600.ms),

        const SizedBox(height: 8),

        // ── Name with shimmer gradient ─────────────────────
        AnimatedBuilder(
          animation: _shimmerController,
          builder: (context, _) {
            return ShaderMask(
              shaderCallback: (bounds) {
                final shimmerOffset = _shimmerController.value;
                return LinearGradient(
                  begin: Alignment(-1.5 + shimmerOffset * 4, 0),
                  end: Alignment(1.5 + shimmerOffset * 4, 0),
                  colors: [
                    primaryColor,
                    secondaryColor,
                    primaryColor,
                    AppColors.darkAccent,
                    primaryColor,
                  ],
                  stops: const [0.0, 0.2, 0.4, 0.6, 1.0],
                ).createShader(bounds);
              },
              child: Text(
                ProfileData.name,
                style: (isMobile
                        ? theme.textTheme.displayMedium
                        : theme.textTheme.displayLarge)
                    ?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.5,
                  height: 1.0,
                ),
                textAlign: isMobile ? TextAlign.center : TextAlign.start,
              ),
            );
          },
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 400.ms)
            .slideY(begin: 0.2, end: 0, duration: 600.ms),

        const SizedBox(height: 12),

        // ── Role title ─────────────────────────
        Text(
          ProfileData.role,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.75),
            fontWeight: FontWeight.w300,
            letterSpacing: 0.5,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 600.ms)
            .slideY(begin: 0.2, end: 0, duration: 600.ms),

        const SizedBox(height: 20),

        // ── Typewriter tagline ────────────────────────────
        AnimatedTypewriter(
          phrases: ProfileData.heroTypingPhrases,
          style: theme.textTheme.titleLarge?.copyWith(
            color: isDark
                ? AppColors.darkSecondary
                : AppColors.lightSecondary,
            fontWeight: FontWeight.w400,
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 800.ms),

        const SizedBox(height: 32),

        // ── CTA buttons ───────────────────────────────────
        Wrap(
          spacing: 16,
          runSpacing: 12,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            GlowButton(
              label: 'Explore My Work',
              icon: Icons.arrow_downward_rounded,
              onPressed: widget.onExplorePressed,
            ),
            _OutlineButton(
              label: 'Download Resume',
              icon: Icons.description_rounded,
              primaryColor: primaryColor,
              onPressed: _downloadResume,
            ),
          ],
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 1000.ms)
            .slideY(begin: 0.4, end: 0, duration: 600.ms),

        const SizedBox(height: 36),

        // ── Quick Glassmorphic Stats Row ──────────────────────
        _HeroStatsRow(
          isDark: isDark,
          primaryColor: primaryColor,
          secondaryColor: secondaryColor,
          isMobile: isMobile,
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 1200.ms)
            .slideY(begin: 0.3, end: 0, duration: 600.ms),
      ],
    );

    // Falling ID Card widget — realistic free-fall with pendulum settle
    final idCardWidget = DeveloperIdCard(isDark: isDark)
        .animate()
        .fadeIn(duration: 400.ms, delay: 200.ms)
        .slideY(
          begin: -2.0,
          end: 0,
          duration: 1400.ms,
          delay: 200.ms,
          curve: Curves.bounceOut,
        )
        .rotate(
          begin: 0.06,
          end: 0,
          duration: 1800.ms,
          delay: 400.ms,
          curve: Curves.elasticOut,
        )
        .scale(
          begin: const Offset(0.85, 0.85),
          end: const Offset(1.0, 1.0),
          duration: 800.ms,
          delay: 200.ms,
          curve: Curves.easeOutBack,
        );

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          // ── Particle background ───────────────────────────────────────
          const Positioned.fill(child: ParticleCanvas()),

          // ── Ambient Glow Orbs in background ───────────────────────────
          Positioned(
            left: screenWidth * 0.15,
            top: MediaQuery.of(context).size.height * 0.2,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    primaryColor.withValues(alpha: 0.18),
                    primaryColor.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: screenWidth * 0.15,
            bottom: MediaQuery.of(context).size.height * 0.15,
            child: Container(
              width: 380,
              height: 380,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    secondaryColor.withValues(alpha: 0.15),
                    secondaryColor.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),

          // ── Diagonal gradient overlay ──────────────────────────────────
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.transparent,
                    (isDark ? AppColors.darkBackground : AppColors.lightBackground)
                        .withValues(alpha: 0.55),
                  ],
                  stops: const [0.3, 1.0],
                ),
              ),
            ),
          ),

          // ── Main Content Container ─────────────────────────────────────
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : 48,
                    vertical: 40,
                  ),
                  child: isMobile
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 40),
                            idCardWidget,
                            const SizedBox(height: 36),
                            textContent,
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 6,
                              child: textContent,
                            ),
                            const SizedBox(width: 48),
                            Expanded(
                              flex: 5,
                              child: Center(child: idCardWidget),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),

          // ── Scroll indicator ──────────────────────────────────────────
          Positioned(
            bottom: 28,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Text(
                    'scroll down',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.35),
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Icon(
                    Icons.keyboard_double_arrow_down_rounded,
                    color: primaryColor.withValues(alpha: 0.5),
                    size: 26,
                  )
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .slideY(begin: 0, end: 0.35, duration: 1100.ms, curve: Curves.easeInOut)
                      .fadeIn(duration: 600.ms, delay: 1400.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Pulsing availability badge ─────────────────────────────────────────────────

class _PulsingBadge extends StatefulWidget {
  final String text;
  final Color primaryColor;
  final Color secondaryColor;
  final bool isDark;

  const _PulsingBadge({
    required this.text,
    required this.primaryColor,
    required this.secondaryColor,
    required this.isDark,
  });

  @override
  State<_PulsingBadge> createState() => _PulsingBadgeState();
}

class _PulsingBadgeState extends State<_PulsingBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: widget.secondaryColor
                  .withValues(alpha: 0.4 + _pulse.value * 0.4),
              width: 1.2,
            ),
            color: widget.secondaryColor.withValues(alpha: 0.07 + _pulse.value * 0.05),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.secondaryColor
                      .withValues(alpha: 0.6 + _pulse.value * 0.4),
                  boxShadow: [
                    BoxShadow(
                      color: widget.secondaryColor.withValues(alpha: 0.5),
                      blurRadius: 6 + _pulse.value * 4,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                widget.text,
                style: TextStyle(
                  color: widget.secondaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Outline secondary button ─────────────────────────────────────────────────

class _OutlineButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color primaryColor;
  final VoidCallback onPressed;

  const _OutlineButton({
    required this.label,
    required this.icon,
    required this.primaryColor,
    required this.onPressed,
  });

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: widget.primaryColor.withValues(alpha: _isHovered ? 0.8 : 0.35),
              width: 1.5,
            ),
            color: widget.primaryColor.withValues(alpha: _isHovered ? 0.1 : 0.0),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.primaryColor.withValues(alpha: 0.2),
                      blurRadius: 16,
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon,
                  size: 18,
                  color: widget.primaryColor.withValues(alpha: _isHovered ? 1 : 0.7)),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.primaryColor.withValues(alpha: _isHovered ? 1 : 0.7),
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Glassmorphic Hero Quick Stats Row ────────────────────────────────────────

class _HeroStatsRow extends StatelessWidget {
  final bool isDark;
  final Color primaryColor;
  final Color secondaryColor;
  final bool isMobile;

  const _HeroStatsRow({
    required this.isDark,
    required this.primaryColor,
    required this.secondaryColor,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final stats = [
      {
        'value': '5+',
        'title': 'Projects Built',
        'icon': Icons.space_dashboard_rounded,
      },
      {
        'value': 'B.Tech IT',
        'title': 'Software Student',
        'icon': Icons.school_rounded,
      },
      {
        'value': 'Flutter & Web',
        'title': 'Cross-Platform',
        'icon': Icons.devices_rounded,
      },
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 14,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: stats.map((stat) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: primaryColor.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withValues(alpha: 0.05),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  stat['icon'] as IconData,
                  size: 18,
                  color: primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    stat['value'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    stat['title'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: (isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary)
                          .withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

