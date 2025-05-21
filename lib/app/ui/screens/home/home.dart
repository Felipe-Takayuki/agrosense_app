import 'package:agrosense_app/app/service/detection_service.dart';
import 'package:agrosense_app/app/service/supabase_service.dart';
import 'package:agrosense_app/app/ui/screens/home/home_controller.dart';
import 'package:agrosense_app/app/ui/widgets/home_widgets/camera_button.dart';
import 'package:agrosense_app/app/ui/widgets/home_widgets/carrosel_component.dart';
import 'package:agrosense_app/app/ui/widgets/home_widgets/weather_component.dart';
import 'package:agrosense_app/app/ui/widgets/template.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController controller = HomeController();
  @override
  void initState() {
    controller.loadTraps();
    controller.loadImages();
    super.initState();
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
        body: ListenableBuilder(
            listenable: controller,
            builder: (context, state) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: 
                    TemplateWidget(

  
  child: Align(
    alignment: Alignment.topCenter,
    child: Column(
      mainAxisSize: MainAxisSize.min,    // <<--- !
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 12),
        CameraButton(controller: controller, size: size),
        SizedBox(
          width: size.width * .88,
          child: ElevatedButton(
            onPressed: () async => DetectionService().testConnection(),
            child: const Text("Análisar Imagem", style: TextStyle(color: Colors.black)),
          ),
        ),
        if (controller.imagem != null)
          CarroselComponent(controller: controller, size: size),
        if (controller.selectedTrap != null)
          WeatherComponent(controller: controller, size: size),
        SizedBox(
          width: size.width * .88,
          child: ElevatedButton(
            onPressed: controller.saveAllImages,
            child: const Text("Salvar Imagens na Galeria", style: TextStyle(color: Colors.black)),
          ),
        ),
      ],
    ),
  ),
)

                    // TemplateWidget(
                    //   height: size.height,
                    //   child: Center(
                    //     child: Column(
                    //       spacing: size.height * .01,
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         const SizedBox(height: 12),
                    //         CameraButton(
                    //           controller: controller,
                    //           size: size,
                    //         ),
                    //         SizedBox(
                    //           width: size.width * .88,
                    //           child: ElevatedButton(
                    //             onPressed: () async {
                    //               DetectionService().testConnection();
                    //             },
                    //             child: const Text(
                    //               "Análisar Imagem",
                    //               style: TextStyle(color: Colors.black),
                    //             ),
                    //           ),
                    //         ),
                    //         controller.imagem != null ?
                    //           CarroselComponent(
                    //               controller: controller, size: size) : Text(""),
                    //         controller.selectedTrap != null?
                    //           WeatherComponent(
                    //               controller: controller, size: size):Text(''),
                    //         ElevatedButton(
                    //           onPressed: () {
                    //             controller.saveAllImages();
                    //           },
                    //           child: const Text(
                    //             "Salvar Imagens na Galeria",
                    //             style: TextStyle(color: Colors.black),
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
              );
            }));
  }
}
