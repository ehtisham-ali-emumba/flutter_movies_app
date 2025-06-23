import 'package:movies/core/constants/app_constants.dart';

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
      id: json['id'].toString(),
      title: json['title'],
      description: json['overview'],
      imageUrl: json['backdrop_path'] != null
          ? AppConstants.tMDBImageBaseUrl + json['backdrop_path']
          : '',
      releaseDate: json['release_date'],
      rating: (json['vote_average'] as num).toDouble(),
    );
  }
}
