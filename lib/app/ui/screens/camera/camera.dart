import 'dart:developer';
import 'dart:io';
import 'package:agrosense_app/app/service/camera_service.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';

class CameraTela extends StatefulWidget {
  const CameraTela({super.key});

  @override
  State<CameraTela> createState() => _CameraTelaState();
}

class _CameraTelaState extends State<CameraTela> {
  List<CameraDescription> cameras = [];
  CameraController? controller;
  XFile? imagem;
  Size? size;

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadCameras();
  }

  
  _loadCameras() async {
    try {
      cameras = await availableCameras();
      _startCamera();
    } on CameraException catch (e) {
      debugPrint(e.description);
    }
  }

  _startCamera() {
    if (cameras.isEmpty) {
      debugPrint('Câmera não foi encontrada');
    } else {
      _previewCamera(cameras.first);
    }
  }

  _previewCamera(CameraDescription camera) async {
    final CameraController cameraController = CameraController(
      camera,
      ResolutionPreset.ultraHigh,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    controller = cameraController;

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      debugPrint(e.description);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(

      

      body: Container(
        width: size!.width,
        height: size!.height,
        color: Colors.grey[900],
        child: _arquivoWidget(),
      ),
      floatingActionButton: (imagem != null)
          ? FloatingActionButton.extended(
              onPressed: () async { 
                log(imagem!.path);
                CameraService().saveImage(imagem!.path);
            
                context.go("/home");
                
              },
              label: const Text('Confirmar'),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _arquivoWidget() {
    return SizedBox(
      width: size!.width * .9,
      height: size!.height ,
      child: imagem == null
          ? _cameraPreviewWidget()
          : Image.file(
              File(imagem!.path),
              fit: BoxFit.contain,
            ),
    );
  }

  _cameraPreviewWidget() {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Text('Widget para Câmera que não está disponível');
    } else {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CameraPreview(controller!),
          _botaoCapturaWidget(),
        ],
      );
    }
  }

  _botaoCapturaWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: CircleAvatar(
        radius: 32,
        backgroundColor: Colors.black,
        child: IconButton(
          icon: const Icon(
            Icons.camera_alt,
            color: Colors.white,
            size: 30,
          ),
          onPressed: tirarFoto,
        ),
      ),
    );
  }

  tirarFoto() async {
    final CameraController? cameraController = controller;
      
    if (cameraController != null && cameraController.value.isInitialized) {
      try {
        XFile file = await cameraController.takePicture();
        if (mounted) setState(() => imagem = file);
      } on CameraException catch (e) {
        debugPrint(e.description);
      }
    }
  }
}