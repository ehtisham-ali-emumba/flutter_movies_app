import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class AppVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool autoPlay;
  final bool showControls;

  const AppVideoPlayer({
    super.key,
    required this.videoUrl,
    this.autoPlay = true,
    this.showControls = true,
  });

  @override
  State<AppVideoPlayer> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer>
    with WidgetsBindingObserver {
  late VideoPlayerController _controller;
  bool _showControls = true;
  bool _isFullscreen = false;
  bool _isMuted = false;
  double _volume = 1.0;
  Timer? _hideTimer;
  bool _isLoading = true;
  bool _hasError = false;
  bool _wasPlayingBeforePause = false;

  @override
  void initState() {
    super.initState();
    // Register as an observer for app lifecycle changes
    WidgetsBinding.instance.addObserver(this);
    _initializeVideo(widget.videoUrl);
  }

  @override
  void didUpdateWidget(AppVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle video URL change
    if (oldWidget.videoUrl != widget.videoUrl) {
      // Reset video state
      _clearVideoState();

      // Initialize the new video
      _initializeVideo(widget.videoUrl);
    }

    // Handle control visibility and autoplay changes
    if (oldWidget.showControls != widget.showControls) {
      setState(() {
        _showControls = widget.showControls;
      });
    }
  }

  /// Clears all video state and cleans up resources
  void _clearVideoState() {
    // Stop any timers
    _hideTimer?.cancel();

    // Clean up existing video controller
    _controller.removeListener(_videoListener);
    if (_controller.value.isPlaying) {
      _controller.pause();
    }
    _controller.dispose();

    // Reset state flags (but don't trigger setState here since _initializeVideo will do that)
    _wasPlayingBeforePause = false;
  }

  Future<void> _initializeVideo(String url) async {
    // Reset state
    setState(() {
      _isLoading = true;
      _hasError = false;
      _showControls = true; // Reset controls visibility
      // Don't reset fullscreen state here as it would cause UI flicker
    });

    // Cancel any hide timers
    _hideTimer?.cancel();

    try {
      // Create and initialize the new controller
      _controller = VideoPlayerController.network(url);

      // Configure the controller
      _controller.addListener(_videoListener);
      _controller.setVolume(_volume);

      // Initialize the controller
      await _controller.initialize();

      // Update state after successful initialization if widget is still mounted
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        // Auto-play if enabled
        if (widget.autoPlay && mounted) {
          _controller.play();
          _startHideTimer();
        }
      }
    } catch (error) {
      // Handle initialization errors
      if (mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
        debugPrint('Video initialization error: $error');
      }
    }
  }

  void _videoListener() {
    // Only process events if the widget is still mounted
    if (!mounted) return;

    // Handle video completion
    if (_controller.value.position >=
        _controller.value.duration - const Duration(milliseconds: 300)) {
      // Video is at the end - handle completion
      _controller.pause();

      // Reset to beginning if you want to enable looping
      // _controller.seekTo(Duration.zero);
    }

    // Update UI to reflect current state
    setState(() {});
  }

  void _startHideTimer() {
    if (!widget.showControls) return;
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 4), () {
      if (mounted && !_isFullscreen) setState(() => _showControls = false);
    });
  }

  void _onTapVideo() {
    if (!widget.showControls) return;
    setState(() {
      _showControls = !_showControls;
      if (_showControls) _startHideTimer();
    });
  }

  void _onPlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
      _startHideTimer();
    }
    setState(() {});
  }

  void _onSeek(double value) {
    _controller.seekTo(Duration(seconds: value.toInt()));
    setState(() {});
  }

  void _onSkip(int seconds) {
    final newPosition = _controller.value.position + Duration(seconds: seconds);
    final videoDuration = _controller.value.duration;

    if (newPosition < Duration.zero) {
      _controller.seekTo(Duration.zero);
    } else if (newPosition > videoDuration) {
      _controller.seekTo(videoDuration);
    } else {
      _controller.seekTo(newPosition);
    }

    setState(() {});
  }

  void _onVolumeChanged(double value) {
    _volume = value;
    _controller.setVolume(_volume);
    setState(() {
      _isMuted = _volume == 0;
    });
  }

  void _onMuteToggle() {
    if (_isMuted) {
      _volume = 1.0;
      _controller.setVolume(_volume);
    } else {
      _volume = 0.0;
      _controller.setVolume(_volume);
    }
    setState(() {
      _isMuted = !_isMuted;
    });
  }

  Future<void> _enterFullscreen() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    setState(() => _isFullscreen = true);
  }

  Future<void> _exitFullscreen() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    setState(() => _isFullscreen = false);
  }

  @override
  void dispose() {
    // Exit fullscreen mode if active when widget is disposed
    if (_isFullscreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }

    // Cancel any pending timers
    _hideTimer?.cancel();

    // Clean up video controller
    if (_controller.value.isPlaying) {
      _controller.pause();
    }
    _controller.removeListener(_videoListener);
    _controller.dispose();

    // Remove observer
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Handle app lifecycle changes
    if (state == AppLifecycleState.paused) {
      // App is in the background
      _wasPlayingBeforePause = _controller.value.isPlaying;
      if (_wasPlayingBeforePause) {
        _controller.pause();
      }
    } else if (state == AppLifecycleState.resumed) {
      // App is in the foreground
      if (_wasPlayingBeforePause) {
        _controller.play();
      }
    }
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "${d.inHours > 0 ? '${twoDigits(d.inHours)}:' : ''}$minutes:$seconds";
  }

  Widget _buildControlsOverlay() {
    final isPlaying = _controller.value.isPlaying;
    final position = _controller.value.position;
    final duration = _controller.value.duration;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.7),
            Colors.black.withOpacity(0.0),
            Colors.black.withOpacity(0.7),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_isFullscreen)
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: _exitFullscreen,
                ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  _isMuted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                ),
                onPressed: _onMuteToggle,
              ),
              SizedBox(
                width: 100,
                child: Slider(
                  value: _volume,
                  min: 0,
                  max: 1,
                  onChanged: _onVolumeChanged,
                  activeColor: Colors.white,
                  inactiveColor: Colors.white24,
                ),
              ),
            ],
          ),

          // Center play/pause
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 40,
                  icon: const Icon(Icons.replay_10, color: Colors.white),
                  onPressed: () => _onSkip(-10),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: _onPlayPause,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  iconSize: 40,
                  icon: const Icon(Icons.forward_10, color: Colors.white),
                  onPressed: () => _onSkip(10),
                ),
              ],
            ),
          ),

          // Bottom bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                Text(
                  _formatDuration(position),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                Expanded(
                  child: Slider(
                    value: position.inSeconds.toDouble().clamp(
                      0,
                      duration.inSeconds.toDouble(),
                    ),
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                    onChanged: (value) => _onSeek(value),
                    activeColor: Colors.redAccent,
                    inactiveColor: Colors.white24,
                  ),
                ),
                Text(
                  _formatDuration(duration),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                IconButton(
                  icon: Icon(
                    _isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                    color: Colors.white,
                  ),
                  onPressed: _isFullscreen ? _exitFullscreen : _enterFullscreen,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return const Center(
        child: Text(
          "Failed to load video",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    if (_isLoading || !_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return GestureDetector(
      onTap: _onTapVideo,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          if (widget.showControls)
            AnimatedOpacity(
              opacity: _showControls ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: _buildControlsOverlay(),
            ),
        ],
      ),
    );
  }
}
