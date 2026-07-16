/// Floating glassmorphism navigation bar.
///
/// Desktop: horizontal nav with section links + theme toggle.
/// Mobile: hamburger icon opening a drawer.
/// Features transparent blur background, active section highlighting
/// via scroll spy, and smooth scroll-to-section on tap.
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'theme_toggle.dart';

/// Navigation items with their labels and scroll keys.
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
        // Glassmorphism effect
        color: isDark
            ? AppColors.darkSurface.withValues(alpha: 0.75)
            : AppColors.lightSurface.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.06),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo / Name
          Text(
            'AR',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),

          if (isMobile)
            // Mobile: hamburger menu
            _MobileMenuButton(
              items: items,
              activeIndex: activeIndex,
              isDarkMode: isDarkMode,
              onThemeToggle: onThemeToggle,
              onItemTap: onItemTap,
            )
          else ...[
            // Desktop: horizontal nav items
            ...items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isActive = index == activeIndex;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _NavLink(
                  label: item.label,
                  isActive: isActive,
                  onTap: () => onItemTap(index),
                ),
              );
            }),
            const SizedBox(width: 16),
            ThemeToggle(
              isDarkMode: isDarkMode,
              onToggle: onThemeToggle,
            ),
          ],
        ],
      ),
    );
  }
}

/// Individual nav link with animated active indicator.
class _NavLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor =
        isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: widget.isActive
                ? primaryColor.withValues(alpha: 0.1)
                : _isHovered
                    ? (isDark
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.black.withValues(alpha: 0.03))
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight:
                  widget.isActive ? FontWeight.w600 : FontWeight.w400,
              color: widget.isActive ? primaryColor : textColor.withValues(alpha: 0.7),
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}

/// Mobile hamburger menu button that opens a bottom sheet.
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
    final primaryColor =
        isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

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
                // Drag handle
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.2)
                        : Colors.black.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                ...items.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final isActive = index == activeIndex;

                  return ListTile(
                    title: Text(
                      item.label,
                      style: TextStyle(
                        fontWeight:
                            isActive ? FontWeight.w600 : FontWeight.w400,
                        color: isActive ? primaryColor : null,
                      ),
                    ),
                    leading: isActive
                        ? Icon(Icons.arrow_right_rounded,
                            color: primaryColor)
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
