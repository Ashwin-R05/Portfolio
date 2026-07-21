/// Interactive particle canvas background using CustomPainter.
///
/// Renders a constellation of floating particles in three hues (indigo, cyan,
/// amber) connected by faint lines, with comet-trail history and a radial
/// aurora glow that pulses from the canvas center. Particles react to cursor
/// proximity — they glow brighter and are gently repelled.
///
/// Performance:
/// - Particle count scales with screen area (fewer on mobile)
/// - RepaintBoundary prevents repainting the rest of the tree
/// - Lines only drawn within threshold distance
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
  static const int maxTrail = 8;

  _Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
    required this.opacity,
    required this.colorIndex,
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
    this.particleCount = 90,
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

  void _initParticles(Size size) {
    if (size == _canvasSize && _particles.isNotEmpty) return;
    _canvasSize = size;
    _particles.clear();

    final area = size.width * size.height;
    final count = (widget.particleCount * (area / (1920 * 1080)))
        .clamp(25, widget.particleCount.toDouble())
        .toInt();

    for (int i = 0; i < count; i++) {
      _particles.add(_Particle(
        x: _random.nextDouble() * size.width,
        y: _random.nextDouble() * size.height,
        vx: (_random.nextDouble() - 0.5) * 0.4,
        vy: (_random.nextDouble() - 0.5) * 0.4,
        radius: _random.nextDouble() * 2.2 + 0.8,
        opacity: _random.nextDouble() * 0.45 + 0.2,
        colorIndex: _random.nextInt(3),
      ));
    }
  }

  void _updateParticles() {
    _auroraPhase += 0.012;

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
        final dist = sqrt(dx * dx + dy * dy);
        if (dist < 160 && dist > 0) {
          final force = (160 - dist) / 160 * 0.28;
          p.vx += dx / dist * force;
          p.vy += dy / dist * force;
          p.opacity = (p.opacity + 0.025).clamp(0.0, 1.0);
        } else {
          p.opacity = (p.opacity - 0.004).clamp(0.18, 0.75);
        }
        p.vx *= 0.988;
        p.vy *= 0.988;
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
    return RepaintBoundary(
      child: MouseRegion(
        onHover: widget.interactive
            ? (e) => setState(() => _mousePosition = e.localPosition)
            : null,
        onExit: widget.interactive ? (_) => setState(() => _mousePosition = null) : null,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = Size(constraints.maxWidth, constraints.maxHeight);
            _initParticles(size);
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

  static const double _connDist = 130;

  // Three particle hues: indigo, cyan, amber
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
  });

  @override
  void paint(Canvas canvas, Size size) {
    final colors = isDark ? _darkColors : _lightColors;
    final center = Offset(size.width / 2, size.height / 2);

    // ── 1. Pulsing aurora vortex at canvas center ──────────────────────
    final auroraRadius = 220 + sin(auroraPhase) * 30;
    for (int i = 0; i < 3; i++) {
      final hue = colors[i];
      final alpha = (0.04 + sin(auroraPhase + i * 2.1) * 0.015).clamp(0.0, 1.0);
      final glowPaint = Paint()
        ..shader = RadialGradient(
          colors: [hue.withValues(alpha: alpha), Colors.transparent],
        ).createShader(
          Rect.fromCircle(center: center, radius: auroraRadius + i * 40),
        );
      canvas.drawCircle(center, auroraRadius + i * 40, glowPaint);
    }

    // ── 2. Connecting lines ────────────────────────────────────────────
    final linePaint = Paint()..style = PaintingStyle.stroke..strokeWidth = 0.6;
    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final pi = particles[i];
        final pj = particles[j];
        final dx = pi.x - pj.x;
        final dy = pi.y - pj.y;
        final dist = sqrt(dx * dx + dy * dy);
        if (dist < _connDist) {
          final t = 1 - dist / _connDist;
          // Blend the two particle hues
          final c1 = colors[pi.colorIndex];
          final c2 = colors[pj.colorIndex];
          linePaint.color = Color.lerp(c1, c2, 0.5)!.withValues(alpha: t * 0.3);
          canvas.drawLine(Offset(pi.x, pi.y), Offset(pj.x, pj.y), linePaint);
        }
      }
    }

    // ── 3. Cursor glow ─────────────────────────────────────────────────
    if (mousePosition != null) {
      final glowPaint = Paint()
        ..shader = RadialGradient(colors: [
          AppColors.cyanGlow,
          Colors.transparent,
        ]).createShader(Rect.fromCircle(center: mousePosition!, radius: 160));
      canvas.drawCircle(mousePosition!, 160, glowPaint);
    }

    // ── 4. Comet trails + particles ────────────────────────────────────
    for (final p in particles) {
      final baseColor = colors[p.colorIndex];

      // Comet trail — faded history dots
      for (int t = 0; t < p.trail.length; t++) {
        final trailAlpha = (t / p.trail.length) * p.opacity * 0.35;
        final trailRadius = p.radius * (t / p.trail.length) * 0.8;
        final trailPaint = Paint()
          ..color = baseColor.withValues(alpha: trailAlpha);
        canvas.drawCircle(p.trail[t], trailRadius, trailPaint);
      }

      // Core particle
      final paint = Paint()..color = baseColor.withValues(alpha: p.opacity);
      canvas.drawCircle(Offset(p.x, p.y), p.radius, paint);

      // Outer glow for bright particles
      if (p.opacity > 0.45) {
        final glowPaint = Paint()
          ..color = baseColor.withValues(alpha: p.opacity * 0.18)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
        canvas.drawCircle(Offset(p.x, p.y), p.radius * 3.5, glowPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter old) => true;
}
