import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {

  final instance = Supabase.instance.client;
  
  Future<AuthResponse> login(String email, String password) async {
    return await instance.auth.signInWithPassword(email: email, password: password);
  }

Future<AuthResponse> googleSignIn() async {
  const webClientId = '239947781193-klk9cja0auagso1l1i926hs1pqv80ilp.apps.googleusercontent.com';
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email'],
    clientId: webClientId,
  );
  final googleUser = await googleSignIn.signIn();
  final googleAuth = await googleUser!.authentication;
  final idToken = googleAuth.idToken;
  
  if (idToken == null) {
    throw 'No ID Token found.';
  }

  return instance.auth.signInWithIdToken(
    provider: OAuthProvider.google,
    idToken: idToken,
  );
}
}