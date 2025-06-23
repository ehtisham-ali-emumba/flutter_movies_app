import 'package:flutter/material.dart';
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/presentation/widgets/text.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;
  const MovieDetailsScreen({super.key, required this.movie});

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
                    tag: movie.id,
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Movie poster thumbnail

                        // Title and info section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              movie.title,
                              kind: TextKind.heading,
                              fontSize: 26,
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                AppText(
                                  movie.releaseDate,
                                  kind: TextKind.caption,
                                ),
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
                                (index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                    AppText('Reviews', kind: TextKind.heading, fontSize: 20),
                    SizedBox(height: 12),
                    // Add your review widgets here
                    AppText(
                      'No reviews yet.',
                      kind: TextKind.body,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dot() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6),
    child: Text('•', style: TextStyle(color: Colors.white)),
  );

  TextStyle _metaTextStyle() => TextStyle(color: Colors.white70, fontSize: 13);

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
}
