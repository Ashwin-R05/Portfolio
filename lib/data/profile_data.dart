/// Central data repository for all portfolio content.
///
/// ALL personal information, project details, skills, and links are
/// defined here as constants. To update your portfolio content, edit
/// only this file — no widget code changes needed.
import 'package:flutter/material.dart';
import '../models/project.dart';
import '../models/skill.dart';
import '../models/social_link.dart';
import '../theme/app_colors.dart';

class ProfileData {
  ProfileData._();

  // ── Personal Info ──────────────────────────────────────────────────
  static const String name = 'Ashwin R';
  static const String role = 'Full-Stack Developer & Software Engineer';
  static const String tagline =
      'Full-Stack Developer • UI/UX & Mobile • Cybersecurity & Cloud Explorer';
  static const String email = 'ashwinindira05@gmail.com';
  static const String location = 'Trichy, Tamil Nadu, India';
  static const String education = 'B.Tech Information Technology';
  static const String idNumber = 'DEV-2026-AR05';
  static const String profilePhotoPath = 'assets/images/profile.jpg';

  /// Short bio for the About section — balanced full-stack & security learning profile.
  static const String bio =
      "I'm a pre-final year B.Tech Information Technology student specializing in "
      "full-stack web and cross-platform software development.\n\n"
      "My core strength lies in building scalable, production-ready web and mobile "
      "applications using Flutter, Node.js, Express, React, and MongoDB/MySQL. "
      "I focus on clean architecture, responsive UI/UX design, and robust RESTful API design.\n\n"
      "Alongside full-stack engineering, I am actively expanding my foundation in "
      "cybersecurity, Linux environments (Fedora & Kali), core networking concepts (TCP/IP, DNS), "
      "and authentication security (OAuth 2.0, JWT, PKCE), with a strong interest in DevSecOps and Cloud Security.";

  /// Animated typewriter phrases that cycle on the hero section.
  static const List<String> heroTypingPhrases = [
    'Building full-stack web & mobile apps.',
    'Designing RESTful APIs & scalable backends.',
    'Crafting clean UIs with Flutter & React.',
    'Practicing Linux & Core Networking.',
    'Exploring Cybersecurity & Cloud Security.',
  ];

  /// What I currently focus on — displayed as animated badges.
  static const List<Map<String, dynamic>> focusAreas = [
    {'label': 'Full-Stack Web & Mobile Dev', 'icon': Icons.layers_rounded},
    {'label': 'Backend Architecture & REST APIs', 'icon': Icons.dns_rounded},
    {'label': 'Linux & Core Networking (TCP/IP, DNS)', 'icon': Icons.terminal_rounded},
    {'label': 'Cybersecurity & Auth (OAuth 2.0, JWT)', 'icon': Icons.security_rounded},
  ];

  // ── Skills ─────────────────────────────────────────────────────────
  static const List<Skill> skills = [
    // Languages & Operating Systems (inner ring)
    Skill(
      name: 'JavaScript',
      icon: Icons.javascript_rounded,
      category: SkillCategory.language,
      proficiency: 0.85,
    ),
    Skill(
      name: 'Java',
      icon: Icons.coffee_rounded,
      category: SkillCategory.language,
      proficiency: 0.8,
    ),
    Skill(
      name: 'Dart',
      icon: Icons.flutter_dash_rounded,
      category: SkillCategory.language,
      proficiency: 0.85,
    ),
    Skill(
      name: 'Python',
      icon: Icons.pest_control_rounded,
      category: SkillCategory.language,
      proficiency: 0.75,
    ),
    Skill(
      name: 'Linux (Fedora/Kali)',
      icon: Icons.terminal_rounded,
      category: SkillCategory.language,
      proficiency: 0.8,
    ),

    // Frameworks & Web (middle ring)
    Skill(
      name: 'Flutter',
      icon: Icons.flutter_dash_rounded,
      category: SkillCategory.framework,
      proficiency: 0.88,
    ),
    Skill(
      name: 'Node.js & Express',
      icon: Icons.dns_rounded,
      category: SkillCategory.framework,
      proficiency: 0.82,
    ),
    Skill(
      name: 'React',
      icon: Icons.web_rounded,
      category: SkillCategory.framework,
      proficiency: 0.75,
    ),
    Skill(
      name: 'OAuth 2.0 & JWT',
      icon: Icons.lock_rounded,
      category: SkillCategory.framework,
      proficiency: 0.8,
    ),
    Skill(
      name: 'REST APIs',
      icon: Icons.route_rounded,
      category: SkillCategory.framework,
      proficiency: 0.85,
    ),

    // Databases (outer-middle ring)
    Skill(
      name: 'MongoDB',
      icon: Icons.eco_rounded,
      category: SkillCategory.database,
      proficiency: 0.78,
    ),
    Skill(
      name: 'MySQL',
      icon: Icons.storage_rounded,
      category: SkillCategory.database,
      proficiency: 0.72,
    ),
    Skill(
      name: 'SQLite',
      icon: Icons.data_array_rounded,
      category: SkillCategory.database,
      proficiency: 0.75,
    ),

    // Cloud, Tools & Security (outer ring)
    Skill(
      name: 'AWS Cloud',
      icon: Icons.cloud_queue_rounded,
      category: SkillCategory.cloud,
      proficiency: 0.68,
    ),
    Skill(
      name: 'Docker & CI/CD',
      icon: Icons.developer_board_rounded,
      category: SkillCategory.cloud,
      proficiency: 0.75,
    ),
    Skill(
      name: 'Git & GitHub',
      icon: Icons.code_rounded,
      category: SkillCategory.cloud,
      proficiency: 0.85,
    ),
    Skill(
      name: 'Recon & Security Tools',
      icon: Icons.security_rounded,
      category: SkillCategory.cloud,
      proficiency: 0.7,
    ),
  ];

  // ── Projects ───────────────────────────────────────────────────────
  static const List<Project> projects = [
    Project(
      title: 'Task_Flow',
      subtitle: 'Multi-Tenant Distributed Task Management Platform',
      problem:
          'Teams and enterprises need isolated task management without risk of cross-tenant '
          'data exposure. Task_Flow is a full-stack platform with multi-tenancy architecture, '
          'role-based access control (RBAC), and JWT authentication.',
      stack: ['Node.js', 'Express', 'MongoDB', 'JWT', 'Docker', 'GitHub Actions', 'REST API'],
      features: [
        'Multi-tenant architecture with secure data isolation using shared-database pattern',
        'JWT-based authentication & role-based access control (RBAC) with bcrypt password hashing',
        'RESTful API design with comprehensive input validation and error handling',
        'Containerized full stack with Docker; automated CI/CD deployments via GitHub Actions',
        'Task CRUD with filtering, sorting, and organizational workspace assignment',
      ],
      githubUrl: 'https://github.com/Ashwin-R05/Task_Flow',
    ),
    Project(
      title: 'Summarizit',
      subtitle: 'Cross-Platform AI Summarization Application',
      problem:
          'Information overload makes long documents and articles tedious to digest. '
          'Summarizit provides instant AI summaries with a clean, responsive interface '
          'built using Clean Architecture.',
      stack: ['Dart', 'Flutter', 'REST API', 'Clean Architecture', 'Android / iOS / Web / Desktop'],
      features: [
        'Designed using Clean Architecture to separate data, domain, and presentation layers',
        'AI-powered text summarization via external REST API integration',
        'Responsive Flutter UI with dynamic animations across mobile and web',
        'Ships to 6 platforms (Android, iOS, Web, Windows, Linux, macOS) from a single codebase',
      ],
      githubUrl: 'https://github.com/Ashwin-R05/summarizit',
    ),
    Project(
      title: 'AuthForge',
      subtitle: 'Centralized OAuth 2.0 / OpenID Connect Identity Provider',
      problem:
          'Campus ecosystems require centralized identity management to authenticate users '
          'across multiple services while handling authorization securely.',
      stack: ['Java', 'Node.js', 'OAuth 2.0', 'PKCE', 'JWT', 'SQLite', 'Distributed Systems'],
      features: [
        'Centralized OAuth 2.0 & OpenID Connect identity provider for campus services',
        'Implemented full authorization code flow with PKCE to prevent code interception',
        'JWT access control with refresh token rotation addressing token replay vectors',
        'Built with security-first design patterns for reliable, scalable auth infrastructure',
      ],
      githubUrl: 'https://github.com/Ashwin-R05',
    ),
  ];

  // ── Social Links ───────────────────────────────────────────────────
  static const List<SocialLink> socialLinks = [
    SocialLink(
      platform: 'GitHub',
      url: 'https://github.com/Ashwin-R05',
      icon: Icons.code_rounded,
      brandColor: AppColors.darkTextPrimary,
    ),
    SocialLink(
      platform: 'LinkedIn',
      url: 'https://linkedin.com/in/ashwin-r05',
      icon: Icons.work_outline_rounded,
      brandColor: AppColors.linkedinColor,
    ),
    SocialLink(
      platform: 'Instagram',
      url: 'https://instagram.com/ashwin.r05',
      icon: Icons.camera_alt_outlined,
      brandColor: AppColors.instagramGradientStart,
      brandColorEnd: AppColors.instagramGradientEnd,
    ),
    SocialLink(
      platform: 'Email',
      url: 'mailto:ashwinindira05@gmail.com',
      icon: Icons.email_outlined,
      brandColor: AppColors.emailColor,
    ),
  ];
}
