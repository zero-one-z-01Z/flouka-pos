
import 'dart:io';

import 'package:video_thumbnail/video_thumbnail.dart';

Future<String?> createVideoCover(String videoPath)async{
  File videoFile = File(videoPath);

  if (videoFile.existsSync()) {
    int fileSizeInBytes = videoFile.lengthSync();
    double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

    print('File Size: ${fileSizeInMB.toStringAsFixed(2)} MB');
  } else {
    print('File not found');
  }
  final thumbnailPath = await VideoThumbnail.thumbnailFile(
    video: File(videoPath).path,
    imageFormat: ImageFormat.JPEG,
    quality: 100,
    maxWidth: 1080,
    maxHeight: 1080,
  );

  return thumbnailPath;
}