import 'dart:io';

import 'package:agrosense_app/app/ui/screens/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CameraButton extends StatefulWidget {
  final HomeController controller;
  final Size size;
  const CameraButton({super.key, required this.controller, required this.size});

  @override
  State<CameraButton> createState() => _CameraButtonState();
}

class _CameraButtonState extends State<CameraButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go("/camera");
      },
      child: Container(
        width: widget.size.width * .9,
        height: 350,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromRGBO(167, 158, 158, 1)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: widget.controller.imagem != null
                  ? SizedBox(
                      width: widget.size.width * 9,
                      child: Image.file(
                        File(widget.controller.imagem!),
                        fit: BoxFit.cover,
                      ),
                    )
                  : null,
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(128, 0, 0, 0),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
