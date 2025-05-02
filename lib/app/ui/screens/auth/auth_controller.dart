import 'dart:developer';

import 'package:agrosense_app/app/service/supabase_service.dart';
import 'package:agrosense_app/app/ui/widgets/alert_modal.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthController extends ChangeNotifier {
  final supabase = SupabaseService();

  Future<void> signIn(email, password, BuildContext context) async {
    final login = await supabase.login(email, password);
    if (login.session != null) {
      if (context.mounted) {
        context.go("/home");
      }
    } else {
      log("Erro");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falha no login')),
        );
        notifyListeners();
      }
    }
  }

  Future<void> googleSignInOrSignUp(BuildContext context) async {
    final login = await supabase.googleSignIn();
    if (login != null && login.session != null) {
      if (context.mounted) {
        context.go("/home");
      }
    }
  }

  Future<void> signOut(BuildContext context) async {
    await supabase.signOut();
    if (context.mounted) {
      context.go("/sign_in");
    }
  }

  Future<void> signUp(String name, String email, String password,
      BuildContext context, double width) async {
    try {
      final register = await supabase.signUp(name, email, password);
      if ((register.user != null) && (register.session == null)) {
        if (context.mounted) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertModal(width: width);
              });
        }

        notifyListeners();
      }
      if (register.session != null) {
        if (context.mounted) {
          context.go("/home");
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
