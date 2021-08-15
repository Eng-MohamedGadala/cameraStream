import 'package:cam_stream/pages/gallery/domain/entity/gallery_model.dart';
import 'package:cam_stream/pages/gallery/presntation/controllers/gallery_controller.dart';
import 'package:cam_stream/pages/home/presntation/controllers/home_controller.dart';
import 'package:cam_stream/routes/app_pages.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main.dart';

class CameraView extends StatefulWidget {
  CameraView({Key? key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

/// Returns a suitable camera icon for [direction].
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
    default:
      throw ArgumentError('Unknown lens direction');
  }
}

void logError(String code, String? message) {
  if (message != null) {
    print('Error: $code\nError Message: $message');
  } else {
    print('Error: $code');
  }
}

class _CameraState extends State<CameraView> {
  late CameraController controller;
  XFile? imageFile;
  XFile? videoFile;
  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras![0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _captureControlRowWidget() {
    final CameraController? cameraController = controller;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.camera_alt),
          color: Colors.blue,
          onPressed: cameraController != null &&
                  cameraController.value.isInitialized &&
                  !cameraController.value.isRecordingVideo
              ? onTakePictureButtonPressed
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          color: Colors.blue,
          onPressed: cameraController != null &&
                  cameraController.value.isInitialized &&
                  !cameraController.value.isRecordingVideo
              ? onVideoRecordButtonPressed
              : null,
        ),
        IconButton(
          icon: cameraController != null &&
                  cameraController.value.isRecordingPaused
              ? Icon(Icons.play_arrow)
              : Icon(Icons.pause),
          color: Colors.blue,
          onPressed: cameraController != null &&
                  cameraController.value.isInitialized &&
                  cameraController.value.isRecordingVideo
              ? (cameraController.value.isRecordingPaused)
                  ? onResumeButtonPressed
                  : onPauseButtonPressed
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.stop),
          color: Colors.red,
          onPressed: cameraController != null &&
                  cameraController.value.isInitialized &&
                  cameraController.value.isRecordingVideo
              ? onStopButtonPressed
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.image),
          color: Colors.grey,
          onPressed: openGallery,
        )
      ],
    );
  }

  void onStopButtonPressed() {
    GalleryController galleryController = Get.put(GalleryController());
    stopVideoRecording().then((file) {
      if (mounted) setState(() {
         imageFile = file;
          galleryController.addItemToGalleryList(
              GalleryModel(path: file!.path, type: 'mp4'));
      });
      if (file != null) {
        // showInSnackBar('Video recorded to ${file.path}');
        // videoFile = file;
        // _startVideoPlayer();
      }
    });
  }

  Future<void> pauseVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return null;
    }

    try {
      await cameraController.pauseVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  void onPauseButtonPressed() {
    pauseVideoRecording().then((_) {
      if (mounted) setState(() {});
      // showInSnackBar('Video recording paused');
    });
  }

  void onVideoRecordButtonPressed() {
    startVideoRecording().then((_) {
      if (mounted) setState(() {});
    });
  }

  Future<void> startVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      Get.snackbar('Error', 'Error: select a camera first.');
      return;
    }

    if (cameraController.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }

    try {
      await cameraController.startVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return;
    }
  }

  void onResumeButtonPressed() {
    resumeVideoRecording().then((_) {
      if (mounted) setState(() {});
      // showInSnackBar('Video recording resumed');
    });
  }

  Future<void> resumeVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return null;
    }

    try {
      await cameraController.resumeVideoRecording();
    } on CameraException catch (e) {
      // _showCameraException(e);
      rethrow;
    }
  }

  void onTakePictureButtonPressed() {
    GalleryController galleryController = Get.put(GalleryController());
    takePicture().then((XFile? file) {
      if (mounted) {
        setState(() {
          imageFile = file;
          galleryController.addItemToGalleryList(
              GalleryModel(path: file!.path, type: 'jpge'));

          // videoController?.dispose();
          // videoController = null;
        });
        if (file != null)
          Get.snackbar('Success', 'Picture saved to ${file.path}',
              backgroundColor: Colors.green);
      }
    });
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      Get.snackbar('Select Camera', 'Error: select a camera first.',
          backgroundColor: Colors.red);
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    Get.snackbar('Error', 'Error: ${e.code}\n${e.description},',
        backgroundColor: Colors.red);
  }

  Future<XFile?> stopVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return null;
    }

    try {
      return cameraController.stopVideoRecording();
    } on CameraException catch (e) {
      // _showCameraException(e);
      return null;
    }
  }

  void openGallery() {
    Get.toNamed(Routes.GALLERY);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        // onNewCameraSelected(controller.description);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Camera Streaming',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: GetBuilder<HomeController>(
            init: HomeController(),
            initState: (_) {},
            builder: (_) {
              return InkWell(
                  onTap: () => Get.toNamed(Routes.PROFILE,
                      arguments: _.firebaseAuth.currentUser),
                  child: _.firebaseAuth.currentUser!.photoURL != null
                      ? CircleAvatar(
                          foregroundImage: NetworkImage(
                              _.firebaseAuth.currentUser!.photoURL!))
                      : CircleAvatar(
                          foregroundImage:
                              AssetImage('assets/images/davatar.png'),
                        ));
            },
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                    child: !controller.value.isInitialized
                        ? Container(
                            child: Text('Camera not initialized'),
                          )
                        : CameraPreview(controller)),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color: controller != null && controller.value.isRecordingVideo
                      ? Colors.redAccent
                      : Colors.grey,
                  width: 3.0,
                ),
              ),
            ),
          ),
          _captureControlRowWidget(),
        ],
      ),
    );
  }
}
