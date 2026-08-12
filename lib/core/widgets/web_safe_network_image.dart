import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

/// Network image that works on Flutter web even when the CDN has no CORS
/// headers (CanvasKit can't decode those; HTML `<img>` can still display them).
class WebSafeNetworkImage extends StatelessWidget {
  const WebSafeNetworkImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  final String url;
  final BoxFit fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return SizedBox(width: width, height: height);
    }
    if (kIsWeb) {
      return Image.network(
        url,
        fit: fit,
        width: width,
        height: height,
        webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
        errorBuilder: (_, __, ___) => SizedBox(width: width, height: height),
      );
    }
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      width: width,
      height: height,
      errorWidget: (_, __, ___) => SizedBox(width: width, height: height),
    );
  }
}

/// [ImageProvider] for [DecorationImage] — on web uses [NetworkImage]
/// (still CanvasKit-limited for decoration; prefer [WebSafeNetworkImage] widget).
ImageProvider webSafeImageProvider(String url) {
  if (kIsWeb) return NetworkImage(url);
  return CachedNetworkImageProvider(url);
}
