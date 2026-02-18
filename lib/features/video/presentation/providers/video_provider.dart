import 'package:flouka_pos/features/video/domain/entities/video_entity.dart';
import 'package:flutter/material.dart';

class VideoProvider extends ChangeNotifier {
  final List<VideoEntity> _videos = [];

  List<VideoEntity> get videos => _videos;

  void addVideo({
    required String path,
    required String description,
    required String type,
  }) {
    final video = VideoEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      path: path,
      description: description,
      type: type,
    );

    _videos.add(video);
    notifyListeners();
  }
}
