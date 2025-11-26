import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../features/language/presentation/provider/language_provider.dart';
import '../config/app_styles.dart';
import '../constants/app_images.dart';
import '../helper_function/helper_function.dart';

class DraggableImageButton extends StatefulWidget {
  const DraggableImageButton({super.key, required this.onComplete});

  final VoidCallback onComplete;

  @override
  State<DraggableImageButton> createState() => _DraggableImageButtonState();
}

class _DraggableImageButtonState extends State<DraggableImageButton> {
  double posX = 20;
  bool completed = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double maxX = screenWidth - 100;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            alignment: Alignment.center,
            width: 90.w,
            height: 6.h,
            decoration: BoxDecoration(
              color: completed ? Colors.green : const Color(0xffB4B4B4),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              LanguageProvider.translate("buttons", "PAY NOW"),
              style: TextStyleClass.normalStyle().copyWith(color: Colors.white),
            ),
          ),

          Positioned(
            left: posX,
            top: 1.2.h,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) async {
                setState(() {
                  posX += details.delta.dx;
                  if (posX < 20) posX = 20;
                  if (posX > maxX) posX = maxX;
                  if (posX >= maxX) {
                    completed = true;
                  }
                  if (posX < maxX - 20) {
                    completed = false;
                  }
                });
              },
              onHorizontalDragEnd: (details) async {
                await delay(100);
                if (completed) {
                  widget.onComplete();
                }
                await delay(500);
                setState(() {
                  posX = 20;
                  completed = false;
                });
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),

                child: completed
                    ? Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          key: const ValueKey("check"),
                          size: 23.sp,
                          color: Colors.green,
                        ),
                      )
                    : Image.asset(
                        Images.arrowRight,
                        key: const ValueKey("arrow"),
                        width: 23.sp,
                        height: 23.sp,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
