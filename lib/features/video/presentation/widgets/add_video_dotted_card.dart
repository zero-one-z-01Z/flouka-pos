import 'package:dotted_border/dotted_border.dart';
import 'package:flouka_pos/features/video/presentation/widgets/add_video_dialog.dart';
import 'package:flutter/material.dart';

class AddVideoDottedCard extends StatelessWidget {
  const AddVideoDottedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => const AddVideoDialog(),
        );
      },
      child: DottedBorder(
        options: const RoundedRectDottedBorderOptions(
          radius: const Radius.circular(12),
          dashPattern: const [6, 3],
          strokeWidth: 1.5,
        ),
        child: Container(
          height: 120,
          alignment: Alignment.center,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add, size: 40),
              SizedBox(height: 8),
              Text("Add Video"),
            ],
          ),
        ),
      ),
    );
  }
}
