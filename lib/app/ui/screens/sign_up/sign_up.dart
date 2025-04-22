import 'package:agrosense_app/app/ui/screens/sign_up/sign_up_controller.dart';
import 'package:agrosense_app/app/ui/widgets/template.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
    final controller = SignUpController();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameFocus = FocusNode();
    final emailFocus = FocusNode();
    final passwordFocus = FocusNode();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
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
                                controller: nameController,
                                focusNode: nameFocus,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted:(_){
                                  FocusScope.of(context).requestFocus(emailFocus);
                                },
                                decoration: InputDecoration(
                                    labelText: "Digite o seu nome",
                                    prefixIcon: Icon(Icons.person)),
                              )),
                          SizedBox(height: 13),

                          SizedBox(
                              width: sizeOf.width * .9,
                              child: TextFormField(
                                controller: emailController,
                                focusNode: emailFocus,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted:(_){
                                  FocusScope.of(context).requestFocus(passwordFocus);
                                },
                                decoration: InputDecoration(
                                    labelText: "Digite o seu e-mail",
                                    prefixIcon: Icon(Icons.person)),
                              )),
                          SizedBox(height: 13),
                          SizedBox(
                              width: sizeOf.width * .9,
                              child: TextFormField(
                                obscureText: true,
                                controller: passwordController,
                                focusNode: nameFocus,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted:(_){
                                  FocusScope.of(context).unfocus();
                                },
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
                                  onPressed: () async {
                                    await controller.signUp(nameController.text,emailController.text, passwordController.text, context, sizeOf.width); 
                                  },
                                  child: Text(
                                    "Cadastrar-se",
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
                            onPressed: () async {
                            //  final login =  await SupabaseService().googleSignUp();
                            //  if (login.user != null) {
                            //   if (context.mounted) {
                            //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home() ));
                            //   } else {
                            //     log("Erro com o context");
                            //   }
                            //  } else {
                            //   log("Erro ao tentar logar");
                            //  }
                              
                            },
                      
                            child:Image.asset("assets/images/googleIcon.png")),
                      ],
                    ),
                    SizedBox(
                      height: sizeOf.height * .03,
                    ),
                    
                    GestureDetector(
                      onTap: () {
                        context.go("/sign_in");
                      },
                      child: Text("Entre", style: Theme.of(context).textTheme.bodyMedium,),
                    ),
                    
                    SizedBox(
                      height: sizeOf.height * .03,
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
