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
                              decoration: InputDecoration(
                                  labelText: "Digite o seu e-mail",
                                  prefixIcon: Icon(Icons.person)),
                            )),
                        SizedBox(height: 26),

                        SizedBox(
                            width: sizeOf.width * .9,
                            child: TextFormField(
                              obscureText: true,
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
                                onPressed: () {},
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

                      Container(width: 10, height: 10, decoration: BoxDecoration(color: Colors.blue),),
                      Container(width: 10, height: 10, decoration: BoxDecoration(color: Colors.blue),),
                      Container(width: 10, height: 10, decoration: BoxDecoration(color: Colors.blue),)


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
