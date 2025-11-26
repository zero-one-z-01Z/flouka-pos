import 'package:flutter/material.dart';

class SlideTransitionWidget extends StatelessWidget {
  final Widget child;
  const SlideTransitionWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      // transitionBuilder: (Widget child, Animation<double> animation) {
      //   return SlideTransition(position: Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(animation), child: child);
      // },
      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
        return Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: const Offset(0, 0),
          ).animate(animation),
          child: child,
        );
      },
      child: child,
    );
  }
}
