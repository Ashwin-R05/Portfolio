/// Interactive 3D Developer ID Card widget.
///
/// Features:
/// - Lanyard strap & metallic badge clip header
/// - Glassmorphic card body with cyber glow borders
/// - Profile photo loader with fallback avatar initials & online indicator
/// - Developer details: Name, Role, ID tag, Tech stack micro-badges, & Barcode
/// - 3D Perspective Matrix Tilt tracking on mouse movement
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../data/profile_data.dart';
import '../theme/app_colors.dart';

class DeveloperIdCard extends StatefulWidget {
  final bool isDark;
  const DeveloperIdCard({super.key, required this.isDark});

  @override
  State<DeveloperIdCard> createState() => _DeveloperIdCardState();
}

class _DeveloperIdCardState extends State<DeveloperIdCard> {
  // Mouse hover 3D tilt coordinates
  double _rotateX = 0.0;
  double _rotateY = 0.0;
  bool _isHovered = false;

  void _onHover(PointerEvent event, Size size) {
    if (size.width == 0 || size.height == 0) return;

    // Calculate normalized offset from center (-1.0 to 1.0)
    final dx = (event.localPosition.dx - (size.width / 2)) / (size.width / 2);
    final dy = (event.localPosition.dy - (size.height / 2)) / (size.height / 2);

    setState(() {
      _rotateX = -dy * 0.25; // Tilt up/down (Max ~14 deg)
      _rotateY = dx * 0.25;  // Tilt left/right (Max ~14 deg)
      _isHovered = true;
    });
  }

  void _onExit(PointerEvent event) {
    setState(() {
      _rotateX = 0.0;
      _rotateY = 0.0;
      _isHovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor =
        widget.isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final secondaryColor =
        widget.isDark ? AppColors.darkSecondary : AppColors.lightSecondary;
    final cardBg = widget.isDark
        ? const Color(0xFF0F172A).withValues(alpha: 0.85)
        : Colors.white.withValues(alpha: 0.90);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Lanyard Strap ─────────────────────────────────────────────
        Container(
          width: 28,
          height: 48,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                primaryColor.withValues(alpha: 0.8),
                secondaryColor,
              ],
            ),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(4)),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withValues(alpha: 0.3),
                blurRadius: 8,
              ),
            ],
          ),
        ),

        // ── Metallic Clip Assembly ───────────────────────────────────
        Container(
          width: 52,
          height: 18,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF94A3B8),
                Color(0xFFCBD5E1),
                Color(0xFF64748B),
              ],
            ),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 24,
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),

        const SizedBox(height: 6),

        // ── 3D Interactive Card Body ─────────────────────────────────
        LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = math.min(340.0, MediaQuery.of(context).size.width - 48);

            return MouseRegion(
              onHover: (e) => _onHover(e, Size(cardWidth, 480)),
              onExit: _onExit,
              cursor: SystemMouseCursors.click,
              child: AnimatedContainer(
                duration: _isHovered
                    ? const Duration(milliseconds: 80)
                    : const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // Perspective
                  ..rotateX(_rotateX)
                  ..rotateY(_rotateY),
                transformAlignment: Alignment.center,
                child: AnimatedScale(
                  scale: _isHovered ? 1.03 : 1.0,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  child: Container(
                    width: cardWidth,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: _isHovered
                            ? primaryColor
                            : primaryColor.withValues(alpha: 0.35),
                        width: 1.8,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (_isHovered ? primaryColor : Colors.black)
                              .withValues(alpha: _isHovered ? 0.35 : 0.25),
                          blurRadius: _isHovered ? 32 : 20,
                          spreadRadius: _isHovered ? 2 : 0,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Card Header Barcode / Title
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.badge_rounded,
                                  size: 16,
                                  color: primaryColor,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'DEV PASS',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.5,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: secondaryColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: secondaryColor.withValues(alpha: 0.4),
                                  width: 0.8,
                                ),
                              ),
                              child: Text(
                                ProfileData.idNumber,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.w700,
                                  color: secondaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Profile Photo Container
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // Ambient Glow Ring
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 116,
                              height: 116,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    primaryColor,
                                    secondaryColor,
                                    AppColors.darkAccent,
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColor.withValues(alpha: 0.4),
                                    blurRadius: _isHovered ? 20 : 12,
                                  ),
                                ],
                              ),
                            ),

                            // Photo / Avatar Frame
                            Container(
                              width: 108,
                              height: 108,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: widget.isDark
                                    ? const Color(0xFF1E293B)
                                    : const Color(0xFFF1F5F9),
                                border: Border.all(
                                  color: cardBg,
                                  width: 3,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  ProfileData.profilePhotoPath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    // Fallback Avatar if image asset is missing
                                    return Container(
                                      color: primaryColor.withValues(alpha: 0.15),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.person_rounded,
                                              size: 48,
                                              color: primaryColor,
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              'AR',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w900,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                            // Active Online Indicator Badge
                            Positioned(
                              bottom: 4,
                              right: 4,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: cardBg,
                                  shape: BoxShape.circle,
                                ),
                                child: Container(
                                  width: 14,
                                  height: 14,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF10B981), // Vivid Emerald Green
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFF10B981),
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Name
                        Text(
                          ProfileData.name,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                            color: widget.isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary,
                          ),
                        ),

                        const SizedBox(height: 4),

                        // Role Tag
                        Text(
                          ProfileData.role,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 4),

                        // Subtitle
                        Text(
                          ProfileData.location,
                          style: TextStyle(
                            fontSize: 11,
                            color: (widget.isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary)
                                .withValues(alpha: 0.7),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Tech Stack Micro Badges
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          alignment: WrapAlignment.center,
                          children: const [
                            _TechBadge(label: 'Flutter'),
                            _TechBadge(label: 'React'),
                            _TechBadge(label: 'Node.js'),
                            _TechBadge(label: 'AWS'),
                          ],
                        ),

                        const SizedBox(height: 16),
                        Divider(
                          color: (widget.isDark ? Colors.white : Colors.black)
                              .withValues(alpha: 0.1),
                          height: 1,
                        ),
                        const SizedBox(height: 12),

                        // Bottom Card Footer (Barcode Graphic + Verification)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Barcode simulation
                            Row(
                              children: List.generate(
                                18,
                                (index) => Container(
                                  margin: const EdgeInsets.only(right: 2.5),
                                  width: (index % 3 == 0) ? 3.0 : 1.5,
                                  height: 20,
                                  color: (widget.isDark
                                          ? Colors.white
                                          : Colors.black)
                                      .withValues(alpha: 0.4 + (index % 4) * 0.15),
                                ),
                              ),
                            ),

                            // Verification Stamp
                            Row(
                              children: [
                                Icon(
                                  Icons.verified_user_rounded,
                                  size: 14,
                                  color: secondaryColor,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'VERIFIED',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.0,
                                    color: secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _TechBadge extends StatelessWidget {
  final String label;
  const _TechBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: (isDark ? AppColors.darkPrimary : AppColors.lightPrimary)
            .withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: (isDark ? AppColors.darkPrimary : AppColors.lightPrimary)
              .withValues(alpha: 0.25),
          width: 0.8,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
        ),
      ),
    );
  }
}
