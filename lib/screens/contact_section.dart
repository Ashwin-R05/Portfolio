/// Contact section with form and social links.
///
/// Dual layout: contact form (mailto fallback) on the left,
/// animated social link buttons on the right.
/// Includes a footer with copyright.
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/profile_data.dart';
import '../theme/app_colors.dart';
import '../widgets/section_wrapper.dart';
import '../widgets/social_button.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  /// Opens the user's mail client with pre-filled fields.
  Future<void> _sendEmail() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill in all fields.'),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
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
          // Section title
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Get In Touch',
                style: theme.textTheme.displaySmall?.copyWith(
                  color: theme.colorScheme.onSurface,
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
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withValues(alpha: 0.3)],
                  ),
                ),
              ).animate().scaleX(
                    begin: 0,
                    end: 1,
                    duration: 600.ms,
                    delay: 200.ms,
                    alignment: Alignment.centerLeft,
                  ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Have a project in mind or just want to say hi? I'd love to hear from you.",
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.7),
            ),
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 200.ms),
          const SizedBox(height: 48),

          // Main content
          isMobile
              ? Column(
                  children: [
                    _ContactForm(
                      nameController: _nameController,
                      emailController: _emailController,
                      messageController: _messageController,
                      onSend: _sendEmail,
                      primaryColor: primaryColor,
                      theme: theme,
                    ),
                    const SizedBox(height: 48),
                    _SocialLinksColumn(secondaryColor: secondaryColor),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left: Contact form
                    Expanded(
                      flex: 5,
                      child: _ContactForm(
                        nameController: _nameController,
                        emailController: _emailController,
                        messageController: _messageController,
                        onSend: _sendEmail,
                        primaryColor: primaryColor,
                        theme: theme,
                      ),
                    ),
                    const SizedBox(width: 64),
                    // Right: Social links
                    Expanded(
                      flex: 3,
                      child: _SocialLinksColumn(secondaryColor: secondaryColor),
                    ),
                  ],
                ),

          // Footer
          const SizedBox(height: 80),
          _Footer(theme: theme, primaryColor: primaryColor),
        ],
      ),
    );
  }
}

/// Contact form with name, email, message fields and send button.
class _ContactForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;
  final VoidCallback onSend;
  final Color primaryColor;
  final ThemeData theme;

  const _ContactForm({
    required this.nameController,
    required this.emailController,
    required this.messageController,
    required this.onSend,
    required this.primaryColor,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: nameController,
          style: TextStyle(color: theme.colorScheme.onSurface),
          decoration: const InputDecoration(
            labelText: 'Your Name',
            prefixIcon: Icon(Icons.person_outline_rounded),
          ),
        )
            .animate()
            .fadeIn(duration: 500.ms, delay: 300.ms)
            .slideY(begin: 0.1, end: 0),
        const SizedBox(height: 20),
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: theme.colorScheme.onSurface),
          decoration: const InputDecoration(
            labelText: 'Your Email',
            prefixIcon: Icon(Icons.email_outlined),
          ),
        )
            .animate()
            .fadeIn(duration: 500.ms, delay: 400.ms)
            .slideY(begin: 0.1, end: 0),
        const SizedBox(height: 20),
        TextField(
          controller: messageController,
          maxLines: 5,
          style: TextStyle(color: theme.colorScheme.onSurface),
          decoration: const InputDecoration(
            labelText: 'Message',
            prefixIcon: Padding(
              padding: EdgeInsets.only(bottom: 80),
              child: Icon(Icons.message_outlined),
            ),
            alignLabelWithHint: true,
          ),
        )
            .animate()
            .fadeIn(duration: 500.ms, delay: 500.ms)
            .slideY(begin: 0.1, end: 0),
        const SizedBox(height: 28),
        _SendButton(onPressed: onSend, primaryColor: primaryColor)
            .animate()
            .fadeIn(duration: 500.ms, delay: 600.ms)
            .slideY(begin: 0.2, end: 0),
      ],
    );
  }
}

/// Animated send button.
class _SendButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Color primaryColor;

  const _SendButton({
    required this.onPressed,
    required this.primaryColor,
  });

  @override
  State<_SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<_SendButton> {
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
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          transform: Matrix4.diagonal3Values(
            _isHovered ? 1.03 : 1.0,
            _isHovered ? 1.03 : 1.0,
            1.0,
          ),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.primaryColor,
            borderRadius: BorderRadius.circular(14),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.primaryColor.withValues(alpha: 0.4),
                      blurRadius: 20,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.send_rounded, color: Colors.white, size: 18),
              const SizedBox(width: 10),
              const Text(
                'Send Message',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
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

/// Social links column with animated buttons.
class _SocialLinksColumn extends StatelessWidget {
  final Color secondaryColor;

  const _SocialLinksColumn({required this.secondaryColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connect With Me',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        )
            .animate()
            .fadeIn(duration: 500.ms, delay: 300.ms),
        const SizedBox(height: 8),
        Text(
          'Find me on these platforms',
          style: theme.textTheme.bodyMedium,
        )
            .animate()
            .fadeIn(duration: 500.ms, delay: 400.ms),
        const SizedBox(height: 28),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: ProfileData.socialLinks.asMap().entries.map((entry) {
            final index = entry.key;
            final link = entry.value;
            final delay = 500 + (index * 100);

            return SocialButton(link: link, size: 56)
                .animate()
                .fadeIn(
                  duration: 500.ms,
                  delay: Duration(milliseconds: delay),
                )
                .scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1, 1),
                  duration: 500.ms,
                  delay: Duration(milliseconds: delay),
                );
          }).toList(),
        ),
      ],
    );
  }
}

/// Footer with copyright and "Built with Flutter" badge.
class _Footer extends StatelessWidget {
  final ThemeData theme;
  final Color primaryColor;

  const _Footer({required this.theme, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Divider(
            color: theme.dividerTheme.color,
          ),
          const SizedBox(height: 24),
          Text(
            '© ${DateTime.now().year} Ashwin R. All rights reserved.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Built with ',
                style: theme.textTheme.bodySmall?.copyWith(
                  color:
                      theme.textTheme.bodySmall?.color?.withValues(alpha: 0.5),
                ),
              ),
              Icon(
                Icons.flutter_dash_rounded,
                size: 16,
                color: primaryColor,
              ),
              Text(
                ' Flutter',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms, delay: 800.ms);
  }
}
