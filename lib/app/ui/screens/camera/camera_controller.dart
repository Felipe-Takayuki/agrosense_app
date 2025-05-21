import 'dart:developer';

import 'package:agrosense_app/app/repository/camera_repository.dart';
import 'package:agrosense_app/app/repository/trap_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CamController extends ChangeNotifier {
  CameraController? controller;
  TrapRepository trapRepository = TrapRepository();
  CameraRepository cameraRepository = CameraRepository();
  List<CameraDescription> _cameras = [];
  XFile? imagem;
  bool loading = false;
  double _minZoom = 0;
  double _maxZoom = 0;
  double _baseZoom = 0;
  double _currentZoom = 0;

  _startCamera() {
    if (_cameras.isEmpty) {
      debugPrint('Câmera não foi encontrada');
    } else {
      previewCamera(_cameras.first);
    }
  }

  setLoading(bool value) {
    loading = value;
    notifyListeners();
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
      } on CameraException catch (e) {
        debugPrint(e.description);
      }
    }
    notifyListeners();
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

  saveTrap(String trapName, BuildContext context) async {
    try {
      setLoading(true);
      await trapRepository.addTrap(trapName, imagem!.path);
      cameraRepository.saveImage(imagem!.path);
      notifyListeners();
      if (context.mounted) {
        context.go("/home");
      }
    } catch (e) {
      log("Erro ao salvar trap", error: e);
    } finally {
      setLoading(false);
    }
  }

  loadCameras() async {
    try {
      _cameras = await availableCameras();
      _startCamera();
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
