/// Hero / Landing section.
///
/// Full-viewport-height introduction with:
/// - Animated particle canvas background
/// - Large name in Space Grotesk with subtle glow
/// - Typewriter tagline cycling through phrases
/// - Glowing CTA button to scroll down
/// - Staggered entrance animation (name → tagline → CTA)
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../animations/particle_canvas.dart';
import '../data/profile_data.dart';
import '../theme/app_colors.dart';
import '../widgets/animated_text.dart';
import '../widgets/glow_button.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onExplorePressed;

  const HeroSection({super.key, required this.onExplorePressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final primaryColor =
        isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          // ── Particle background ─────────────────────────────────────
          const Positioned.fill(
            child: ParticleCanvas(),
          ),

          // ── Gradient overlay for text readability ───────────────────
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.2,
                  colors: [
                    Colors.transparent,
                    (isDark ? AppColors.darkBackground : AppColors.lightBackground)
                        .withValues(alpha: 0.4),
                  ],
                ),
              ),
            ),
          ),

          // ── Content ─────────────────────────────────────────────────
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 48,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: isMobile
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  // Greeting line
                  Text(
                    'Hello, I\'m',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 200.ms)
                      .slideY(begin: 0.3, end: 0, duration: 600.ms),

                  const SizedBox(height: 8),

                  // Name — large, glowing
                  Text(
                    ProfileData.name,
                    style: (isMobile
                            ? theme.textTheme.displaySmall
                            : theme.textTheme.displayLarge)
                        ?.copyWith(
                      color: theme.colorScheme.onSurface,
                      shadows: [
                        Shadow(
                          color: primaryColor.withValues(alpha: 0.3),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    textAlign:
                        isMobile ? TextAlign.center : TextAlign.start,
                  )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 400.ms)
                      .slideY(begin: 0.3, end: 0, duration: 600.ms),

                  const SizedBox(height: 8),

                  // Role subtitle
                  Text(
                    ProfileData.role,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign:
                        isMobile ? TextAlign.center : TextAlign.start,
                  )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 600.ms)
                      .slideY(begin: 0.3, end: 0, duration: 600.ms),

                  const SizedBox(height: 24),

                  // Typewriter tagline
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

                  const SizedBox(height: 48),

                  // CTA button
                  GlowButton(
                    label: 'Explore My Work',
                    icon: Icons.arrow_downward_rounded,
                    onPressed: onExplorePressed,
                  )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 1000.ms)
                      .slideY(begin: 0.5, end: 0, duration: 600.ms),
                ],
              ),
            ),
          ),

          // ── Scroll indicator ────────────────────────────────────────
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
              child: Icon(
                Icons.keyboard_double_arrow_down_rounded,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                size: 28,
              )
                  .animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                  .slideY(
                    begin: 0,
                    end: 0.3,
                    duration: 1200.ms,
                    curve: Curves.easeInOut,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
