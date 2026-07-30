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
  static const String role =
      'Aspiring Cybersecurity Intern | Backend & Security-Focused Developer';
  static const String tagline =
      'Cybersecurity Enthusiast • Linux & Networking • OAuth 2.0 & Backend Security';
  static const String email = 'ashwinindira05@gmail.com';
  static const String location = 'Trichy, Tamil Nadu, India';
  static const String education = 'B.Tech Information Technology';
  static const String idNumber = 'SEC-2026-AR05';
  static const String profilePhotoPath = 'assets/images/profile.jpg';

  /// Short bio for the About section — conversational & beginner-friendly.
  static const String bio =
      "I am a pre-final year B.Tech Information Technology student building a solid "
      "foundation in cybersecurity on top of hands-on backend development experience.\n\n"
      "I am comfortable working daily in Linux (Fedora and Kali), with practical grounding "
      "in core networking concepts (TCP/IP, DNS, ports, HTTP/HTTPS) and reconnaissance "
      "techniques (WHOIS, WhatWeb, Wappalyzer, dig, nslookup, basic Nmap scanning). Having "
      "designed and built OAuth 2.0 & JWT-based authentication systems, I bring first-hand "
      "insight into access control, secure API design, and authentication attack vectors.\n\n"
      "Actively practicing on TryHackMe, Wireshark, and exploring the OWASP Top 10, I am "
      "seeking a Cybersecurity Internship to build on this foundation through vulnerability "
      "assessment, security monitoring, and real-world threat research, with a long-term "
      "interest in Cloud Security and DevSecOps.";

  /// Animated typewriter phrases that cycle on the hero section.
  static const List<String> heroTypingPhrases = [
    'Aspiring Cybersecurity Intern.',
    'Comfortable working in Linux (Fedora & Kali).',
    'Practicing Reconnaissance & Network Tools.',
    'Building OAuth 2.0 & JWT Auth Systems.',
    'Learning OWASP Top 10 & TryHackMe Labs.',
    'Exploring Cloud Security & DevSecOps.',
  ];

  /// What I currently focus on — displayed as animated badges.
  static const List<Map<String, dynamic>> focusAreas = [
    {'label': 'Security Fundamentals & Recon (Nmap, WHOIS, dig)', 'icon': Icons.shield_rounded},
    {'label': 'Linux Systems & Networking (Fedora, Kali, TCP/IP, DNS)', 'icon': Icons.terminal_rounded},
    {'label': 'Backend & Auth Security (OAuth 2.0, JWT, PKCE, RBAC)', 'icon': Icons.lock_rounded},
    {'label': 'Cloud Security & DevSecOps Basics (AWS, Docker, CI/CD)', 'icon': Icons.cloud_rounded},
  ];

  // ── Skills ─────────────────────────────────────────────────────────
  static const List<Skill> skills = [
    // Languages & Operating Systems (inner ring)
    Skill(
      name: 'Linux (Kali & Fedora)',
      icon: Icons.terminal_rounded,
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
      name: 'Python',
      icon: Icons.pest_control_rounded,
      category: SkillCategory.language,
      proficiency: 0.75,
    ),
    Skill(
      name: 'JavaScript',
      icon: Icons.javascript_rounded,
      category: SkillCategory.language,
      proficiency: 0.8,
    ),
    Skill(
      name: 'Dart',
      icon: Icons.flutter_dash_rounded,
      category: SkillCategory.language,
      proficiency: 0.75,
    ),

    // Frameworks, Auth & Recon Tools (middle ring)
    Skill(
      name: 'OAuth 2.0 & JWT',
      icon: Icons.lock_rounded,
      category: SkillCategory.framework,
      proficiency: 0.85,
    ),
    Skill(
      name: 'Networking (TCP/IP, DNS)',
      icon: Icons.lan_rounded,
      category: SkillCategory.framework,
      proficiency: 0.75,
    ),
    Skill(
      name: 'Recon (Nmap, dig, WHOIS)',
      icon: Icons.search_rounded,
      category: SkillCategory.framework,
      proficiency: 0.75,
    ),
    Skill(
      name: 'Node.js & Express',
      icon: Icons.dns_rounded,
      category: SkillCategory.framework,
      proficiency: 0.75,
    ),
    Skill(
      name: 'Flutter & React',
      icon: Icons.web_rounded,
      category: SkillCategory.framework,
      proficiency: 0.8,
    ),

    // Databases & Storage (outer-middle ring)
    Skill(
      name: 'MongoDB',
      icon: Icons.eco_rounded,
      category: SkillCategory.database,
      proficiency: 0.7,
    ),
    Skill(
      name: 'SQLite',
      icon: Icons.data_array_rounded,
      category: SkillCategory.database,
      proficiency: 0.75,
    ),
    Skill(
      name: 'MySQL',
      icon: Icons.storage_rounded,
      category: SkillCategory.database,
      proficiency: 0.65,
    ),

    // Cloud, DevSecOps & Security Practice (outer ring)
    Skill(
      name: 'TryHackMe & OWASP',
      icon: Icons.security_rounded,
      category: SkillCategory.cloud,
      proficiency: 0.7,
    ),
    Skill(
      name: 'Wireshark Analysis',
      icon: Icons.insights_rounded,
      category: SkillCategory.cloud,
      proficiency: 0.65,
    ),
    Skill(
      name: 'Docker & CI/CD',
      icon: Icons.developer_board_rounded,
      category: SkillCategory.cloud,
      proficiency: 0.75,
    ),
    Skill(
      name: 'AWS Cloud',
      icon: Icons.cloud_queue_rounded,
      category: SkillCategory.cloud,
      proficiency: 0.65,
    ),
  ];

  // ── Projects ───────────────────────────────────────────────────────
  static const List<Project> projects = [
    Project(
      title: 'AuthForge',
      subtitle: 'Centralized OAuth 2.0 / OpenID Connect Identity Provider',
      problem:
          'Campus ecosystems require centralized identity management to prevent '
          'credential leaks and token attack vectors. Designed AuthForge as a centralized '
          'OAuth 2.0 / OpenID Connect server handling authentication across multiple applications.',
      stack: ['Java', 'Node.js', 'OAuth 2.0', 'PKCE', 'JWT', 'SQLite', 'Distributed Systems'],
      features: [
        'Centralized OAuth 2.0 & OpenID Connect identity provider for campus services',
        'Implemented full authorization code flow with PKCE to prevent auth code interception',
        'JWT-based access control with secure refresh token rotation addressing token theft and replay vectors',
        'Applied security-first design principles to build a reliable, scalable auth infrastructure',
      ],
      githubUrl: 'https://github.com/Ashwin-R05',
    ),
    Project(
      title: 'Task_Flow',
      subtitle: 'Multi-Tenant Distributed Task Management System',
      problem:
          'Multi-tenant enterprise backends must strictly isolate data between organizations '
          'to prevent cross-tenant data leaks. Task_Flow is a full-stack platform built with '
          'strict tenant isolation, RBAC, and password hashing.',
      stack: ['Java', 'Node.js', 'MongoDB', 'JWT', 'Docker', 'GitHub Actions', 'REST API'],
      features: [
        'Multi-tenant architecture with strict data isolation using shared-database, shared-collection pattern',
        'Role-based access control (RBAC) & secure token-based authentication with bcrypt hashing',
        'Restricted API endpoints designed to prevent cross-tenant data exposure',
        'Containerized full stack with Docker; automated CI/CD deployments via GitHub Actions',
      ],
      githubUrl: 'https://github.com/Ashwin-R05/Task_Flow',
    ),
    Project(
      title: 'Summarizit',
      subtitle: 'Cross-Platform AI Summarization Application',
      problem:
          'Processing external API communications securely requires separating concerns across '
          'data, domain, and presentation layers to reduce attack surface and maintain testability.',
      stack: ['Dart', 'Flutter', 'REST API', 'Clean Architecture', 'Android / iOS / Web / Desktop'],
      features: [
        'Built with Clean Architecture to separate concerns and reduce attack surface',
        'Integrated external AI summarization API handling payload processing securely',
        'Ships to 6 platforms (Android, iOS, Web, Windows, Linux, macOS) from a single codebase',
      ],
      githubUrl: 'https://github.com/Ashwin-R05/summarizit',
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
