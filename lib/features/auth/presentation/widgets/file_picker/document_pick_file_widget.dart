import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flouka_pos/core/helper_function/contact.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/config/app_color.dart';
import '../../../../../core/widgets/svg_widget.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../language/presentation/provider/language_provider.dart';

class DocumentPickFileWidget extends StatelessWidget {
  const DocumentPickFileWidget({
    super.key,
    required this.file,
    required this.label,
    required this.url,
    required this.onFileSelected,
    required this.onFileRemoved,
  });

  final String? url;
  final String label;
  final File? file;
  final void Function(File file) onFileSelected;
  final VoidCallback onFileRemoved;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );
    if (result != null && result.files.single.path != null) {
      onFileSelected(File(result.files.single.path!));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool previewFile = file==null&&url!=null;
    String fileName = file?.path.split('/').last??"";
    Widget filePicker = SizedBox(
      height: 7.h,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 6.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.primaryColor,
              ),
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              child: FittedBox(
                child: Text(
                  previewFile?url!:fileName,
                  style: TextStyleClass.smallStyle(color: Colors.white),
                  maxLines: 1,
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          SizedBox(width: 2.w),
          InkWell(
            onTap: previewFile?(){
              launchLink(url!);
            }:onFileRemoved,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 1.w),
              height: 6.h,
              decoration: BoxDecoration(
                color: previewFile?Colors.green:const Color(0xffAB070A),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgWidget(svg: previewFile?Images.download:Images.deleteFileIcon, color: Colors.white),
            ),
          ),
        ],
      ),
    );
    // if (file == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(LanguageProvider.translate('inputs', label),
              style: TextStyleClass.captionStyle().copyWith(fontWeight: FontWeight.bold)),
          if(url!=null||file!=null)filePicker,
          InkWell(
            onTap: pickFile,
            child: Container(
              width: 4.w,
              height: 4.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColor.primaryColor,
              ),
              alignment: Alignment.center,
              child: SvgWidget(svg: Images.upload, width: 3.w),
            ),
          ),
        ],
      );
    // }
    //
    //
    //
    // return filePicker;
  }
}