import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';
import '../config/app_color.dart';
import '../constants/constants.dart';
import '../../features/language/presentation/provider/language_provider.dart';

class VideoViewPage extends StatefulWidget {
  final dynamic video;
  const VideoViewPage({required this.video, super.key});

  @override
  State<VideoViewPage> createState() => _VideoViewPageState();
}

class _VideoViewPageState extends State<VideoViewPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    if (widget.video is String) {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.video),
      );
    } else {
      _controller = VideoPlayerController.file(widget.video);
    }

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(false);

    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }


  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_controller.value.isPlaying) {
          _controller.pause();
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(LanguageProvider.translate('global', 'video')),
        ),
        body: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Container(
                  width: 50.w,height: 50.w,
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.primaryColor,
          onPressed: () {
            setState(() {
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                _controller.play();
              }
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            size: 2.w,
          ),
        ),
      ),
    );
  }
}