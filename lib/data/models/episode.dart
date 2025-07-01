class Episode {
  final String title;
  final String description;
  final String thumbnailUrl;
  final String videoUrl;
  final Duration duration;
  bool isPlaying;

  Episode({
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.duration,
    this.isPlaying = false,
  });

  @override
  String toString() {
    return 'Episode(title: $title, description: $description, thumbnailUrl: $thumbnailUrl, videoUrl: $videoUrl, duration: $duration, isPlaying: $isPlaying)';
  }
}
