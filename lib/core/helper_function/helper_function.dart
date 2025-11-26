import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart';

Future delay(int milliseconds) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(
    data.buffer.asUint8List(),
    targetWidth: width,
  );
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(
    format: ui.ImageByteFormat.png,
  ))!.buffer.asUint8List();
}

Color hexToColor(String hex) {
  hex = hex.replaceAll('#', '');
  if (hex.length == 6) {
    hex = 'FF$hex'; // add alpha value
  }
  return Color(int.parse(hex, radix: 16));
}

String? getKeyByValue(Map map, dynamic value) {
  for (var entry in map.entries) {
    if (entry.value == value) {
      return entry.key;
    }
  }
  return null;
}

Future<String> getDownloadPath(String name) async {
  Directory? appDocDir = await getApplicationDocumentsDirectory();
  // String appDocPath = appDocDir.path;

  if (Platform.isAndroid) {
    appDocDir =
        await getExternalStorageDirectory(); // External storage directory (Android)
  } else if (Platform.isIOS) {
    appDocDir = await getApplicationDocumentsDirectory(); // iOS documents directory
  }
  String appDocPath = appDocDir!.path;
  return '$appDocPath/$name'; // Change file name as necessary
}

// Future shareMarket({required String url})async{
//   final box = Constants.globalContext().findRenderObject() as RenderBox?;
//   await Share.share(url,
//     sharePositionOrigin: Constants.isTablet?
//     (box!.localToGlobal(Offset.zero) & box.size):null,);
// }
