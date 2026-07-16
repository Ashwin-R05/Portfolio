/// Data model for skills/technologies.
///
/// Skills are categorized into groups (Languages, Frameworks, etc.)
/// and include a proficiency level for the orbital visualization.
import 'package:flutter/material.dart';

class Skill {
  final String name;
  final IconData icon;
  final SkillCategory category;
  /// Proficiency from 0.0 to 1.0 — used for orbital ring placement
  /// and bar width in the mobile fallback view.
  final double proficiency;

  const Skill({
    required this.name,
    required this.icon,
    required this.category,
    required this.proficiency,
  });
}

/// Skill categories determine which orbital ring a skill sits on.
/// Inner ring = most fundamental, outer ring = highest-level.
enum SkillCategory {
  language('Languages'),
  framework('Frameworks'),
  database('Databases'),
  cloud('Cloud & Tools');

  final String label;
  const SkillCategory(this.label);
}
