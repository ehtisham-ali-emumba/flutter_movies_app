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

final List<Movie> moviesHistory = [
  Movie(
    id: "5",
    title: 'The Grand Budapest Hotel',
    imageUrl:
        "https://cdn.pixabay.com/photo/2020/11/14/15/01/movies-5741015_1280.jpg",
    releaseDate: '2014-03-28',
    description:
        'A whimsical tale set between two world wars, following the adventures of a legendary concierge and his protégé at a famous European hotel.',
    rating: 4.2,
  ),
  Movie(
    id: "6",
    title: 'Schindler\'s List',
    imageUrl:
        "https://cdn.pixabay.com/photo/2015/10/12/14/59/holocaust-memorial-984170_1280.jpg",
    releaseDate: '1993-12-15',
    description:
        'In German-occupied Poland during World War II, Oskar Schindler gradually becomes concerned for his Jewish workforce after witnessing their persecution.',
    rating: 4.9,
  ),
  Movie(
    id: "7",
    title: '1917',
    imageUrl:
        "https://cdn.pixabay.com/photo/2020/06/24/15/30/trenches-5336793_1280.jpg",
    releaseDate: '2019-12-25',
    description:
        'Two British soldiers are given a mission to deliver a message deep in enemy territory that will stop 1,600 men from walking into a trap.',
    rating: 4.6,
  ),
  Movie(
    id: "11",
    title: 'John Wick',
    imageUrl:
        "https://cdn.pixabay.com/photo/2017/03/12/13/41/john-wick-2139253_1280.jpg",
    releaseDate: '2014-10-24',
    description:
        'An ex-hitman comes out of retirement to track down the gangsters that took everything from him.',
    rating: 4.6,
  ),
];

final List<Movie> moviesThriller = [
  Movie(
    id: "8",
    title: 'Inception',
    imageUrl: AppConstants.movieImg,
    releaseDate: '2010-07-16',
    description:
        'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO.',
    rating: 4.5,
  ),
  Movie(
    id: "9",
    title: 'The Dark Knight',
    imageUrl:
        "https://cdn.pixabay.com/photo/2020/04/20/18/10/cinema-5069314_1280.jpg",
    releaseDate: '2008-07-18',
    description:
        'When the menace known as the Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.',
    rating: 4.7,
  ),
  Movie(
    id: "10",
    title: 'Parasite',
    imageUrl:
        "https://cdn.pixabay.com/photo/2017/03/27/14/56/cinema-2178756_1280.jpg",
    releaseDate: '2019-05-30',
    description:
        'Greed and class discrimination threaten the newly formed symbiotic relationship between the wealthy Park family and the destitute Kim clan.',
    rating: 4.9,
  ),
  Movie(
    id: "10",
    title: 'Mad Max: Fury Road',
    imageUrl:
        "https://cdn.pixabay.com/photo/2017/03/27/14/56/cinema-2178756_1280.jpg",
    releaseDate: '2015-05-15',
    description:
        'In a post-apocalyptic wasteland, Max teams up with a mysterious woman to flee from a cult leader and his army.',
    rating: 4.3,
  ),
];
