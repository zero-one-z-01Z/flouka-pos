import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/helper_function/navigation.dart';
import '../../config/app_styles.dart';
import '../../config/app_theme.dart';
import '../../../features/language/presentation/provider/language_provider.dart';
import '../../constants/constants.dart';
import '../../helper_function/helper_function.dart';
import '../../helper_function/loading.dart';
import '../button_widget.dart';
import 'package:image/image.dart' as img;

import '../imgs_preview_widget.dart';

class AddImagePage extends StatefulWidget {
  final bool multiple;
  const AddImagePage({super.key, required this.multiple});

  @override
  State<AddImagePage> createState() => _AddImagePageState();
}

class _AddImagePageState extends State<AddImagePage> {
  CameraController? _controller;
  double _currentZoomLevel = 1.0;
  double _maxZoomLevel = 1.0;
  double _minZoomLevel = 1.0;
  XFile? image;
  bool clicked = false;
  List<XFile> images = [];

  void _save() {
    if (widget.multiple) {
      navPop(images);
    } else {
      loading();
      _controller?.takePicture().then((val) async {
        image = val;
        navPop();
        await delay(50);
        navPop(image);
      });
    }
  }

  void _takeImage() {
    loading();
    _controller?.takePicture().then((val) async {
      final imageFile = File(val.path);

      // Read the image as bytes
      final imageBytes = await imageFile.readAsBytes();

      // Decode the image
      final originalImage = img.decodeImage(imageBytes);

      // Fix the orientation using EXIF data
      final correctedImage = img.bakeOrientation(originalImage!);

      // Save the corrected image back to the file
      final correctedBytes = img.encodeJpg(correctedImage);
      await imageFile.writeAsBytes(correctedBytes);
      await delay(10);
      images.add(XFile(imageFile.path));
      navPop();
      setState(() {});
    });
  }

  void _handleZoom(double scale) async {
    debugPrint(scale.toString());
    num factor = 0.07;
    if (scale > 1) {
      setState(() {
        _currentZoomLevel += (scale * factor);
        if (_currentZoomLevel > _maxZoomLevel) {
          _currentZoomLevel = _maxZoomLevel;
        }
        _controller?.setZoomLevel(_currentZoomLevel);
      });
    } else {
      factor = 0.2;
      if (scale < 0.4) {
        factor = 0.7;
      }
      setState(() {
        _currentZoomLevel -= (scale * factor);
        if (_currentZoomLevel < _minZoomLevel) {
          _currentZoomLevel = _minZoomLevel;
        }
        _controller?.setZoomLevel(_currentZoomLevel);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    // _controller?.dispose();
  }

  Future<void> _toggleCamera() async {
    image = null;
    final cameras = await availableCameras();
    final currentCameraIndex = cameras.indexWhere(
      (c) => c == _controller?.description,
    );
    final nextCameraIndex =
        (currentCameraIndex + 1) % cameras.length;
    final nextCamera = cameras[nextCameraIndex];
    await _controller?.dispose();
    _controller = CameraController(
      nextCamera,
      ResolutionPreset.veryHigh,
    );
    await _controller?.initialize();
    _controller!.getMaxZoomLevel().then((val) {
      if (val < 8) {
        _maxZoomLevel = val;
      } else {
        _maxZoomLevel = 9;
      }
    });
    _controller!.getMinZoomLevel().then((val) {
      _minZoomLevel = val;
    });
    setState(() {});
  }

  // void _setFocusPoint(Offset position, BuildContext context) {
  //   if (_controller == null) return;
  //
  //   final size = MediaQuery.of(context).size;
  //
  //   // Convert screen coordinates to normalized camera coordinates (0 to 1 range)
  //   final focusPoint = Offset(
  //     position.dx / size.width,  // X coordinate normalized
  //     position.dy / size.height, // Y coordinate normalized
  //   );
  //
  //   _controller?.setFocusPoint(focusPoint);
  //   print('hamza');
  //
  //   // Optionally, you can add visual feedback (like a focus rectangle) at this point
  // }
  @override
  void initState() {
    super.initState();

    availableCameras().then((cameras) async {
      _controller = CameraController(
        cameras[0],
        ResolutionPreset.veryHigh,
        enableAudio: false,
      );
      await _controller!.initialize();
      _controller!.getMaxZoomLevel().then((val) {
        if (val < 8) {
          _maxZoomLevel = val;
        } else {
          _maxZoomLevel = 9;
        }
      });
      _controller!.getMinZoomLevel().then((val) {
        _minZoomLevel = val;
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (result, val) {
        _controller?.dispose();
      },
      child: Scaffold(
        body: AnnotatedRegion(
          value: lightBarColor(),
          child: SizedBox(
            width: 100.w,
            height: 100.h,
            child: Stack(
              children: [
                SizedBox(
                  width: 100.w,
                  height: 100.h,
                  child: _controller == null
                      ? const SizedBox()
                      : GestureDetector(
                          onScaleUpdate:
                              (ScaleUpdateDetails details) {
                                _handleZoom(details.scale);
                              },
                          child: AspectRatio(
                            aspectRatio:
                                _controller!.value.aspectRatio,
                            child: CameraPreview(_controller!),
                          ),
                        ),
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
                        color: Theme.of(
                          context,
                        ).colorScheme.primaryFixed,
                        onPressed: () {
                          _controller?.dispose();
                          navPop();
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                        ),
                        child: SizedBox(
                          width: 100.w,
                          height: 9.h,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(images.length, (
                                index,
                              ) {
                                return InkWell(
                                  onTap: () {
                                    navP(
                                      ImagesPreviewWidget(
                                        images: images,
                                        index: index,
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    width: 14.w,
                                    height: 10.h,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          bottom: 0,
                                          // top: 1.h,
                                          child: SizedBox(
                                            width: 12.w,
                                            height: 8.h,
                                            child: AspectRatio(
                                              aspectRatio:
                                                  _controller!
                                                      .value
                                                      .aspectRatio,
                                              child: Image.file(
                                                File(
                                                  images[index]
                                                      .path,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        PositionedDirectional(
                                          top: 0,
                                          start: 0,
                                          child: InkWell(
                                            onTap: () {
                                              images.removeAt(
                                                index,
                                              );
                                              setState(() {});
                                            },
                                            child: Icon(
                                              Icons
                                                  .remove_circle,
                                              color: Colors.red,
                                              size: 4.w,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        // height: 11.h,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(
                            alpha: 0.5,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 2.h,
                        ).add(EdgeInsets.only(bottom: 4.h)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  _toggleCamera();
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.camera_enhance_sharp,
                                      color: Colors.white,
                                      size: Constants.isTablet
                                          ? 40
                                          : 20,
                                    ),
                                    // SizedBox(height: 1.h,),
                                    Text(
                                      LanguageProvider.translate(
                                        'global',
                                        'change_camera',
                                      ),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (widget.multiple)
                                IconButton(
                                  onPressed: () {
                                    _takeImage();
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 8.w,
                                  ),
                                ),
                              if ((widget.multiple &&
                                      images.isNotEmpty) ||
                                  !widget.multiple)
                                ButtonWidget(
                                  onTap: () {
                                    _save();
                                  },
                                  text: 'save',
                                  width: 20.w,
                                  height: 4.5.h,
                                  color: Colors.white,
                                  textStyle:
                                      TextStyleClass.normalStyle().copyWith(
                                        color: Colors.black,
                                      ),
                                  borderRadius: 25,
                                )
                              else
                                SizedBox(width: 20.w),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
