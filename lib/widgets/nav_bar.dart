/// Floating glassmorphism navigation bar.
///
/// Desktop: horizontal nav with section links + sliding active-indicator bar
/// + theme toggle.
/// Mobile: hamburger icon opening a bottom-sheet drawer.
/// The active indicator is a gradient pill that smoothly slides between nav
/// items via AnimatedPositioned.
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'theme_toggle.dart';

class NavItem {
  final String label;
  final GlobalKey sectionKey;
  const NavItem({required this.label, required this.sectionKey});
}

class NavBar extends StatelessWidget {
  final List<NavItem> items;
  final int activeIndex;
  final bool isDarkMode;
  final VoidCallback onThemeToggle;
  final ValueChanged<int> onItemTap;

  const NavBar({
    super.key,
    required this.items,
    required this.activeIndex,
    required this.isDarkMode,
    required this.onThemeToggle,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 16,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkSurface.withValues(alpha: 0.7)
            : AppColors.lightSurface.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.07)
              : Colors.black.withValues(alpha: 0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.07),
            blurRadius: 28,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: (isDark ? AppColors.darkPrimary : AppColors.lightPrimary)
                .withValues(alpha: 0.03),
            blurRadius: 60,
          ),
        ],
      ),
      child: Row(
        children: [
          // ── Logo ──────────────────────────────────────────────────────
          _LogoBadge(isDark: isDark),
          const Spacer(),

          if (isMobile)
            _MobileMenuButton(
              items: items,
              activeIndex: activeIndex,
              isDarkMode: isDarkMode,
              onThemeToggle: onThemeToggle,
              onItemTap: onItemTap,
            )
          else ...[
            _DesktopNav(
              items: items,
              activeIndex: activeIndex,
              isDark: isDark,
              onItemTap: onItemTap,
            ),
            const SizedBox(width: 16),
            ThemeToggle(isDarkMode: isDarkMode, onToggle: onThemeToggle),
          ],
        ],
      ),
    );
  }
}

// ── Logo badge ─────────────────────────────────────────────────────────────────

class _LogoBadge extends StatefulWidget {
  final bool isDark;
  const _LogoBadge({required this.isDark});

  @override
  State<_LogoBadge> createState() => _LogoBadgeState();
}

class _LogoBadgeState extends State<_LogoBadge> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final primary = widget.isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final secondary = widget.isDark ? AppColors.darkSecondary : AppColors.lightSecondary;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: _hovered
              ? LinearGradient(colors: [primary, secondary])
              : null,
          color: _hovered ? null : primary.withValues(alpha: 0.1),
        ),
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: _hovered ? [Colors.white, Colors.white] : [primary, secondary],
          ).createShader(bounds),
          child: Text(
            'AR',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Desktop nav with sliding indicator ────────────────────────────────────────

class _DesktopNav extends StatelessWidget {
  final List<NavItem> items;
  final int activeIndex;
  final bool isDark;
  final ValueChanged<int> onItemTap;

  const _DesktopNav({
    required this.items,
    required this.activeIndex,
    required this.isDark,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isActive = index == activeIndex;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: _NavLink(
            label: item.label,
            isActive: isActive,
            onTap: () => onItemTap(index),
            isDark: isDark,
          ),
        );
      }).toList(),
    );
  }
}

// ── Individual nav link ───────────────────────────────────────────────────────

class _NavLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final bool isDark;

  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.isDark,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final primary = widget.isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final secondary = widget.isDark ? AppColors.darkSecondary : AppColors.lightSecondary;
    final textColor = widget.isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: widget.isActive
                    ? primary.withValues(alpha: 0.1)
                    : _isHovered
                        ? (widget.isDark
                            ? Colors.white.withValues(alpha: 0.04)
                            : Colors.black.withValues(alpha: 0.03))
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ShaderMask(
                shaderCallback: (bounds) {
                  if (widget.isActive || _isHovered) {
                    return LinearGradient(colors: [primary, secondary])
                        .createShader(bounds);
                  }
                  return LinearGradient(
                    colors: [
                      textColor.withValues(alpha: 0.65),
                      textColor.withValues(alpha: 0.65),
                    ],
                  ).createShader(bounds);
                },
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
                    color: Colors.white, // masked by ShaderMask
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),

            // ── Sliding gradient underline indicator ───────────────────
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              height: 2,
              width: widget.isActive ? 28 : (_isHovered ? 14 : 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
                gradient: LinearGradient(
                  colors: [primary, secondary],
                ),
                boxShadow: [
                  if (widget.isActive)
                    BoxShadow(
                      color: primary.withValues(alpha: 0.55),
                      blurRadius: 6,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Mobile hamburger menu ─────────────────────────────────────────────────────

class _MobileMenuButton extends StatelessWidget {
  final List<NavItem> items;
  final int activeIndex;
  final bool isDarkMode;
  final VoidCallback onThemeToggle;
  final ValueChanged<int> onItemTap;

  const _MobileMenuButton({
    required this.items,
    required this.activeIndex,
    required this.isDarkMode,
    required this.onThemeToggle,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ThemeToggle(isDarkMode: isDarkMode, onToggle: onThemeToggle),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () => _showMenu(context),
        ),
      ],
    );
  }

  void _showMenu(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final secondaryColor = isDark ? AppColors.darkSecondary : AppColors.lightSecondary;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Gradient drag handle
                Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    gradient: LinearGradient(
                      colors: [primaryColor, secondaryColor],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ...items.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final isActive = index == activeIndex;

                  return ListTile(
                    title: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: isActive
                            ? [primaryColor, secondaryColor]
                            : [
                                (isDark
                                    ? AppColors.darkTextPrimary
                                    : AppColors.lightTextPrimary),
                                (isDark
                                    ? AppColors.darkTextPrimary
                                    : AppColors.lightTextPrimary),
                              ],
                      ).createShader(bounds),
                      child: Text(
                        item.label,
                        style: TextStyle(
                          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    leading: isActive
                        ? Icon(Icons.arrow_right_rounded, color: primaryColor)
                        : const SizedBox(width: 24),
                    onTap: () {
                      Navigator.pop(context);
                      onItemTap(index);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
