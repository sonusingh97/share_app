import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerProvider extends ChangeNotifier {
  VideoPlayerController? _controller;

  VideoPlayerController? get controller => _controller;

  void initializeVideo(String assetPath) {
    _controller = VideoPlayerController.asset(assetPath)
      ..initialize().then((_) {
        _controller?.play();
        notifyListeners(); // Notify listeners to rebuild UI
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
