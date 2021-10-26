import 'package:bsflutter/home_page/home/Widget/card_post.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  const Video({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<StatefulWidget> createState() {
    return _Video();
  }
}

class _Video extends State<Video> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.pause();
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _videoPlayerController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController))
            : Container(
                height: 50.0,
                color: Colors.transparent,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  _videoPlayerController.pause();
                },
                child: const Icon(Icons.pause)),
            const Padding(padding: EdgeInsets.all(2)),
            ElevatedButton(
                onPressed: () {
                  _videoPlayerController.play();
                },
                child: const Icon(Icons.play_arrow))
          ],
        )
      ],
    );
  }
}
