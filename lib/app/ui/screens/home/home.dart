import 'dart:developer';
import 'dart:io';
import 'package:agrosense_app/app/model/trap_model.dart';
import 'package:agrosense_app/app/repository/camera_repository.dart';
import 'package:agrosense_app/app/repository/trap_service.dart';
import 'package:agrosense_app/app/service/supabase_service.dart';
import 'package:agrosense_app/app/ui/screens/home/home_controller.dart';
import 'package:agrosense_app/app/ui/widgets/template.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? imagem;
  List<String?> imagens = [];
  List<TrapModel> traps = [];
  HomeController controller = HomeController();
  TrapModel? selectedTrap;
  bool _loadedTraps = false;
  @override
  void initState() {
    TrapRepository trapRepository = TrapRepository();
    trapRepository.getTraps().then((value) {
      if (value.isNotEmpty) {
        setState(() {
          traps = value;
        });
      }
    });
    CameraRepository cameraRepository = CameraRepository();
    cameraRepository.getImage().then((value) {
      if (value != "") {
        setState(() {
          imagem = value;
        });
      }
    });

    cameraRepository.getImages().then((images) {
      if (images.isNotEmpty) {
        setState(() {
          imagens = images;
        });
      }
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedTraps) {
      TrapRepository().getTraps().then((value) {
        if (value.isNotEmpty) {
          setState(() {
            traps = value;
            _loadedTraps = true;
          });
        }
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Brightness bright = MediaQuery.of(context).platformBrightness;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                SupabaseService().instance.auth.signOut();
                context.go("/sign_in");
              },
              icon: Icon(
                Icons.chevron_left,
                color: bright == Brightness.dark ? Colors.white : Colors.black,
              )),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: TemplateWidget(
              height: size.height,
              child: Center(
                child: SizedBox(
                  width: size.width * .9,
                  child: Column(
                    spacing: size.height * .01,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          context.go("/camera", extra: {});
                        },
                        child: Container(
                          width: size.width * .9,
                          height: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(167, 158, 158, 1)),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: imagem != null
                                    ? SizedBox(
                                        width: size.width * 9,
                                        child: Image.file(
                                          File(imagem!),
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
                      ),
                      SizedBox(
                        width: size.width * .88,
                        child: ElevatedButton(
                          onPressed: () async {},
                          child: const Text(
                            "Análisar Imagem",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      if (imagem != null)
                        SizedBox(
                            width: size.width * .9,
                            height: 150,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: traps.length,
                                itemBuilder: (context, index) {
                                  final trap = traps.reversed.toList()[index];
                                  return GestureDetector(
                                    onTap: () {
                                      selectedTrap = trap;
                                      log("Trap selecionada: ${trap.name}");
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: SizedBox(
                                        width: size.width * .25,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                              File(trap.imagePath),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                  );
                                })),
                      if (selectedTrap != null)
                        Container(
                          width: size.width * 0.88,
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.amber[700],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedTrap!.name,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                  "Temperatura: ${selectedTrap!.weatherModel.temperature} ºC"),
                              Text(
                                  "Umidade relativa: ${selectedTrap!.weatherModel.airHumidity}%"),
                              Text(
                                  "Direção do vento: ${selectedTrap!.weatherModel.windDirection}"),
                            ],
                          ),
                        ),
                      SizedBox(
                        width: size.width * .88,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.saveAllImages();
                          },
                          child: const Text(
                            "Salvar Imagens na Galeria",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
