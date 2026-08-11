/// Interactive particle canvas background using CustomPainter.
///
/// Optimized for ultra-smooth performance across desktop and mobile devices:
/// - Screen-aware particle counts (fewer on mobile)
/// - Squared distance checks to avoid expensive sqrt() calls in 60 FPS loop
/// - Lightweight comet trails and optimized paint calls
/// - RepaintBoundary prevents unneeded widget tree repaints
import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// ── Particle ──────────────────────────────────────────────────────────────────

class _Particle {
  double x;
  double y;
  double vx;
  double vy;
  double radius;
  double opacity;
  /// 0 = indigo, 1 = cyan, 2 = amber
  int colorIndex;
  /// Recent positions for comet trail
  final List<Offset> trail = [];
  final int maxTrail;

  _Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
    required this.opacity,
    required this.colorIndex,
    this.maxTrail = 4,
  });

  void recordTrail() {
    trail.add(Offset(x, y));
    if (trail.length > maxTrail) trail.removeAt(0);
  }
}

// ── Widget ────────────────────────────────────────────────────────────────────

class ParticleCanvas extends StatefulWidget {
  final int particleCount;
  final bool interactive;

  const ParticleCanvas({
    super.key,
    this.particleCount = 45,
    this.interactive = true,
  });

  @override
  State<ParticleCanvas> createState() => _ParticleCanvasState();
}

class _ParticleCanvasState extends State<ParticleCanvas>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final Random _random = Random();
  Offset? _mousePosition;
  Size _canvasSize = Size.zero;
  double _auroraPhase = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  void _initParticles(Size size, bool isMobile) {
    if (size == _canvasSize && _particles.isNotEmpty) return;
    _canvasSize = size;
    _particles.clear();

    final maxCount = isMobile ? 18 : widget.particleCount;
    final maxTrail = isMobile ? 2 : 4;

    for (int i = 0; i < maxCount; i++) {
      _particles.add(_Particle(
        x: _random.nextDouble() * size.width,
        y: _random.nextDouble() * size.height,
        vx: (_random.nextDouble() - 0.5) * 0.35,
        vy: (_random.nextDouble() - 0.5) * 0.35,
        radius: _random.nextDouble() * 2.0 + 0.8,
        opacity: _random.nextDouble() * 0.4 + 0.2,
        colorIndex: _random.nextInt(3),
        maxTrail: maxTrail,
      ));
    }
  }

  void _updateParticles() {
    _auroraPhase += 0.01;

    for (final p in _particles) {
      p.recordTrail();
      p.x += p.vx;
      p.y += p.vy;

      // Wrap edges
      if (p.x < 0) p.x = _canvasSize.width;
      if (p.x > _canvasSize.width) p.x = 0;
      if (p.y < 0) p.y = _canvasSize.height;
      if (p.y > _canvasSize.height) p.y = 0;

      // Mouse interaction
      if (_mousePosition != null && widget.interactive) {
        final dx = p.x - _mousePosition!.dx;
        final dy = p.y - _mousePosition!.dy;
        final distSq = dx * dx + dy * dy;
        // 160 * 160 = 25600
        if (distSq < 25600 && distSq > 0) {
          final dist = sqrt(distSq);
          final force = (160 - dist) / 160 * 0.25;
          p.vx += dx / dist * force;
          p.vy += dy / dist * force;
          p.opacity = (p.opacity + 0.02).clamp(0.0, 0.9);
        } else {
          p.opacity = (p.opacity - 0.003).clamp(0.18, 0.7);
        }
        p.vx *= 0.985;
        p.vy *= 0.985;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 768;

    return RepaintBoundary(
      child: MouseRegion(
        onHover: widget.interactive
            ? (e) => setState(() => _mousePosition = e.localPosition)
            : null,
        onExit: widget.interactive ? (_) => setState(() => _mousePosition = null) : null,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = Size(constraints.maxWidth, constraints.maxHeight);
            _initParticles(size, isMobile);
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                _updateParticles();
                return CustomPaint(
                  size: size,
                  painter: _ParticlePainter(
                    particles: _particles,
                    mousePosition: _mousePosition,
                    isDark: isDark,
                    auroraPhase: _auroraPhase,
                    isMobile: isMobile,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// ── Painter ───────────────────────────────────────────────────────────────────

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final Offset? mousePosition;
  final bool isDark;
  final double auroraPhase;
  final bool isMobile;

  // Squared distance threshold (120 * 120 = 14400)
  static const double _connDistSq = 14400;
  static const double _connDist = 120;

  static const List<Color> _lightColors = [
    Color(0xFF6366F1),
    Color(0xFF22D3EE),
    Color(0xFFF59E0B),
  ];
  static const List<Color> _darkColors = [
    Color(0xFF818CF8),
    Color(0xFF67E8F9),
    Color(0xFFFBBF24),
  ];

  _ParticlePainter({
    required this.particles,
    this.mousePosition,
    required this.isDark,
    required this.auroraPhase,
    required this.isMobile,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final colors = isDark ? _darkColors : _lightColors;
    final center = Offset(size.width / 2, size.height / 2);

    // ── 1. Pulsing aurora vortex at canvas center ──────────────────────
    if (!isMobile) {
      final auroraRadius = 200 + sin(auroraPhase) * 25;
      for (int i = 0; i < 2; i++) {
        final hue = colors[i];
        final alpha = (0.035 + sin(auroraPhase + i * 2.1) * 0.012).clamp(0.0, 1.0);
        final glowPaint = Paint()
          ..shader = RadialGradient(
            colors: [hue.withValues(alpha: alpha), Colors.transparent],
          ).createShader(
            Rect.fromCircle(center: center, radius: auroraRadius + i * 40),
          );
        canvas.drawCircle(center, auroraRadius + i * 40, glowPaint);
      }
    }

    // ── 2. Connecting lines ────────────────────────────────────────────
    final linePaint = Paint()..style = PaintingStyle.stroke..strokeWidth = 0.5;
    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final pi = particles[i];
        final pj = particles[j];
        final dx = pi.x - pj.x;
        final dy = pi.y - pj.y;
        final distSq = dx * dx + dy * dy;
        if (distSq < _connDistSq) {
          final dist = sqrt(distSq);
          final t = 1 - dist / _connDist;
          final c1 = colors[pi.colorIndex];
          final c2 = colors[pj.colorIndex];
          linePaint.color = Color.lerp(c1, c2, 0.5)!.withValues(alpha: t * 0.25);
          canvas.drawLine(Offset(pi.x, pi.y), Offset(pj.x, pj.y), linePaint);
        }
      }
    }

    // ── 3. Cursor glow ─────────────────────────────────────────────────
    if (mousePosition != null && !isMobile) {
      final glowPaint = Paint()
        ..shader = RadialGradient(colors: [
          AppColors.cyanGlow,
          Colors.transparent,
        ]).createShader(Rect.fromCircle(center: mousePosition!, radius: 140));
      canvas.drawCircle(mousePosition!, 140, glowPaint);
    }

    // ── 4. Comet trails + particles ────────────────────────────────────
    for (final p in particles) {
      final baseColor = colors[p.colorIndex];

      // Comet trail
      for (int t = 0; t < p.trail.length; t++) {
        final trailAlpha = (t / p.trail.length) * p.opacity * 0.3;
        final trailRadius = p.radius * (t / p.trail.length) * 0.75;
        final trailPaint = Paint()
          ..color = baseColor.withValues(alpha: trailAlpha);
        canvas.drawCircle(p.trail[t], trailRadius, trailPaint);
      }

      // Core particle
      final paint = Paint()..color = baseColor.withValues(alpha: p.opacity);
      canvas.drawCircle(Offset(p.x, p.y), p.radius, paint);

      // Lightweight outer glow ring for bright particles (avoiding expensive MaskFilter.blur)
      if (p.opacity > 0.45 && !isMobile) {
        final glowPaint = Paint()
          ..color = baseColor.withValues(alpha: p.opacity * 0.12);
        canvas.drawCircle(Offset(p.x, p.y), p.radius * 2.5, glowPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter old) => true;
}
