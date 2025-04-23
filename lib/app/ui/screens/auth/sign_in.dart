import 'package:agrosense_app/app/ui/screens/auth/auth_controller.dart';
import 'package:agrosense_app/app/ui/widgets/template.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final controller = AuthController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    Brightness bright = MediaQuery.of(context).platformBrightness;



    var safeArea = SafeArea(
        child:
         TemplateWidget(
          height: sizeOf.height,
           child: Form(
            child: SingleChildScrollView(
              reverse: false,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: sizeOf.height * .05,
                    ),                  
                    SizedBox(
                      width: sizeOf.width * .8,
                      child: Image.asset(bright == Brightness.light ? 'assets/images/logo.png' :'assets/images/logo_tdark.png', fit: BoxFit.contain,)),
                    SizedBox(
                      height: sizeOf.height * .05,
                    ),  
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: sizeOf.width * .9,
                              child: TextFormField(
                                focusNode: emailFocus,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted:(_){
                                  FocusScope.of(context).requestFocus(passwordFocus);
                                },
                                controller: emailController,
                                decoration: InputDecoration(
                                    labelText: "Digite o seu e-mail",
                                    prefixIcon: Icon(Icons.person)),
                              )),
                          SizedBox(height: 26),
                          SizedBox(
                              width: sizeOf.width * .9,
                              child: TextFormField(
                                focusNode: passwordFocus,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted:(_){
                                  FocusScope.of(context).unfocus();
                                },
                                obscureText: true,
                                controller: passwordController,
                                decoration: InputDecoration(
                                    labelText: "Digite a sua senha",
                                    prefixIcon: Icon(Icons.lock)),
                              )),
                          GestureDetector(
                            child: Text("Esqueçeu a senha", style: Theme.of(context).textTheme.bodySmall,),
                            onTap: () {},
                          ),
                          SizedBox(height: 26),
                          SizedBox(
                              width: sizeOf.width * .9,
                              height: sizeOf.height * .2 / 3,
                              child: ElevatedButton(
                                  onPressed: () {
                                    controller.signIn(emailController.text, passwordController.text, context);
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
                    Text("entradas alternativas", style: Theme.of(context).textTheme.bodySmall,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed:()async{
                              controller.googleSignInOrSignUp(context);
                            },
                            child:Image.asset("assets/images/googleIcon.png")),
                      ],
                    ),
                    SizedBox(
                      height: sizeOf.height * .05,
                    ),
                    
                    GestureDetector(
                      onTap: () {
                        context.go("/sign_up");
                      },
                      child: Text("Registre-se", style: Theme.of(context).textTheme.bodyMedium,),
                    ),
                    
                    SizedBox(
                      height: sizeOf.height * .05,
                    ),
                  ],
                ),
              ),
            ),
                   ),
         ),
      );
    return Scaffold(

      body: ListenableBuilder(listenable: controller, builder: (context,child) => safeArea),
    );
  }
}
