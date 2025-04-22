
import 'dart:io';
import 'package:agrosense_app/app/service/camera_service.dart';
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


  @override
  void initState()  {
    CameraService cameraService = CameraService();
    cameraService.getImage().then((value) {
      if (value != "") {
        setState(() {
                imagem = value; 
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
    final HomeController homeController = HomeController();

    return Scaffold(
      body: SafeArea(
        child: TemplateWidget(
          height: size.height,
          child: Center(
            child: SizedBox(
              width: size.width * .9,
              child: Column(
                spacing: size.height * .01,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50,),

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
                      child:Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: imagem != null ? SizedBox(
                              width: size.width *9,
                              child: Image.file(File(imagem!), fit: BoxFit.cover, )) : null),
                            Center(child: Container(
                              
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(color: Color.fromARGB(128, 0, 0, 0), shape: BoxShape.circle),
                              child: Icon(Icons.camera_alt, color: Colors.white, size: 30,))),

                        ],
                      ),
                    ),              
                  ),
                  SizedBox(
                    width: size.width * .88,
                    child: ElevatedButton(onPressed: () async{
                      //await Supabase.instance.client.auth.signOut();
                    }, child: Text("Análisar Imagem", style: TextStyle(color: Colors.black),))
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
                    child: ElevatedButton(onPressed: (){
                      homeController.saveAllImages();
                    }, child: Text("Salvar Imagens na Galeria", style: TextStyle(color: Colors.black),))
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