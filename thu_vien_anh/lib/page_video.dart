import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key, required this.asset});
  final AssetEntity asset;


  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late final VideoPlayerController _videoPlayerController;
  late final ChewieController _chewieController;
  late final Chewie videoPlayerWidget;
  bool initialized = false;

  _initVideo() async{
    final Future<File?> videoFile = widget.asset.file;
    final video = await videoFile;
    _videoPlayerController = VideoPlayerController.file(video!)
      ..setLooping(true)
      ..initialize().then(
            (value) => setState(
              () => initialized = true,
        ),
      );
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
    );
    videoPlayerWidget = Chewie(
      controller: _chewieController,
    );
  }


  @override
  void initState() {
    _initVideo();
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.asset.title!),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: initialized ? Scaffold(
        body: Center(
          child: AspectRatio(
            aspectRatio: _videoPlayerController.value.aspectRatio,
            child: videoPlayerWidget,
          ),
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );;
  }
}