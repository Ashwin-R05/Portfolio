/// Home screen — single-page scroll layout assembling all sections.
///
/// Features:
/// - ScrollController for smooth scroll-to-section navigation
/// - Scroll spy to highlight the active nav item
/// - Floating nav bar overlay
/// - Particle canvas as a fixed background on the hero
import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';
import 'hero_section.dart';
import 'about_section.dart';
import 'skills_section.dart';
import 'projects_section.dart';
import 'contact_section.dart';

class HomeScreen extends StatefulWidget {
  /// Whether dark mode is enabled (passed from app-level state).
  final bool isDarkMode;

  /// Callback to toggle the theme.
  final VoidCallback onThemeToggle;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int _activeSection = 0;

  // GlobalKeys for each section — used for scroll-to and scroll spy.
  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();

  late List<NavItem> _navItems;

  @override
  void initState() {
    super.initState();
    _navItems = [
      NavItem(label: 'Home', sectionKey: _heroKey),
      NavItem(label: 'About', sectionKey: _aboutKey),
      NavItem(label: 'Skills', sectionKey: _skillsKey),
      NavItem(label: 'Projects', sectionKey: _projectsKey),
      NavItem(label: 'Contact', sectionKey: _contactKey),
    ];

    _scrollController.addListener(_onScroll);
  }

  /// Scroll spy: determines which section is currently most visible
  /// and updates the active nav item accordingly.
  void _onScroll() {
    final viewportHeight = MediaQuery.of(context).size.height;

    // Check each section's position from bottom to top
    // so that the last matching one wins.
    for (int i = _navItems.length - 1; i >= 0; i--) {
      final key = _navItems[i].sectionKey;
      final renderBox =
          key.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(
          Offset.zero,
          ancestor: context.findRenderObject(),
        );
        // Section is "active" when its top is within the upper 60% of viewport.
        if (position.dy <= viewportHeight * 0.6) {
          if (_activeSection != i) {
            setState(() => _activeSection = i);
          }
          break;
        }
      }
    }
  }

  /// Smoothly scrolls to the section at the given index.
  void _scrollToSection(int index) {
    final key = _navItems[index].sectionKey;
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── Main scrollable content ────────────────────────────────
          SingleChildScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                // Hero section
                KeyedSubtree(
                  key: _heroKey,
                  child: HeroSection(
                    onExplorePressed: () => _scrollToSection(1),
                  ),
                ),

                // About section
                KeyedSubtree(
                  key: _aboutKey,
                  child: const AboutSection(),
                ),

                // Skills section
                KeyedSubtree(
                  key: _skillsKey,
                  child: const SkillsSection(),
                ),

                // Projects section
                KeyedSubtree(
                  key: _projectsKey,
                  child: const ProjectsSection(),
                ),

                // Contact section
                KeyedSubtree(
                  key: _contactKey,
                  child: const ContactSection(),
                ),

                // Bottom padding
                const SizedBox(height: 40),
              ],
            ),
          ),

          // ── Floating nav bar ──────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: NavBar(
                items: _navItems,
                activeIndex: _activeSection,
                isDarkMode: widget.isDarkMode,
                onThemeToggle: widget.onThemeToggle,
                onItemTap: _scrollToSection,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
