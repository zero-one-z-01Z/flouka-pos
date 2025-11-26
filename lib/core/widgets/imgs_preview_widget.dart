
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';
import '../helper_function/navigation.dart';

class ImagesPreviewWidget extends StatelessWidget {
  final List<dynamic> images;
  final int? index;
  const ImagesPreviewWidget({required this.images, this.index, super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // backgroundColor: Colors.black,
      //   leading: BackButtonWidget(),
      //   title: SizedBox(),
      // ),
      body: SizedBox(
        width: 100.w,
        height: 100.h,

        child: Stack(
          children: [
            PageView(
              controller: PageController(initialPage: index ?? 0),
              children: List.generate(images.length, (index) {
                return PinchZoom(
                  maxScale: 2.5,
                  child: Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(images[index].image),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              }),
            ),
            PositionedDirectional(
              top: 8.h,
              start: 3.w,
              child: Container(
                margin: EdgeInsets.all(1.5.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withValues(alpha: 0.3),
                ),
                child: Transform.scale(
                  scale: Constants.isTablet ? 2 : 1,
                  child: BackButton(
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      navPop();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
