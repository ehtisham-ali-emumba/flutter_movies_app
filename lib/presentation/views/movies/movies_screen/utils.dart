import 'package:movies/core/constants/app_constants.dart' show AppConstants;
import 'package:movies/data/models/movie.dart';

final List<Movie> movies = [
  Movie(
    id: "1",
    title: 'Inception',
    imageUrl: AppConstants.movieImg,
    releaseDate: '2010-07-16',
    description:
        'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO.',
    rating: 4.5,
  ),
  Movie(
    id: "2",
    title: 'The Dark Knight',
    imageUrl:
        "https://cdn.pixabay.com/photo/2020/04/20/18/10/cinema-5069314_1280.jpg",
    releaseDate: '2008-07-18',
    description:
        'When the menace known as the Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.',
    rating: 4.7,
  ),
  Movie(
    id: "3",
    title: 'Interstellar',
    imageUrl:
        "https://cdn.pixabay.com/photo/2012/11/04/08/23/cinema-strip-64074_1280.jpg",
    releaseDate: '2014-11-07',
    description:
        'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.',
    rating: 4.6,
  ),
  Movie(
    id: "4",
    title: 'The Matrix',
    imageUrl:
        "https://cdn.pixabay.com/photo/2016/10/04/08/58/theater-1713816_1280.jpg",
    releaseDate: '1999-03-31',
    description:
        'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.',
    rating: 4.8,
  ),
];
