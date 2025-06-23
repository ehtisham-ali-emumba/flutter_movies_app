import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/presentation/widgets/base_carousel.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  final List<Map<String, dynamic>> movies = const [
    {
      'title': 'Inception',
      'year': 2010,
      'rating': 8.8,
      'image': AppConstants.movieImg,
    },
    {
      'title': 'The Dark Knight',
      'year': 2008,
      'rating': 9.0,
      'image': AppConstants.movieImg,
    },
    {
      'title': 'Interstellar',
      'year': 2014,
      'rating': 8.6,
      'image': AppConstants.movieImg,
    },
    {
      'title': 'Pulp Fiction',
      'year': 1994,
      'rating': 8.9,
      'image': AppConstants.movieImg,
    },
    {
      'title': 'The Matrix',
      'year': 1999,
      'rating': 8.7,
      'image': AppConstants.movieImg,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30),
          // Title

          // CAROUSEL SLIDER - This is the main part!
          BaseCarousel(
            controller: _carouselController,
            options: CarouselOptions(
              height: 400, // Height of carousel
              enlargeCenterPage: true, // Makes center card bigger
              enlargeFactor: 0.3, // How much bigger (0.1 to 1.0)
              autoPlay: true, // Auto scroll
              autoPlayInterval: Duration(seconds: 4), // Time between slides
              autoPlayAnimationDuration: Duration(
                milliseconds: 800,
              ), // Animation speed
              pauseAutoPlayOnTouch: true, // Pause when user touches
              aspectRatio: 16 / 9, // Card proportions
              viewportFraction: 0.8, // How much of screen each card takes
              enableInfiniteScroll: true, // Loop back to start
            ),
            items: movies.map((movie) {
              return MovieCard(movie: movie);
            }).toList(),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Map<String, dynamic> movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            // Movie Poster
            Image.network(
              movie['image'],
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[800],
                  child: Icon(Icons.movie, size: 50, color: Colors.white),
                );
              },
            ),

            // Dark overlay for text readability
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                ),
              ),
            ),

            // Movie Info at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie['title'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '${movie['year']}',
                          style: TextStyle(color: Colors.grey[300]),
                        ),
                        SizedBox(width: 15),
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '${movie['rating']}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
