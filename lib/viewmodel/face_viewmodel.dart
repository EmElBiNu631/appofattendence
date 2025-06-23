import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FaceVerificationViewModel extends ChangeNotifier {
  late CameraController _cameraController;
  List<CameraDescription>? _cameras;
  bool _isFlashOn = false;
  bool _isFrontCamera = true;

  CameraController get cameraController => _cameraController;
  bool get isFlashOn => _isFlashOn;

  FaceVerificationViewModel() {
    _initCamera();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    _startCamera(_cameras!.firstWhere((cam) => cam.lensDirection == CameraLensDirection.front));
  }

  void _startCamera(CameraDescription cameraDescription) {
    _cameraController = CameraController(cameraDescription, ResolutionPreset.medium);
    _cameraController.initialize().then((_) {
      notifyListeners();
    });
  }

  void switchCamera() {
    _isFrontCamera = !_isFrontCamera;
    final newCamera = _cameras!.firstWhere((cam) =>
    cam.lensDirection == (_isFrontCamera ? CameraLensDirection.front : CameraLensDirection.back));
    _startCamera(newCamera);
  }

  void toggleFlash() async {
    _isFlashOn = !_isFlashOn;
    await _cameraController.setFlashMode(
        _isFlashOn ? FlashMode.torch : FlashMode.off);
    notifyListeners();
  }

  Future<void> takePhoto(BuildContext context) async {
    if (!_cameraController.value.isInitialized) return;

    final file = await _cameraController.takePicture();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Photo saved at ${file.path}")),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
}
