import 'dart:developer';

import 'package:agrosense_app/app/service/supabase_service.dart';
import 'package:flutter/material.dart';

class SignUpController extends ChangeNotifier{
  SupabaseService service = SupabaseService();

  Future<void> signUp( String email, String password, BuildContext context) async {

    try {
      final register = await service.signUp(email, password);
      if(register.session != null) {
        if(context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Cadastro realizado, confirme o seu email')),
          );
        } 
      }
      notifyListeners();

    } catch (e) {
      log(e.toString());
    }

  }
}
