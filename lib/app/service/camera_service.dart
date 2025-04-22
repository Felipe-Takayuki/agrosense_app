
import 'package:shared_preferences/shared_preferences.dart';

class CameraService {
   
  Future<SharedPreferences> _instance() async {
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    return sharedPreferences;
  } 


Future<void> _addImage(String newImage) async {
  final instance = await _instance();
  List<String> listaAtual = instance.getStringList('images') ?? [];

  listaAtual.add(newImage);

  await instance.setStringList('images', listaAtual);
}

  void saveImage(String imagePath) async {
    final instancia =await _instance();
    instancia.setString("image",imagePath);   
    _addImage(imagePath);
  }

  void registerSaveImageGallery(String newImage) async {
    final instance = await _instance();
    List<String> listaAtual = instance.getStringList('gallery_images') ?? [];

    listaAtual.add(newImage);

    await instance.setStringList('gallery_images', listaAtual);
  } 

  Future<String> getImage() async {
    final instance = await _instance();
    final path = instance.getString("image");
    return path!;
  }
  
  Future<List<String?>> getImages() async {
    final instancia = await _instance();
    final listas = instancia.getStringList("images");
    return listas!;
  }
  
  Future<List<String?>> getSavedImages() async {
    final instancia = await _instance();
    final listas = instancia.getStringList("gallery_images") ?? [];
    return listas;
  }
  

  
}
