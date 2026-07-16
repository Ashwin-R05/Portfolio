/// Data model for portfolio projects.
///
/// Each project is a case-study entry with problem context, tech stack,
/// key features, and links. Designed to be displayed as expandable cards.
class Project {
  final String title;
  final String subtitle;
  final String problem;
  final List<String> stack;
  final List<String> features;
  final String? githubUrl;
  final String? liveUrl;
  final String? imageAsset;

  const Project({
    required this.title,
    required this.subtitle,
    required this.problem,
    required this.stack,
    required this.features,
    this.githubUrl,
    this.liveUrl,
    this.imageAsset,
  });
}
