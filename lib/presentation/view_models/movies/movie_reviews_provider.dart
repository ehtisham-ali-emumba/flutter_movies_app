import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/data/models/movie_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class MovieReviewsState {
  final Map<String, List<MovieReview>> reviews;
  final bool isLoading;
  final String? error;

  MovieReviewsState({
    this.reviews = const {},
    this.isLoading = false,
    this.error,
  });

  MovieReviewsState copyWith({
    Map<String, List<MovieReview>>? reviews,
    bool? isLoading,
    String? error,
  }) {
    return MovieReviewsState(
      reviews: reviews ?? this.reviews,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  List<MovieReview> getReviewsForMovie(String movieId) {
    return reviews[movieId] ?? [];
  }
}

// Provider for managing movie reviews
final movieReviewsProvider =
    StateNotifierProvider<MovieReviewsNotifier, MovieReviewsState>(
      (ref) => MovieReviewsNotifier(),
    );

class MovieReviewsNotifier extends StateNotifier<MovieReviewsState> {
  MovieReviewsNotifier() : super(MovieReviewsState()) {
    loadReviewsFromPrefs();
  }

  static const _reviewsStorageKey = 'movie_reviews';

  Future<void> addReview({
    required String movieId,
    required String userName,
    required String comment,
    required double rating,
    required String imageFilePath,
  }) async {
    final review = MovieReview(
      id: const Uuid().v4(),
      movieId: movieId,
      userName: userName,
      comment: comment,
      rating: rating,
      datePosted: DateTime.now(),
      imageFilePath: imageFilePath,
    );

    final updatedReviews = Map<String, List<MovieReview>>.from(state.reviews);

    if (updatedReviews.containsKey(movieId)) {
      updatedReviews[movieId] = [...updatedReviews[movieId]!, review];
    } else {
      updatedReviews[movieId] = [review];
    }

    state = state.copyWith(reviews: updatedReviews);

    await _saveReviewsToPrefs(updatedReviews);
  }

  Future<void> deleteReview(String movieId, String reviewId) async {
    if (!state.reviews.containsKey(movieId)) return;

    final updatedReviews = Map<String, List<MovieReview>>.from(state.reviews);

    updatedReviews[movieId] = updatedReviews[movieId]!
        .where((review) => review.id != reviewId)
        .toList();

    // If the movie has no more reviews, remove the movie entry
    if (updatedReviews[movieId]!.isEmpty) {
      updatedReviews.remove(movieId);
    }

    // Update state
    state = state.copyWith(reviews: updatedReviews);

    // Save to SharedPreferences
    await _saveReviewsToPrefs(updatedReviews);
  }

  // Load reviews from SharedPreferences
  Future<void> loadReviewsFromPrefs() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final prefs = await SharedPreferences.getInstance();
      final reviewsJson = prefs.getString(_reviewsStorageKey);

      if (reviewsJson == null || reviewsJson.isEmpty) {
        state = state.copyWith(isLoading: false);
        return;
      }

      final Map<String, dynamic> decodedData = json.decode(reviewsJson);
      final Map<String, List<MovieReview>> loadedReviews = {};

      decodedData.forEach((movieId, reviewsData) {
        final List<dynamic> reviewsList = reviewsData as List<dynamic>;
        loadedReviews[movieId] = reviewsList.map((reviewData) {
          return MovieReview(
            id: reviewData['id'],
            movieId: reviewData['movieId'],
            userName: reviewData['userName'],
            comment: reviewData['comment'],
            rating: reviewData['rating'].toDouble(),
            datePosted: DateTime.parse(reviewData['datePosted']),
            imageFilePath: reviewData['imageFilePath'] ?? '',
          );
        }).toList();
      });

      state = state.copyWith(reviews: loadedReviews, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load reviews: ${e.toString()}',
      );
      print('Error loading reviews: $e');
    }
  }

  Future<void> _saveReviewsToPrefs(
    Map<String, List<MovieReview>> reviewsMap,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final Map<String, List<Map<String, dynamic>>> jsonData = {};

      reviewsMap.forEach((movieId, reviews) {
        jsonData[movieId] = reviews
            .map(
              (review) => {
                'id': review.id,
                'movieId': review.movieId,
                'userName': review.userName,
                'comment': review.comment,
                'rating': review.rating,
                'datePosted': review.datePosted.toIso8601String(),
                'imageFilePath': review.imageFilePath,
              },
            )
            .toList();
      });

      await prefs.setString(_reviewsStorageKey, json.encode(jsonData));
    } catch (e) {
      print('Error saving reviews: $e');
      state = state.copyWith(error: 'Failed to save reviews: ${e.toString()}');
    }
  }
}
