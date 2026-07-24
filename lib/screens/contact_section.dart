/// Contact section with glassmorphic form and interactive info cards.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/profile_data.dart';
import '../models/social_link.dart';
import '../theme/app_colors.dart';
import '../widgets/section_wrapper.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isCopied = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  static final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  void _showSnackBar(String message, {bool isError = true}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(context).colorScheme.error
            : AppColors.darkSecondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _copyEmail() {
    Clipboard.setData(const ClipboardData(text: ProfileData.email));
    setState(() => _isCopied = true);
    _showSnackBar('Email copied to clipboard!', isError: false);
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _isCopied = false);
    });
  }

  Future<void> _sendEmail() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      _showSnackBar('Please fill in all fields.');
      return;
    }

    if (!_emailRegExp.hasMatch(email)) {
      _showSnackBar('Please enter a valid email address.');
      return;
    }

    final uri = Uri(
      scheme: 'mailto',
      path: ProfileData.email,
      queryParameters: {
        'subject': 'Portfolio Contact from $name',
        'body': 'From: $name ($email)\n\n$message',
      },
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;
    final primaryColor =
        isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final secondaryColor =
        isDark ? AppColors.darkSecondary : AppColors.lightSecondary;

    return SectionWrapper(
      sectionId: 'contact',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header Section ───────────────────────────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Tag
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: primaryColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.mail_rounded, size: 14, color: primaryColor),
                    const SizedBox(width: 8),
                    Text(
                      'GET IN TOUCH',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.1, end: 0),

              const SizedBox(height: 16),

              // Headline with gradient shader
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [primaryColor, secondaryColor, AppColors.darkAccent],
                ).createShader(bounds),
                child: Text(
                  'Let\'s Build Something Great Together',
                  style: (isMobile
                          ? theme.textTheme.headlineMedium
                          : theme.textTheme.displaySmall)
                      ?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
              ).animate().fadeIn(duration: 600.ms, delay: 100.ms),

              const SizedBox(height: 12),

              Text(
                "Have a project in mind, an opportunity, or just want to connect? Send me a message below or reach out directly.",
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: (isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary)
                      .withValues(alpha: 0.8),
                  height: 1.5,
                ),
              ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
            ],
          ),

          const SizedBox(height: 44),

          // ── Main Contact Grid Layout ──────────────────────────────────
          isMobile
              ? Column(
                  children: [
                    _ContactFormCard(
                      nameController: _nameController,
                      emailController: _emailController,
                      messageController: _messageController,
                      onSend: _sendEmail,
                      primaryColor: primaryColor,
                      secondaryColor: secondaryColor,
                      isDark: isDark,
                      theme: theme,
                    ),
                    const SizedBox(height: 36),
                    _ContactInfoColumn(
                      primaryColor: primaryColor,
                      secondaryColor: secondaryColor,
                      isDark: isDark,
                      isCopied: _isCopied,
                      onCopyEmail: _copyEmail,
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left: Glassmorphic Contact Form
                    Expanded(
                      flex: 6,
                      child: _ContactFormCard(
                        nameController: _nameController,
                        emailController: _emailController,
                        messageController: _messageController,
                        onSend: _sendEmail,
                        primaryColor: primaryColor,
                        secondaryColor: secondaryColor,
                        isDark: isDark,
                        theme: theme,
                      ),
                    ),
                    const SizedBox(width: 44),

                    // Right: Glassmorphic Contact Cards & Social Hub
                    Expanded(
                      flex: 5,
                      child: _ContactInfoColumn(
                        primaryColor: primaryColor,
                        secondaryColor: secondaryColor,
                        isDark: isDark,
                        isCopied: _isCopied,
                        onCopyEmail: _copyEmail,
                      ),
                    ),
                  ],
                ),

          // ── Footer ───────────────────────────────────────────────────
          const SizedBox(height: 72),
          _Footer(theme: theme, primaryColor: primaryColor, isDark: isDark),
        ],
      ),
    );
  }
}

// ── Glassmorphic Contact Form Card ──────────────────────────────────────────

class _ContactFormCard extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;
  final VoidCallback onSend;
  final Color primaryColor;
  final Color secondaryColor;
  final bool isDark;
  final ThemeData theme;

  const _ContactFormCard({
    required this.nameController,
    required this.emailController,
    required this.messageController,
    required this.onSend,
    required this.primaryColor,
    required this.secondaryColor,
    required this.isDark,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark
        ? const Color(0xFF0F172A).withValues(alpha: 0.8)
        : Colors.white.withValues(alpha: 0.9);

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.25),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Form Title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.send_rounded, color: primaryColor, size: 20),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Send a Message',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'I\'ll get back to you as soon as possible',
                    style: TextStyle(
                      fontSize: 12,
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

          const SizedBox(height: 28),

          // Name Input
          _StyledTextField(
            controller: nameController,
            label: 'Your Name',
            hint: 'Ashwin R',
            icon: Icons.person_outline_rounded,
            primaryColor: primaryColor,
            isDark: isDark,
          ),

          const SizedBox(height: 20),

          // Email Input
          _StyledTextField(
            controller: emailController,
            label: 'Your Email',
            hint: 'ashwin@example.com',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            primaryColor: primaryColor,
            isDark: isDark,
          ),

          const SizedBox(height: 20),

          // Message Input
          _StyledTextField(
            controller: messageController,
            label: 'Your Message',
            hint: 'Tell me about your project or idea...',
            icon: Icons.chat_bubble_outline_rounded,
            maxLines: 5,
            primaryColor: primaryColor,
            isDark: isDark,
          ),

          const SizedBox(height: 28),

          // Submit Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: onSend,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                elevation: 4,
                shadowColor: primaryColor.withValues(alpha: 0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.send_rounded, size: 18),
              label: const Text(
                'Send Message',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 300.ms).slideY(begin: 0.1, end: 0);
  }
}

// ── Custom Styled Text Field ──────────────────────────────────────────────────

class _StyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;
  final int maxLines;
  final Color primaryColor;
  final bool isDark;

  const _StyledTextField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    required this.primaryColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final fieldBg = isDark
        ? const Color(0xFF1E293B).withValues(alpha: 0.6)
        : const Color(0xFFF1F5F9);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: TextStyle(
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: (isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary)
                  .withValues(alpha: 0.4),
              fontSize: 14,
            ),
            prefixIcon: Icon(
              icon,
              size: 20,
              color: primaryColor.withValues(alpha: 0.8),
            ),
            filled: true,
            fillColor: fieldBg,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: (isDark ? Colors.white : Colors.black)
                    .withValues(alpha: 0.1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: primaryColor, width: 1.8),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Contact Info & Social Column ─────────────────────────────────────────────

class _ContactInfoColumn extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;
  final bool isDark;
  final bool isCopied;
  final VoidCallback onCopyEmail;

  const _ContactInfoColumn({
    required this.primaryColor,
    required this.secondaryColor,
    required this.isDark,
    required this.isCopied,
    required this.onCopyEmail,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark
        ? const Color(0xFF0F172A).withValues(alpha: 0.8)
        : Colors.white.withValues(alpha: 0.9);

    return Column(
      children: [
        // Email Glass Card
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: secondaryColor.withValues(alpha: 0.25),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: secondaryColor.withValues(alpha: 0.06),
                blurRadius: 16,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: secondaryColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.alternate_email_rounded,
                    color: secondaryColor, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Direct Email',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    SelectableText(
                      ProfileData.email,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '⚡ Active & responds within 24h',
                      style: TextStyle(
                        fontSize: 11,
                        color: const Color(0xFF10B981),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onCopyEmail,
                tooltip: 'Copy Email',
                icon: Icon(
                  isCopied ? Icons.check_circle_rounded : Icons.copy_rounded,
                  color: isCopied ? const Color(0xFF10B981) : secondaryColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: 0.1, end: 0),

        const SizedBox(height: 20),

        // Location Glass Card
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: primaryColor.withValues(alpha: 0.2),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.location_on_rounded,
                    color: primaryColor, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      ProfileData.location,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '🌐 Available for Remote & On-site',
                      style: TextStyle(
                        fontSize: 11,
                        color: (isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary)
                            .withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 500.ms).slideY(begin: 0.1, end: 0),

        const SizedBox(height: 20),

        // Social Link Tiles Hub
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.1),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Connect Across Platforms',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
                ),
              ),
              const SizedBox(height: 14),
              Column(
                children: ProfileData.socialLinks.map((link) {
                  return _SocialHubTile(link: link, isDark: isDark);
                }).toList(),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideY(begin: 0.1, end: 0),
      ],
    );
  }
}

// ── Interactive Social Hub Tile ──────────────────────────────────────────────

class _SocialHubTile extends StatefulWidget {
  final SocialLink link;
  final bool isDark;

  const _SocialHubTile({required this.link, required this.isDark});

  @override
  State<_SocialHubTile> createState() => _SocialHubTileState();
}

class _SocialHubTileState extends State<_SocialHubTile> {
  bool _isHovered = false;

  Future<void> _launch() async {
    final uri = Uri.tryParse(widget.link.url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final brandColor = widget.link.brandColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _launch,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered
                ? brandColor.withValues(alpha: 0.12)
                : (widget.isDark ? Colors.white : Colors.black)
                    .withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? brandColor.withValues(alpha: 0.5)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: brandColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.link.icon,
                  size: 16,
                  color: brandColor,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  widget.link.platform,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: widget.isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_outward_rounded,
                size: 16,
                color: _isHovered
                    ? brandColor
                    : (widget.isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary)
                        .withValues(alpha: 0.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Footer Component ─────────────────────────────────────────────────────────

class _Footer extends StatelessWidget {
  final ThemeData theme;
  final Color primaryColor;
  final bool isDark;

  const _Footer({
    required this.theme,
    required this.primaryColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Divider(
            color: (isDark ? Colors.white : Colors.black)
                .withValues(alpha: 0.1),
          ),
          const SizedBox(height: 24),
          Text(
            '© ${DateTime.now().year} ${ProfileData.name}. All rights reserved.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: (isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary)
                  .withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Crafted with ',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: (isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary)
                      .withValues(alpha: 0.6),
                ),
              ),
              Icon(
                Icons.favorite_rounded,
                size: 14,
                color: Colors.redAccent,
              ),
              Text(
                ' & ',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: (isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary)
                      .withValues(alpha: 0.6),
                ),
              ),
              Icon(
                Icons.flutter_dash_rounded,
                size: 16,
                color: primaryColor,
              ),
              Text(
                ' Flutter',
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 800.ms);
  }
}

