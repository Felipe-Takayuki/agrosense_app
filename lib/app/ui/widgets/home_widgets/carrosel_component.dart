import 'dart:developer';
import 'dart:io';

import 'package:agrosense_app/app/ui/screens/home/home_controller.dart';
import 'package:flutter/material.dart';

class CarroselComponent extends StatefulWidget {
  final HomeController controller; 
  final Size size;
  const CarroselComponent({super.key,required this.controller, required this.size});

  @override
  State<CarroselComponent> createState() => _CarroselComponentState();
}

class _CarroselComponentState extends State<CarroselComponent> {


  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        return SizedBox(
            width: widget.size.width * .9,
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.controller.traps.length,
                itemBuilder: (context, index) {
                  final trap = widget.controller.traps.reversed.toList()[index];
                  return GestureDetector(
                    onTap: () {
                      widget.controller.selectedTrap = trap;
                      log("Trap selecionada: ${trap.name}, direcao do vento: ${trap.weatherModel.windDirection}");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        width: widget.size.width * .25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child:
                              Image.file(File(trap.imagePath), fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  );
                }));
      }
    );
  }
}
