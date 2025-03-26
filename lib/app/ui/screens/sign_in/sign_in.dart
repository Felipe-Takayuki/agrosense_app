import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
      final sizeOf = MediaQuery.sizeOf(context);
      
    return Scaffold(
      body: Center(
        child: Form(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              spacing: 20,
              mainAxisSize: MainAxisSize.min, 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/logo.png'),
                SizedBox(
                  width: sizeOf.width * .9 ,
                  child: TextFormField(
                   decoration: InputDecoration(
                    labelText: "Digite o seu e-mail",
                    prefixIcon: Icon(Icons.person)
                   ), 
                  
                  )),
                SizedBox(
                  width: sizeOf.width * .9,
                  child: Expanded(
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Digite a sua senha",
                        prefixIcon: Icon(Icons.lock)
                      ),
                    ),
                  )),
                  TextButton(onPressed: (){}, child: Text("Esqueçeu a senha")),
            
                  SizedBox(
                    width: sizeOf.width  * .9,
                    child: Expanded(child: ElevatedButton(onPressed: (){}, child: Text("Entrar", style: TextStyle(color: Colors.white, fontSize: 20),)
                    )
                    )
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}