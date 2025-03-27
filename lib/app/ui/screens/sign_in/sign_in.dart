import 'package:agrosense_app/app/service/supabase_service.dart';
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
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Form(
          child: SingleChildScrollView(
            reverse: true,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset('assets/images/logo.png'),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: sizeOf.width * .9,
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  labelText: "Digite o seu e-mail",
                                  prefixIcon: Icon(Icons.person)),
                            )),
                        SizedBox(height: 26),
                        SizedBox(
                            width: sizeOf.width * .9,
                            child: TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  labelText: "Digite a sua senha",
                                  prefixIcon: Icon(Icons.lock)),
                            )),
                        GestureDetector(
                          child: Text("Esqueçeu a senha"),
                          onTap: () {},
                        ),
                        SizedBox(height: 26),
                        SizedBox(
                            width: sizeOf.width * .9,
                            height: sizeOf.height * .2 / 3,
                            child: ElevatedButton(
                                onPressed: () {
                                  SupabaseService().login(emailController.text, passwordController.text); 
                                },
                                child: Text(
                                  "Entrar",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ))),
                      ],
                    ),
                  ),
                  SizedBox(height: 60),
                  Text("entradas alternativas"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {
                            SupabaseService().googleSignIn();
                          },
                          child:   TextButton(
                          onPressed: () {
                            
                          },
                          child:Image.asset("assets/images/googleIcon.png")),),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
