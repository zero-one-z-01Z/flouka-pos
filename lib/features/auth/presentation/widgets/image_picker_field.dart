import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class ImagePickerField extends StatefulWidget {
  final String label;
  final void Function(File?) onImageSelected;

  const ImagePickerField({super.key, required this.label, required this.onImageSelected});

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickImage,
      child: Container(
        height: 4.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: selectedImage != null
            ? Image.file(selectedImage!, fit: BoxFit.cover)
            : Center(
                child: Text(widget.label, style: TextStyle(fontSize: 10.sp)),
              ),
      ),
    );
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final file = File(image.path);
      setState(() {
        selectedImage = file;
      });
      widget.onImageSelected(file);
    }
  }
}
