import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/helper_function/navigation.dart';
import '../../config/app_styles.dart';
import '../../config/app_theme.dart';
import '../../../features/language/presentation/provider/language_provider.dart';
import '../../constants/constants.dart';
import '../../helper_function/convert.dart';
import '../../helper_function/helper_function.dart';
import '../button_widget.dart';

class AddVideoPage extends StatefulWidget {
  const AddVideoPage({super.key});

  @override
  State<AddVideoPage> createState() => _AddVideoPageState();
}

class _AddVideoPageState extends State<AddVideoPage> {
  CameraController? _controller;
  int record = 0; // 0 = init 1 = record 2 = stop 3 = finish
  XFile? video;
  bool clicked = false;
  double _currentZoomLevel = 1.0;
  double _maxZoomLevel = 1.0;
  double _minZoomLevel = 1.0;
  // late int _secondsRemaining;
  int sec = 0;
  late int minute;
  // CountDownController countDownController = CountDownController();
  Timer? _timer;
  void _startRecording() {
    _controller?.startVideoRecording().then((value) {
      // _secondsRemaining = minute*60;
      record = 1;
      setState(() {});
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (sec < minute * 60) {
          if (mounted) {
            sec++;
            setState(() {});
          } else {
            _timer?.cancel();
          }
        } else {
          record = 3;
          // countDownController.pause();
          await delay(100);
          _pause();
        }
      });
    });
  }

  void _send() {
    try {
      _timer?.cancel();
      _controller?.stopVideoRecording().then((file) async {
        await delay(100);
        navPop(file);
      });
    } catch (e) {
      debugPrint('e');
    }
  }

  void _pause() {
    try {
      _timer?.cancel();
      _controller?.pauseVideoRecording().then((value) {
        setState(() {});
      });
    } catch (e) {
      debugPrint('e');
    }
  }

  void _resume() {
    try {
      _timer?.cancel();
      _controller?.resumeVideoRecording().then((value) {
        record = 1;
        setState(() {});
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
          if (sec < minute * 60) {
            if (mounted) {
              sec++;
              setState(() {});
            } else {
              _timer?.cancel();
            }
          } else {
            record = 3;
            // countDownController.pause();
            await delay(100);
            _pause();
          }
        });
      });
    } catch (e) {
      debugPrint('e');
    }
  }

  void _reset() {
    if (!clicked) {
      clicked = true;
      try {
        _timer?.cancel();

        _controller?.stopVideoRecording().then((value) {
          record = 0;
          sec = 0;
          clicked = false;
          setState(() {});
        });
      } catch (e) {
        debugPrint('e');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _toggleCamera() async {
    final cameras = await availableCameras();
    final currentCameraIndex = cameras.indexWhere(
      (c) => c == _controller?.description,
    );
    final nextCameraIndex = (currentCameraIndex + 1) % cameras.length;
    final nextCamera = cameras[nextCameraIndex];
    await _controller?.dispose();
    _controller = CameraController(nextCamera, ResolutionPreset.veryHigh);
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
    // await _controller?.prepareForVideoRecording();
    setState(() {});
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
  void initState() {
    super.initState();
    minute = 1;
    availableCameras().then((cameras) async {
      _controller = CameraController(cameras[0], ResolutionPreset.veryHigh);

      // _controller!.setZoomLevel(zoom);
      await _controller!.initialize();

      await Future.delayed(const Duration(seconds: 1));
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
        // countDownController.pause();
        _timer?.cancel();
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
                          onScaleUpdate: (ScaleUpdateDetails details) {
                            _handleZoom(details.scale);
                          },
                          child: AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
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
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () {
                          _controller?.dispose();
                          navPop();
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 6.h,
                  left: 5.w,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 0.8.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.fiber_manual_record,
                          color: Colors.red,
                          size: 20,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          '$minute:00 / ${convertSecToMin(sec)}',
                          style: TextStyleClass.normalStyle().copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    // height: 11.h,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 2.h,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              if (record == 0)
                                InkWell(
                                  onTap: () {
                                    _toggleCamera();
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        Icons.camera_enhance_sharp,
                                        color: Colors.white,
                                        size: Constants.isTablet ? 40 : 20,
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
                              SizedBox(width: 3.w),
                              if ([1, 2, 3].contains(record))
                                ButtonWidget(
                                  onTap: () {
                                    _send();
                                  },
                                  text: 'send',
                                  width: 20.w,
                                  height: 4.5.h,
                                  color: Colors.white,
                                  textStyle: TextStyleClass.normalStyle().copyWith(
                                    color: Colors.black,
                                  ),
                                  borderRadius: 25,
                                ),
                              const Spacer(),
                              if ([0, 2].contains(record))
                                InkWell(
                                  onTap: () {
                                    if (record == 0) {
                                      _startRecording();
                                    } else {
                                      _resume();
                                    }
                                  },
                                  child: const Icon(
                                    Icons.play_circle,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                              if ([1].contains(record))
                                InkWell(
                                  onTap: () {
                                    record = 2;
                                    _pause();
                                  },
                                  child: const Icon(
                                    Icons.pause_circle,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                              if ([2, 3, 1].contains(record))
                                InkWell(
                                  onTap: () {
                                    _reset();
                                  },
                                  child: const Icon(
                                    Icons.stop_circle_rounded,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),

                              // GestureDetector(
                              //   onTap: ()async{
                              //     if(record==2&&video!=null){
                              //       _controller?.dispose();
                              //       countDownController.pause();
                              //       _timer?.cancel();
                              //       navPop(video);
                              //     }
                              //   },
                              //   onLongPressStart: (val){
                              //     countDownController.reset();
                              //     countDownController.start();
                              //     record = 1;
                              //     _startRecording();
                              //   },
                              //   onLongPressEnd: (va)async{
                              //     record = 2;
                              //     await delay(100);
                              //     countDownController.pause();
                              //     if(_secondsRemaining>2){
                              //       _pause(2);
                              //     }
                              //   },
                              //   child: CircularCountDownTimer(
                              //     duration: minute*60,
                              //     initialDuration: 0,
                              //     controller: countDownController,
                              //     width: 21.w,
                              //     height: 21.w,
                              //     ringColor: AppColor.primaryColor.withOpacity(0.2),
                              //     ringGradient: null,
                              //     fillColor: AppColor.primaryColor.withOpacity(0.5),
                              //     fillGradient: null,
                              //     backgroundColor: AppColor.primaryColor,
                              //     backgroundGradient: null,
                              //     strokeWidth: 8.0,
                              //     strokeCap: StrokeCap.round,
                              //     textStyle: TextStyle(
                              //         fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.bold),
                              //     textFormat: CountdownTextFormat.S,
                              //     isReverse: true,
                              //     isReverseAnimation: true,
                              //     isTimerTextShown: true,
                              //     autoStart: false,
                              //     onStart: () {
                              //       debugPrint('Countdown Started');
                              //     },
                              //     onComplete: () {
                              //       debugPrint('Countdown Ended');
                              //     },
                              //     onChange: (String timeStamp) {
                              //       debugPrint('Countdown Changed $timeStamp');
                              //     },
                              //     timeFormatterFunction: (defaultFormatterFunction, duration) {
                              //       if(record == 2 ){
                              //         return "Save";
                              //       }else
                              //       if (record == 0) {
                              //         return "Start";
                              //       } else {
                              //         return convertSecToMin(int.parse(Function.apply(defaultFormatterFunction, [duration]).toString()));
                              //       }
                              //     },
                              //   ),
                              // ),
                              // Spacer(),
                              // SizedBox(width: 20.w,),
                              // if([0,2,].contains(record))SizedBox(width: 20.w,),
                            ],
                          ),
                        ],
                      ),
                    ),
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
