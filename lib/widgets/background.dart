import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WeatherVideoBackground extends StatefulWidget {
  final String videoPath;
  const WeatherVideoBackground({required this.videoPath, Key? key})
      : super(key: key);

  @override
  _WeatherVideoBackgroundState createState() => _WeatherVideoBackgroundState();
}

class _WeatherVideoBackgroundState extends State<WeatherVideoBackground> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      );
    } else {
      return Container(); // Placeholder widget while the video is initializing
    }
  }
}
