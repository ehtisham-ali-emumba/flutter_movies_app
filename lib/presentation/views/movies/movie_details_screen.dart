import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/data/models/movie_review.dart';
import 'package:movies/presentation/view_models/movies/movie_reviews_provider.dart';
import 'package:movies/presentation/view_models/movies/movies_favorite_provider.dart';
import 'package:movies/presentation/views/movies/add_rate_movie_screen.dart';
import 'package:movies/presentation/widgets/text.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;
  final String heroId;

  const MovieDetailsScreen({
    super.key,
    required this.movie,
    required this.heroId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Hero(
                    tag: heroId,
                    child: Image.network(
                      movie.imageUrl,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Dark transparent overlay
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.4),
                          Color.fromRGBO(0, 0, 0, 0.6),
                        ],
                      ),
                    ),
                  ),

                  // Play icon
                  Icon(
                    Icons.play_circle_fill,
                    color: Theme.of(context).colorScheme.primary,
                    size: 64,
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: CircleAvatar(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHigh,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Movie poster and title section
                    movieDetails(),
                    SizedBox(height: 12),
                    AppText(movie.description, kind: TextKind.body),
                    SizedBox(height: 24),
                    AppText('Star Cast', kind: TextKind.heading, fontSize: 20),
                    SizedBox(height: 12),

                    SizedBox(
                      height: 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _actorCard('Lee Jung Jae', AppConstants.catAvatar),
                          _actorCard('Park Hae Soo', AppConstants.catAvatar),
                          _actorCard('Park Hae Soo', AppConstants.catAvatar),
                          _actorCard('Jung Ho Yeon', AppConstants.catAvatar),
                          _actorCard('Jung Ho Yeon', AppConstants.catAvatar),
                          _actorCard('Jung Ho Yeon', AppConstants.catAvatar),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),
                    _buildReviewsSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget movieDetails() {
    return Consumer(
      builder: (context, ref, child) {
        final isFavorite = ref
            .watch(favoritesProvider)
            .isFavoriteMovie(movie.id);

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    movie.title,
                    kind: TextKind.heading,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      AppText(movie.releaseDate, kind: TextKind.caption),
                      _dot(),
                      AppText('18+', kind: TextKind.caption),
                      _dot(),
                      AppText('TV Drama', kind: TextKind.caption),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: List.generate(
                      5,
                      (index) =>
                          Icon(Icons.star, color: Colors.amber, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 50,
              child: IconButton(
                onPressed: () async {
                  ref.read(favoritesProvider.notifier).toggleFavorite(movie);
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_outline,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _dot() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6),
    child: Text('•', style: TextStyle(color: Colors.white)),
  );

  Widget _actorCard(String name, String imagePath) {
    return Container(
      width: 80,
      margin: EdgeInsets.only(right: 12),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imagePath,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Consumer(
      builder: (context, ref, child) {
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
      },
    );
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
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(movieReviewsProvider.notifier)
                  .deleteReview(review.movieId, review.id);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Review deleted')));
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
