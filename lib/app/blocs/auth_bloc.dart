import 'package:agrosense_app/app/bloc_events/auth_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  AuthBloc(super.initialState){
    on<SignInEvent>(){
      
    }  }

}