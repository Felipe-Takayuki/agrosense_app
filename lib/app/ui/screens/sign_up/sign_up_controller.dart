import 'dart:developer';

import 'package:agrosense_app/app/service/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpController extends ChangeNotifier{
  SupabaseService service = SupabaseService();

  Future<void> signUp(String name, String email, String password, BuildContext context,double width ) async {
    
    try {
      final register = await service.signUp(name, email, password);
      if((register.user != null) && (register.session == null)) {
        if(context.mounted) {
          showDialog(context: context, builder: (context) => 
          AlertDialog(
        
            title: Column(
              children: [
                Container(
                  width: width * .2,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(shape: BoxShape.circle , color: Colors.green),
                  child: Icon(Icons.check, size: width *.05, color: Colors.white,),
                ),
                SizedBox(height: 10,),
                Text(
                  'E-mail de confirmação enviado\n confirme o e-mail'
                , style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center ,),
              ],
            ),
   actionsAlignment: MainAxisAlignment.center,
                  actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK", style: Theme.of(context).textTheme.labelLarge,),
          )
                  ]
          ));
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
