import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class ImagePickerField extends StatefulWidget {
  final String label;
  final void Function(File?) onImageSelected;

  const ImagePickerField({
    super.key,
    required this.label,
    required this.onImageSelected,
  });

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showPickOptionsDialog,
      child: Container(
        height: 20.w, // increased height for better image preview
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: selectedImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(selectedImage!, fit: BoxFit.cover),
              )
            : Center(
                child: Text(widget.label, style: TextStyle(fontSize: 10.sp)),
              ),
      ),
    );
  }

  Future<void> showPickOptionsDialog() async {
    final pickedSource = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (pickedSource != null) {
      pickImage(pickedSource);
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      final file = File(image.path);
      setState(() {
        selectedImage = file;
      });
      widget.onImageSelected(file);
    }
  }
}
