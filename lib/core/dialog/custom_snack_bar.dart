import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'snack_bar.dart';

void errorSnackBar({required String title}) {
  showToast(title);
}

SnackBar snackbar = SnackBar(
  content: Row(
    children: [
      const Icon(Icons.check_circle, color: Colors.white),
      const SizedBox(width: 10),
      const Text('You completed the task!'),
      const Spacer(),
      IconButton(
        icon: const Icon(Icons.close, color: Colors.white),
        onPressed: () {
          ScaffoldMessenger.of(Constants.globalContext()).hideCurrentSnackBar();
        },
      ),
    ],
  ),
  behavior: SnackBarBehavior.floating,
  margin: EdgeInsetsDirectional.only(
    bottom: MediaQuery.of(Constants.globalContext()).size.height - 100,
    start: 10,
    end: MediaQuery.of(Constants.globalContext()).size.width * 0.6,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
    side: const BorderSide(color: Color(0xff155018)),
  ),
  backgroundColor: Colors.green,
);
