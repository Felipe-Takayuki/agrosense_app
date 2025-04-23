import 'package:agrosense_app/app/ui/screens/camera/camera.dart';
import 'package:agrosense_app/app/ui/screens/home/home.dart';
import 'package:agrosense_app/app/ui/screens/auth/sign_in.dart';
import 'package:agrosense_app/app/ui/screens/auth/sign_up.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ConfigRouter {

  final router = GoRouter(
  initialLocation: Supabase.instance.client.auth.currentUser != null ? "/home" : "/sign_in" ,
  routes: [
    GoRoute(path: "/home", builder: (context,state){
      return  Home();
    }),
    GoRoute(
      path: '/',
      redirect: (_, __) => '/sign_in',
    ),
    GoRoute(path: "/sign_in", builder: (context, state) {
      return const SignIn();
    },),

    GoRoute(path: "/camera", builder: (context, state) {
      return const CameraTela();
    },),

    GoRoute(path: "/sign_up", builder: (context, state) {
      return const SignUp();
    },)
  ]);
}
