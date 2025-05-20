import 'dart:developer';
import 'dart:io';
import 'package:agrosense_app/app/model/trap_model.dart';
import 'package:agrosense_app/app/repository/camera_repository.dart';
import 'package:agrosense_app/app/repository/trap_service.dart';
import 'package:agrosense_app/app/ui/screens/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends ChangeNotifier {
  final CameraRepository _cameraRepository = CameraRepository();
  final AuthController authController = AuthController();
  List<TrapModel> traps = [];
  TrapModel? _selectedTrap;
  String? imagem;

  TrapModel? get selectedTrap => _selectedTrap;
  
  set selectedTrap(TrapModel? value) {
    _selectedTrap = value;
    notifyListeners();
  }

  void loadTraps() async {
    
    TrapRepository trapRepository = TrapRepository();
    trapRepository.getTraps().then((value) {
      if (value.isNotEmpty) {
        traps = value;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  void loadImages() async {
    CameraRepository cameraRepository = CameraRepository();
    cameraRepository.getImage().then((value) {
      if (value != "") {
        imagem = value;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  Future<void> requestPermissions() async {
    var result = await Permission.storage.request();
    if (result.isGranted) {
      log('Permitido');
      return;
    }
    result = await Permission.photos.request();
    if (result.isGranted) {
      log('Permitido');
      return;
    }
  }

  Future<void> _saveLocalImage(String path, numImage) async {
    requestPermissions();
    // if (await Gal.requestAccess()) {
    //   log("Permitido");
    // }

    final file = File(path);
    if (await file.exists()) {
      final bytes = await file.readAsBytes();
      try {
        final lista = await _cameraRepository.getSavedImages();
        if (!lista.contains(path)) {
          await Gal.putImageBytes(bytes,
              name: "imagem$numImage", album: 'AgroSense');
          _cameraRepository.registerSaveImageGallery(path);
          log("Imagem salva com sucesso!");
        }
      } on GalException catch (_) {
        log("E");
      }
    } else {
      log('Arquivo não encontrado: $path');
    }
  }

  saveAllImages() async {
    final imagesPath = await _cameraRepository.getImages();
    for (var path in imagesPath) {
      _saveLocalImage(path!, imagesPath.indexOf(path));
    }
  }
}
