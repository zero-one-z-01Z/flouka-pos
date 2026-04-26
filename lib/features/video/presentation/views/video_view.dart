import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/video_provider.dart';
import '../widgets/add_video_dotted_card.dart';
import '../widgets/video_item_widget.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Videos")),
      body: Consumer<VideoProvider>(
        builder: (context, provider, _) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.videos.length + 1,
            itemBuilder: (context, index) {
              if (index < provider.videos.length) {
                return VideoItemWidget(video: provider.videos[index]);
              }
              return const AddVideoDottedCard();
            },
          );
        },
      ),
    );
  }
}
