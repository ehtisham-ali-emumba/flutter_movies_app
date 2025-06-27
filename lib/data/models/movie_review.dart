// Review model class
class MovieReview {
  final String id;
  final String movieId;
  final String userName;
  final String comment;
  final double rating;
  final DateTime datePosted;
  final String imageFilePath;

  MovieReview({
    required this.id,
    required this.movieId,
    required this.userName,
    required this.comment,
    required this.rating,
    required this.datePosted,
    required this.imageFilePath,
  });
}
