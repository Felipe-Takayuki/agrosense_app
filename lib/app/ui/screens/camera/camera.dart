import 'dart:io';
import 'package:agrosense_app/app/repository/camera_repository.dart';
import 'package:agrosense_app/app/repository/trap_service.dart';
import 'package:agrosense_app/app/ui/screens/camera/camera_controller.dart';
import 'package:agrosense_app/app/ui/widgets/template.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';

class CameraTela extends StatefulWidget {
  const CameraTela({super.key});

  @override
  State<CameraTela> createState() => _CameraTelaState();
}

class _CameraTelaState extends State<CameraTela> {
  CamController camController = CamController();
  TextEditingController trapNameController = TextEditingController();
  Size? size;

  @override
  void dispose() {
    camController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    camController.loadCameras();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListenableBuilder(
        builder: (context, state) {
          return TemplateWidget(
            height: size!.height,
            child: Column(
              children: [_arquivoWidget()],
            ),
          );
        },
        listenable: camController,
      ),
    );
  }

  _arquivoWidget() {
    return camController.imagem == null
        ? SizedBox(
            width: size!.width,
            height: size!.height,
            child: _cameraPreviewWidget(),
          )
        : Column(
            children: [
              SizedBox(
                height: size!.height * .05,
              ),
              SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: [
                      Center(
                        child: SizedBox(
                          width: size!.width * .85,
                          height: size!.height * .4,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(camController.imagem!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size!.width * .85,
                        child: TextFormField(
                          controller: trapNameController,
                          decoration:
                              InputDecoration(hintText: "Nome da armadilha"),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            camController.saveTrap(
                                trapNameController.text, context);
                          },
                          child: Text("Confirmar"))
                    ],
                  ),
                ),
              )
            ],
          );
  }

  _cameraPreviewWidget() {
    final CameraController? cameraController = camController.controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Text('Widget para Câmera que não está disponível');
    } else {
      return SizedBox(
        height: size!.height,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Positioned.fill(
                child: GestureDetector(
                    onScaleStart: camController.handleScaleStart,
                    onScaleUpdate: camController.handleScaleUpdate,
                    child: CameraPreview(camController.controller!))),
            Padding(
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
                  onPressed: camController.tirarFoto,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
