
import 'dart:io';

import 'package:agrosense_app/app/service/camera_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  XFile? imagem;
  List<String?> imagens = [];


  @override
  void initState()  {
    CameraService cameraService = CameraService();
    cameraService.getImage().then((value) {
      if (value != null) {
        setState(() {
                imagem = XFile(value); 
        });
      }
    },);
    cameraService.getImages().then((images) {
      if (images.isNotEmpty) {
        imagens = images;
      }
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Brightness bright = MediaQuery.of(context).platformBrightness;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(bright == Brightness.light ? "assets/images/background_light.png" : "assets/images/background.png" ), fit: BoxFit.cover)
          ),
          child: Center(
            child: SizedBox(
              width: size.width * .9,
              child: Column(
                spacing: size.height * .01,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50,),
                  // TextButton(onPressed: (){
                  //   Supabase.instance.client.auth.signOut();
                  // }, child: Text("Deslogar")),
                  GestureDetector(
                    onTap: () {
                      context.go("/camera", extra:{
                        
                      });
                    } ,
                    child: Container(
                      width: size.width * .9, 
                      height: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(167, 158, 158, 1)
                      ),
                      child:ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: imagem != null ? Image.file(File(imagem!.path), fit: BoxFit.cover, ) : Icon(Icons.camera_alt, size: 50,)),
                    ),              
                  ),
                  SizedBox(
                    width: size.width * .88,
                    child: ElevatedButton(onPressed: (){}, child: Text("Análisar Imagem", style: TextStyle(color: Colors.black),))
                  ),
          
                  imagem != null ? SizedBox(
                    width: size.width * .9,
                    height: 150,
              
                    child: ListView.builder(
                      itemCount: imagens.length,
                      scrollDirection: Axis.horizontal,
                      
                      itemBuilder: (context, index) {
                      
                        return Padding(
                          padding: EdgeInsets.all(5),
                          child: SizedBox(
                            width: size.width * .25,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(File(imagens.reversed.toList()[index]!), fit: BoxFit.cover,)),
                          ));
                    },),
                  ) : Container(),
                  SizedBox(
                    width: size.width * .88,
                    child: ElevatedButton(onPressed: (){}, child: Text("Salvar Imagens na Galeria", style: TextStyle(color: Colors.black),))
                  )
              
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}