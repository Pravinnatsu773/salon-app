import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BackgroundVideoPlayer extends StatefulWidget {
  final String videoUrl;

  BackgroundVideoPlayer({required this.videoUrl});

  @override
  _BackgroundVideoPlayerState createState() => _BackgroundVideoPlayerState();
}

class _BackgroundVideoPlayerState extends State<BackgroundVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(
            () {}); // Ensure the first frame is shown after the video is initialized.
        _controller.play(); // Start the video playback.
        _controller.setLooping(true);
        _controller.setVolume(0); // Loop the video.
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _controller.value.isInitialized
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
