import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/video_provider.dart';

class AddVideoDialog extends StatefulWidget {
  const AddVideoDialog({super.key});

  @override
  State<AddVideoDialog> createState() => _AddVideoDialogState();
}

class _AddVideoDialogState extends State<AddVideoDialog> {
  final TextEditingController descriptionController = TextEditingController();
  String selectedType = "Product";
  File? selectedVideo;

  Future<void> pickVideo() async {
    final picker = ImagePicker();
    final picked = await picker.pickVideo(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        selectedVideo = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Upload Video"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: pickVideo,
              child: const Text("Choose Video"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              decoration:
                  const InputDecoration(labelText: "Video Description"),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedType,
              items: const [
                DropdownMenuItem(value: "Product", child: Text("Product")),
                DropdownMenuItem(value: "Promo", child: Text("Promo")),
                DropdownMenuItem(value: "Tutorial", child: Text("Tutorial")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedType = value!;
                });
              },
              decoration: const InputDecoration(labelText: "Video Type"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: selectedVideo == null
              ? null
              : () {
                  context.read<VideoProvider>().addVideo(
                        path: selectedVideo!.path,
                        description: descriptionController.text,
                        type: selectedType,
                      );
                  Navigator.pop(context);
                },
          child: const Text("Publish Video"),
        ),
      ],
    );
  }
}
