import 'package:flutter/material.dart';

class IconFadeAnimation extends StatelessWidget {
  final Widget child;
  final int? duration;
  const IconFadeAnimation({super.key, required this.child, this.duration});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: duration ?? 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: child,
    );
  }
}
