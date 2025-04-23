import 'dart:developer';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {

  final instance = Supabase.instance.client; 
  
  Future<AuthResponse> login(String email, String password) async {
    return await instance.auth.signInWithPassword(email: email, password: password);
  }
 
  Future<AuthResponse?> googleSignIn() async {
    try {
    const webClientId = '239947781193-bos9te3d28ffpotlh8khjck7ruhfda10.apps.googleusercontent.com';
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email','profile'],
      serverClientId: webClientId      
    );
    final googleUser = await googleSignIn.signIn();
    
    if (googleUser == null) {
      throw 'Login cancelado pelo usuário.';
    }
    final googleAuth = await googleUser.authentication;
    final acessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;
    

    if (acessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    final user = await instance.auth.signInWithIdToken( 
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: acessToken
    );

    return user;
    } catch (e, stackTrace) {
      log('Erro no login com Google: $e\n$stackTrace');
      return null;
    }

  }
  Future<void> signOut() async {
    await instance.auth.signOut();
  }
  Future<AuthResponse> signUp(String displayName,String email, String password) async {
    return await instance.auth.signUp(email: email,password: password, data: {
      "display_name" : displayName
    }); 
  }
}