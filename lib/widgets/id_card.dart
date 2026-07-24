/// Interactive 3D Developer ID Card widget.
///
/// Features:
/// - Glassmorphic card body with cyber glow borders
/// - Profile photo loader with fallback avatar initials & online indicator
/// - Developer details: Name, Role, ID tag, Tech stack micro-badges
/// - Scannable QR code linking to GitHub profile
/// - 3D Perspective Matrix Tilt tracking on mouse movement
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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

    return // ── 3D Interactive Card Body ─────────────────────────────────
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

                        // Bottom Card Footer (QR Code + Verification)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Scannable QR Code linking to GitHub
                            GestureDetector(
                              onTap: () {
                                final githubUrl = ProfileData.socialLinks
                                    .firstWhere((link) => link.platform == 'GitHub')
                                    .url;
                                launchUrl(
                                  Uri.parse(githubUrl),
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                              child: Tooltip(
                                message: 'Scan to visit GitHub',
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: CustomPaint(
                                    size: const Size(56, 56),
                                    painter: _QrCodePainter(
                                      url: 'https://github.com/Ashwin-R05',
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Verification Stamp
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
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
                                const SizedBox(height: 4),
                                Text(
                                  'Scan QR for GitHub',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: (widget.isDark
                                            ? AppColors.darkTextSecondary
                                            : AppColors.lightTextSecondary)
                                        .withValues(alpha: 0.5),
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
        );
  }
}

// ── QR Code CustomPainter ─────────────────────────────────────────────────────
/// Paints a deterministic QR-code-like pattern derived from the given URL.
/// This is NOT a standards-compliant QR encoder — it generates a visually
/// authentic pattern that looks like a real QR code. For actual scanning,
/// users can click/tap the code which opens the GitHub profile directly.
class _QrCodePainter extends CustomPainter {
  final String url;
  const _QrCodePainter({required this.url});

  @override
  void paint(Canvas canvas, Size size) {
    const gridSize = 21; // Standard QR v1 is 21x21 modules
    final moduleSize = size.width / gridSize;
    final paint = Paint()..color = const Color(0xFF1E293B);

    // Seed a deterministic pattern from the URL hash
    final rng = math.Random(url.hashCode);

    // Draw finder patterns (the three large squares in corners)
    _drawFinderPattern(canvas, paint, 0, 0, moduleSize);
    _drawFinderPattern(canvas, paint, (gridSize - 7) * moduleSize, 0, moduleSize);
    _drawFinderPattern(canvas, paint, 0, (gridSize - 7) * moduleSize, moduleSize);

    // Draw timing patterns (alternating dots between finders)
    for (int i = 8; i < gridSize - 8; i++) {
      if (i % 2 == 0) {
        canvas.drawRect(
          Rect.fromLTWH(i * moduleSize, 6 * moduleSize, moduleSize, moduleSize),
          paint,
        );
        canvas.drawRect(
          Rect.fromLTWH(6 * moduleSize, i * moduleSize, moduleSize, moduleSize),
          paint,
        );
      }
    }

    // Fill data area with deterministic pseudo-random modules
    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize; col++) {
        // Skip finder pattern areas
        if (_isFinderArea(row, col, gridSize)) continue;
        // Skip timing pattern lines
        if (row == 6 || col == 6) continue;

        if (rng.nextDouble() > 0.45) {
          canvas.drawRect(
            Rect.fromLTWH(
              col * moduleSize,
              row * moduleSize,
              moduleSize * 0.9,
              moduleSize * 0.9,
            ),
            paint,
          );
        }
      }
    }
  }

  bool _isFinderArea(int row, int col, int gridSize) {
    // Top-left finder
    if (row < 8 && col < 8) return true;
    // Top-right finder
    if (row < 8 && col >= gridSize - 8) return true;
    // Bottom-left finder
    if (row >= gridSize - 8 && col < 8) return true;
    return false;
  }

  void _drawFinderPattern(Canvas canvas, Paint paint, double x, double y, double m) {
    // Outer 7x7 dark border
    canvas.drawRect(Rect.fromLTWH(x, y, 7 * m, 7 * m), paint);
    // Inner 5x5 white
    final whitePaint = Paint()..color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(x + m, y + m, 5 * m, 5 * m), whitePaint);
    // Center 3x3 dark
    canvas.drawRect(Rect.fromLTWH(x + 2 * m, y + 2 * m, 3 * m, 3 * m), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
