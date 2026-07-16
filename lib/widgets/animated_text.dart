/// Typewriter text animation widget.
///
/// Types out text character-by-character with a blinking cursor.
/// Supports cycling through multiple phrases with a configurable
/// pause between phrases.
import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedTypewriter extends StatefulWidget {
  /// List of phrases to cycle through.
  final List<String> phrases;

  /// Style applied to the typed text.
  final TextStyle? style;

  /// Style applied to the blinking cursor.
  final TextStyle? cursorStyle;

  /// Duration between each character appearing.
  final Duration typingSpeed;

  /// Duration the completed phrase stays visible before erasing.
  final Duration pauseDuration;

  /// Duration between each character being erased.
  final Duration erasingSpeed;

  const AnimatedTypewriter({
    super.key,
    required this.phrases,
    this.style,
    this.cursorStyle,
    this.typingSpeed = const Duration(milliseconds: 60),
    this.pauseDuration = const Duration(seconds: 2),
    this.erasingSpeed = const Duration(milliseconds: 30),
  });

  @override
  State<AnimatedTypewriter> createState() => _AnimatedTypewriterState();
}

class _AnimatedTypewriterState extends State<AnimatedTypewriter> {
  String _displayText = '';
  int _phraseIndex = 0;
  bool _isTyping = true;
  bool _cursorVisible = true;
  Timer? _typingTimer;
  Timer? _cursorTimer;

  @override
  void initState() {
    super.initState();
    _startCursorBlink();
    _startTyping();
  }

  /// Blink the cursor at 530ms intervals (standard terminal feel).
  void _startCursorBlink() {
    _cursorTimer = Timer.periodic(
      const Duration(milliseconds: 530),
      (_) {
        if (mounted) setState(() => _cursorVisible = !_cursorVisible);
      },
    );
  }

  /// Begin the typing → pause → erasing → next phrase cycle.
  void _startTyping() {
    final currentPhrase = widget.phrases[_phraseIndex];
    int charIndex = 0;

    _typingTimer = Timer.periodic(widget.typingSpeed, (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_isTyping) {
        // Typing phase
        if (charIndex < currentPhrase.length) {
          setState(() {
            _displayText = currentPhrase.substring(0, charIndex + 1);
          });
          charIndex++;
        } else {
          // Finished typing — pause, then erase
          timer.cancel();
          Future.delayed(widget.pauseDuration, () {
            if (!mounted) return;
            _isTyping = false;
            charIndex = currentPhrase.length;
            _typingTimer = Timer.periodic(widget.erasingSpeed, (eraseTimer) {
              if (!mounted) {
                eraseTimer.cancel();
                return;
              }
              if (charIndex > 0) {
                charIndex--;
                setState(() {
                  _displayText = currentPhrase.substring(0, charIndex);
                });
              } else {
                eraseTimer.cancel();
                _isTyping = true;
                _phraseIndex =
                    (_phraseIndex + 1) % widget.phrases.length;
                // Small pause before typing next phrase.
                Future.delayed(const Duration(milliseconds: 300), () {
                  if (mounted) _startTyping();
                });
              }
            });
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _cursorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = widget.style ??
        theme.textTheme.headlineSmall?.copyWith(
          color: theme.colorScheme.secondary,
        );
    final cursorStyle = widget.cursorStyle ??
        textStyle?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w300,
        );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            _displayText,
            style: textStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // Blinking cursor
        AnimatedOpacity(
          opacity: _cursorVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 100),
          child: Text('|', style: cursorStyle),
        ),
      ],
    );
  }
}
