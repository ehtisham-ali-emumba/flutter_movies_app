class Movie {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String releaseDate;
  final double rating;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.releaseDate,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      releaseDate: json['releaseDate'],
      rating: (json['rating'] as num).toDouble(),
    );
  }
}
