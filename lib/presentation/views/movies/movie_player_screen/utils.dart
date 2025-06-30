import 'package:movies/data/models/episode.dart';

final dummyEpisodes = [
  Episode(
    title: "Big Buck Bunny",
    description: "A giant rabbit takes a stand against bullying.",
    thumbnailUrl:
        "https://peach.blender.org/wp-content/uploads/title_anouncement.jpg?x11217",
    videoUrl:
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    duration: const Duration(minutes: 9, seconds: 56),
    isPlaying: true,
  ),
  Episode(
    title: "Elephant Dream",
    description: "The first Blender Open Movie from 2006.",
    thumbnailUrl:
        "https://upload.wikimedia.org/wikipedia/commons/9/90/Elephants_Dream_s1_proog.jpg",
    videoUrl:
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    duration: const Duration(minutes: 10, seconds: 53),
  ),
  Episode(
    title: "For Bigger Blazes",
    description: "A short video for testing streaming.",
    thumbnailUrl:
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg",
    videoUrl:
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    duration: const Duration(minutes: 0, seconds: 15),
  ),
];
