import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/data/models/movie_review.dart';
import 'package:movies/presentation/view_models/movies/movie_reviews_provider.dart';
import 'package:movies/presentation/views/movies/add_rate_movie_screen.dart';
import 'package:movies/presentation/widgets/custom_snackbar.dart';
import 'package:movies/presentation/widgets/text.dart';

class MovieReviews extends ConsumerWidget {
  final Movie movie;

  const MovieReviews({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsState = ref.watch(movieReviewsProvider);
    final reviews = reviewsState.getReviewsForMovie(movie.id);
    final isLoading = reviewsState.isLoading;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText('Reviews', kind: TextKind.heading, fontSize: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddRateMovieScreen(
                      movieId: movie.id,
                      movieTitle: movie.title,
                    ),
                  ),
                );
              },
              icon: Icon(Icons.add),
              label: Text('Add Review'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),

        if (isLoading)
          const Center(child: CircularProgressIndicator())
        else if (reviews.isEmpty)
          AppText(
            'No reviews yet.',
            kind: TextKind.body,
            color: Theme.of(context).colorScheme.onSurface,
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: reviews
                .map((review) => _buildReviewItem(review, context, ref))
                .toList(),
          ),
      ],
    );
  }
}

Widget _buildReviewItem(
  MovieReview review,
  BuildContext context,
  WidgetRef ref,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey.shade800.withOpacity(0.5)
          : Colors.grey.shade200,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              review.userName,
              kind: TextKind.heading,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            Row(
              children: [
                ...List.generate(
                  5,
                  (index) => Icon(
                    index < review.rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 16,
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    _showDeleteReviewDialog(context, ref, review);
                  },
                  child: Icon(
                    Icons.delete_outline,
                    size: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(File(review.imageFilePath), fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 8),
        AppText(review.comment, kind: TextKind.body),
        SizedBox(height: 4),
        AppText(
          '${review.datePosted.day}/${review.datePosted.month}/${review.datePosted.year}',
          kind: TextKind.caption,
          fontSize: 12,
        ),
      ],
    ),
  );
}

void _showDeleteReviewDialog(
  BuildContext context,
  WidgetRef ref,
  MovieReview review,
) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text('Delete Review'),
      content: Text('Are you sure you want to delete this review?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Cancel')),
        TextButton(
          onPressed: () {
            ref
                .read(movieReviewsProvider.notifier)
                .deleteReview(review.movieId, review.id);
            Navigator.pop(ctx);
            CustomSnackbar.show(context, 'Review deleted');
          },
          child: Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}
