
import 'dart:developer';
import 'dart:io';
import 'package:agrosense_app/app/service/camera_service.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends ChangeNotifier {
    final CameraService _cameraService = CameraService();


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
        final lista = await _cameraService.getSavedImages();
        if (!lista.contains(path)){
          await Gal.putImageBytes(bytes, name: "imagem$numImage", album:'AgroSense');
          _cameraService.registerSaveImageGallery(path);
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
    final imagesPath = await _cameraService.getImages();
    for (var path in imagesPath) {
      _saveLocalImage(path!, imagesPath.indexOf(path));
    }
  }
}