import 'dart:developer';
import 'package:agrosense_app/app/service/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInController extends ChangeNotifier {
  final supabase = SupabaseService();

  Future<void> signIn(email, password,BuildContext context) async {
    final login = await supabase.login(email, password); 
    if (login.session != null) {
      if (context.mounted) {
        context.go("/home");

      }  
    } else {
      log("Erro");
      if(context.mounted) {
       ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falha no login')),
        );
        notifyListeners();

      }

    }
  }
  
  Future<void> googleSignIn(BuildContext context) async {
    final login = await supabase.googleSignIn();
    if (login!.session != null) {
      if (context.mounted) {
        context.go("/home");

      } 
    }
  }

}