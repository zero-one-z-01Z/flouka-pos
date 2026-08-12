import 'package:flutter/foundation.dart' show Factory, kIsWeb;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// [GoogleMap] crashes on Flutter web when the Maps JS SDK is missing
/// (`MapTypeId` undefined). Use this wrapper for Chrome/local preview.
class WebSafeGoogleMap extends StatelessWidget {
  const WebSafeGoogleMap({
    super.key,
    required this.initialCameraPosition,
    this.onMapCreated,
    this.onCameraMove,
    this.onCameraIdle,
    this.myLocationEnabled = false,
    this.myLocationButtonEnabled = false,
    this.markers = const <Marker>{},
    this.gestureRecognizers = const <Factory<OneSequenceGestureRecognizer>>{},
    this.webPlaceholderLabel,
  });

  final CameraPosition initialCameraPosition;
  final MapCreatedCallback? onMapCreated;
  final CameraPositionCallback? onCameraMove;
  final VoidCallback? onCameraIdle;
  final bool myLocationEnabled;
  final bool myLocationButtonEnabled;
  final Set<Marker> markers;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;
  final String? webPlaceholderLabel;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      final t = initialCameraPosition.target;
      return ColoredBox(
        color: const Color(0xFFE8EEF5),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_on, color: Colors.red, size: 40),
              const SizedBox(height: 8),
              Text(
                webPlaceholderLabel ??
                    'Map preview unavailable on web\n'
                        'Using Tunis default (${t.latitude.toStringAsFixed(4)}, '
                        '${t.longitude.toStringAsFixed(4)})',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blueGrey.shade700,
                  fontSize: 13,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
      onMapCreated: onMapCreated,
      onCameraMove: onCameraMove,
      onCameraIdle: onCameraIdle,
      myLocationEnabled: myLocationEnabled,
      myLocationButtonEnabled: myLocationButtonEnabled,
      markers: markers,
      gestureRecognizers: gestureRecognizers,
    );
  }
}
