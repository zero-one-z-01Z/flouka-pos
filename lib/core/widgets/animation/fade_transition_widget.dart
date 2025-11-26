import 'package:flutter/material.dart';

class FadeTransitionWidget extends StatelessWidget {
  final Widget child;
  final int? durationMilliSec;
  const FadeTransitionWidget({
    super.key,
    required this.child,
    this.durationMilliSec,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: durationMilliSec ?? 700),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [...previousChildren, if (currentChild != null) currentChild],
        );
      },
      child: child,
    );
  }
}
