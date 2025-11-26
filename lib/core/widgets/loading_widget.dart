import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
      child: Center(
        child: Transform.scale(
          scale: 2,
          child: CupertinoActivityIndicator(color: Colors.black, radius: 2.5.w),
        ),
      ),
    );
  }
}
