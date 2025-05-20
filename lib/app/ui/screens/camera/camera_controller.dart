import 'package:agrosense_app/app/repository/camera_repository.dart';
import 'package:agrosense_app/app/repository/trap_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CamController extends ChangeNotifier {
  CameraController? controller;
  TrapRepository trapRepository = TrapRepository();
  CameraRepository cameraRepository = CameraRepository();
  List<CameraDescription> cameras = [];
  XFile? imagem;

  double _minZoom = 0;
  double _maxZoom = 0;
  double _baseZoom = 0;
  double _currentZoom = 0;

  startCamera() {
    if (cameras.isEmpty) {
      debugPrint('Câmera não foi encontrada');
    } else {
      previewCamera(cameras.first);
    }
  }

  tirarFoto() async {
    final CameraController? cameraController = controller;

    if (cameraController != null && cameraController.value.isInitialized) {
      try {
        cameraController.setFocusPoint(Offset.zero);
        cameraController.setFocusMode(FocusMode.auto);
        cameraController.getMaxZoomLevel();
        cameraController.getMinZoomLevel();
        XFile file = await cameraController.takePicture();
        imagem = file;
        notifyListeners();
      } on CameraException catch (e) {
        debugPrint(e.description);
      }
    }
  }

  handleScaleUpdate(ScaleUpdateDetails details) async {
    if (controller == null) return;
    final newZoom = (_baseZoom * details.scale).clamp(_minZoom, _maxZoom);
    await controller!.setZoomLevel(newZoom);
    _currentZoom = newZoom;
    notifyListeners();
  }

  handleScaleStart(ScaleStartDetails details) {
    _baseZoom = _currentZoom;
    notifyListeners();
  }

  saveTrap(String trapName, BuildContext context) {
    trapRepository.addTrap(trapName, imagem!.path);
    cameraRepository.saveImage(imagem!.path);
    notifyListeners();
    context.pop(true);
  }

  loadCameras() async {
    try {
      cameras = await availableCameras();
      startCamera();
    } on CameraException catch (e) {
      debugPrint(e.description);
    }
  }

  previewCamera(CameraDescription camera) async {
    final CameraController cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    controller = cameraController;

    try {
      await cameraController.initialize();
      _minZoom = await controller!.getMinZoomLevel();
      _maxZoom = await controller!.getMaxZoomLevel();
    } on CameraException catch (e) {
      debugPrint(e.description);
    }

    notifyListeners();
  }
}
