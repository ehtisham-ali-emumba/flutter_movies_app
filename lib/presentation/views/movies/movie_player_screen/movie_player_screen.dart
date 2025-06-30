import 'package:flutter/material.dart';
import 'package:movies/data/models/episode.dart';
import 'package:movies/presentation/views/movies/movie_player_screen/utils.dart';
import 'package:movies/presentation/widgets/text.dart';
import 'package:movies/presentation/widgets/video_player.dart';

class MoviePlayerScreen extends StatefulWidget {
  const MoviePlayerScreen({super.key});

  @override
  State<MoviePlayerScreen> createState() => _MoviePlayerScreenState();
}

class _MoviePlayerScreenState extends State<MoviePlayerScreen> {
  late List<Episode> episodes;
  int _currentEpisodeIndex = 0;
  final bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    episodes = dummyEpisodes;
    // Initialize the first episode as playing
    episodes[_currentEpisodeIndex].isPlaying = true;
  }

  void _onEpisodeTap(int index) {
    if (_currentEpisodeIndex == index) return;

    // Update episode playing status
    for (var i = 0; i < episodes.length; i++) {
      episodes[i].isPlaying = i == index;
    }

    // Update the current episode index and trigger rebuild
    _currentEpisodeIndex = index;
    setState(() {});
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "${d.inHours > 0 ? '${twoDigits(d.inHours)}:' : ''}$minutes:$seconds";
  }

  Widget _buildEpisodeCard(Episode episode, int index) {
    final isActive = index == _currentEpisodeIndex && episode.isPlaying;
    return GestureDetector(
      onTap: () => _onEpisodeTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isActive
              ? Color.fromRGBO(255, 0, 0, 0.1)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: isActive
              ? Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 3,
                )
              : Border.all(color: Colors.grey.shade200, width: 0.3),
          boxShadow: [
            if (isActive)
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: Image.network(
                    episode.thumbnailUrl,
                    width: 100,
                    height: 82,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      _formatDuration(episode.duration),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
                if (isActive)
                  Positioned(
                    top: 4,
                    left: 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      width: 10,
                      height: 10,
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      episode.title,
                      kind: TextKind.heading,
                      fontSize: 17,
                    ),
                    const SizedBox(height: 4),
                    AppText(
                      episode.description,
                      kind: TextKind.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 14,
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

  @override
  Widget build(BuildContext context) {
    final videoHeight = _isFullscreen
        ? MediaQuery.of(context).size.height
        : MediaQuery.of(context).size.width * 9 / 16;

    return Scaffold(
      appBar: AppBar(title: AppText("Big Buck Bunny")),
      body: SafeArea(
        child: _isFullscreen
            ? Center(
                child: AppVideoPlayer(
                  videoUrl: episodes[_currentEpisodeIndex].videoUrl,
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: videoHeight,
                    child: AppVideoPlayer(
                      videoUrl: episodes[_currentEpisodeIndex].videoUrl,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: episodes.length,
                      itemBuilder: (context, index) =>
                          _buildEpisodeCard(episodes[index], index),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
