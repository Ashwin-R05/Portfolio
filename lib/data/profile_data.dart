/// Central data repository for all portfolio content.
///
/// ALL personal information, project details, skills, and links are
/// defined here as constants. To update your portfolio content, edit
/// only this file — no widget code changes needed.
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/project.dart';
import '../models/skill.dart';
import '../models/social_link.dart';
import '../theme/app_colors.dart';

class ProfileData {
  ProfileData._();

  // ── Personal Info ──────────────────────────────────────────────────
  static const String name = 'Ashwin R';
  static const String role = 'Emerging Software Developer';
  static const String tagline =
      'Full-Stack Developer • UI/UX Enthusiast • Cloud Explorer';
  static const String email = 'ashwinr0205@gmail.com';
  static const String location = 'Trichy, Tamil Nadu, India';
  static const String education = 'B.Tech Information Technology';

  /// Short bio for the About section — conversational, not a résumé dump.
  static const String bio =
      "I'm a B.Tech Information Technology student passionate about "
      "building software that's both powerful and beautiful. I love the "
      "intersection of clean architecture and great user experience — "
      "whether that's crafting a responsive Flutter UI, designing a "
      "scalable Node.js backend, or deploying to the cloud.\n\n"
      "Currently sharpening my skills in Java and Data Structures & "
      "Algorithms, while building real-world projects that push me "
      "to learn something new every day.";

  /// Animated typewriter phrases that cycle on the hero section.
  static const List<String> heroTypingPhrases = [
    'Building full-stack applications.',
    'Crafting beautiful user interfaces.',
    'Exploring cloud architectures.',
    'Learning Data Structures & Algorithms.',
    'Turning ideas into code.',
  ];

  /// What I currently focus on — displayed as animated badges.
  static const List<Map<String, dynamic>> focusAreas = [
    {'label': 'Full-Stack Development', 'icon': Icons.layers_rounded},
    {'label': 'UI/UX Design', 'icon': Icons.palette_rounded},
    {'label': 'Cloud Computing', 'icon': Icons.cloud_rounded},
    {'label': 'DSA & Problem Solving', 'icon': Icons.code_rounded},
  ];

  // ── Skills ─────────────────────────────────────────────────────────
  static const List<Skill> skills = [
    // Languages (inner ring)
    Skill(
      name: 'Java',
      icon: FontAwesomeIcons.java,
      category: SkillCategory.language,
      proficiency: 0.75,
    ),
    Skill(
      name: 'Python',
      icon: FontAwesomeIcons.python,
      category: SkillCategory.language,
      proficiency: 0.7,
    ),
    Skill(
      name: 'JavaScript',
      icon: FontAwesomeIcons.js,
      category: SkillCategory.language,
      proficiency: 0.8,
    ),

    // Frameworks (middle ring)
    Skill(
      name: 'Flutter',
      icon: Icons.flutter_dash_rounded,
      category: SkillCategory.framework,
      proficiency: 0.85,
    ),
    Skill(
      name: 'React',
      icon: FontAwesomeIcons.react,
      category: SkillCategory.framework,
      proficiency: 0.7,
    ),
    Skill(
      name: 'Node.js',
      icon: FontAwesomeIcons.nodeJs,
      category: SkillCategory.framework,
      proficiency: 0.75,
    ),
    Skill(
      name: 'Express',
      icon: FontAwesomeIcons.server,
      category: SkillCategory.framework,
      proficiency: 0.75,
    ),

    // Databases (outer-middle ring)
    Skill(
      name: 'MySQL',
      icon: FontAwesomeIcons.database,
      category: SkillCategory.database,
      proficiency: 0.65,
    ),
    Skill(
      name: 'MongoDB',
      icon: FontAwesomeIcons.leaf,
      category: SkillCategory.database,
      proficiency: 0.7,
    ),

    // Cloud & Tools (outer ring)
    Skill(
      name: 'AWS',
      icon: FontAwesomeIcons.aws,
      category: SkillCategory.cloud,
      proficiency: 0.6,
    ),
  ];

  // ── Projects ───────────────────────────────────────────────────────
  static const List<Project> projects = [
    Project(
      title: 'Summarizit',
      subtitle: 'AI-Powered Summarization App',
      problem:
          'Information overload is real — long articles, research papers, '
          'and documents take too much time to digest. Summarizit solves '
          'this by providing instant AI-generated summaries with a clean, '
          'intuitive mobile interface.',
      stack: ['Flutter', 'Dart', 'Clean Architecture', 'REST API'],
      features: [
        'AI-powered text summarization via external API integration',
        'Clean Architecture with separation of concerns',
        'Responsive Flutter UI with smooth animations',
        'Supports multiple content formats',
        'Offline-capable with local caching',
      ],
      githubUrl: 'https://github.com/Ashwin-R05/Summarizit',
    ),
    Project(
      title: 'Task_Flow',
      subtitle: 'Multi-Tenant Task Management Platform',
      problem:
          'Teams need secure, isolated task management without data '
          'leaking between organizations. Task_Flow is a full-stack '
          'platform with enterprise-grade multi-tenancy, role-based '
          'access control, and JWT authentication.',
      stack: ['Node.js', 'Express', 'MongoDB', 'JWT', 'REST API'],
      features: [
        'Multi-tenant architecture with secure data isolation',
        'JWT-based authentication & authorization',
        'Role-based access control (Admin, Manager, Member)',
        'RESTful API design with proper error handling',
        'Task CRUD with filtering, sorting, and assignment',
      ],
      githubUrl: 'https://github.com/Ashwin-R05/Task_Flow',
    ),
  ];

  // ── Social Links ───────────────────────────────────────────────────
  static const List<SocialLink> socialLinks = [
    SocialLink(
      platform: 'GitHub',
      url: 'https://github.com/Ashwin-R05',
      icon: FontAwesomeIcons.github,
      brandColor: AppColors.darkTextPrimary,
    ),
    SocialLink(
      platform: 'LinkedIn',
      url: 'https://linkedin.com/in/ashwin-r05',
      icon: FontAwesomeIcons.linkedin,
      brandColor: AppColors.linkedinColor,
    ),
    SocialLink(
      platform: 'Instagram',
      url: 'https://instagram.com/ashwin.r05',
      icon: FontAwesomeIcons.instagram,
      brandColor: AppColors.instagramGradientStart,
      brandColorEnd: AppColors.instagramGradientEnd,
    ),
    SocialLink(
      platform: 'Email',
      url: 'mailto:ashwinr0205@gmail.com',
      icon: FontAwesomeIcons.envelope,
      brandColor: AppColors.emailColor,
    ),
  ];
}
