import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:video_player/video_player.dart';

class VideoContainer extends StatefulWidget {
  final String videoUrl;

  const VideoContainer({super.key, required this.videoUrl});

  @override
  State<VideoContainer> createState() => _VideoContainerState();
}

class _VideoContainerState extends State<VideoContainer> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _showControls = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          _isPlaying = true;
        });
      });

    _controller.addListener(() {
      if (_controller.value.isPlaying &&
          _controller.value.position == _controller.value.duration) {
        Future.delayed(const Duration(milliseconds: 200), () {
          _controller.seekTo(Duration.zero);
          setState(() {
            _isPlaying = false;
            _showControls = true;
          });
        });
      } else {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      _controller.play();

      setState(() {
        _isPlaying = true;
      });
    }
  }

  void _toggleShowControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  String _formatDuration(Duration duration) {
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _toggleShowControls();
      },
      // onLongPressStart: (_) {
      //   _toggleShowControls();
      // },
      // onLongPressEnd: (_) {
      //   _toggleShowControls();
      // },
      child: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : const CircularProgressIndicator(
                    color: kBlue1Color,
                  ),
          ),
          if (_showControls)
            Positioned.fill(
              child: AnimatedOpacity(
                opacity: _showControls ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: GestureDetector(
                  onTap: () {
                    _togglePlayPause();
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Center(
                      child: Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          color: kBlackColor.withOpacity(.4),
                          shape: BoxShape.circle,
                        ),
                        alignment:Alignment.center,
                        child: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 46,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (_showControls)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(_controller.value.position),
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        _formatDuration(_controller.value.duration),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Slider(
                    value: _controller.value.position.inMilliseconds.toDouble(),
                    min: 0.0,
                    activeColor: kBlue1Color,
                    inactiveColor: k2ndColor,
                    max: _controller.value.duration.inMilliseconds.toDouble() +
                        1,
                    onChanged: (value) {
                      _controller.seekTo(Duration(milliseconds: value.toInt()));
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
