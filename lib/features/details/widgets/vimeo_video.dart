import 'package:flutter/material.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

class VimeoVideo extends StatelessWidget {
  const VimeoVideo({super.key, required this.videoId});
  final String videoId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Watch Video")),
      body: VimeoPlayer(
        videoId: videoId,
      ),
    );
  }
}
