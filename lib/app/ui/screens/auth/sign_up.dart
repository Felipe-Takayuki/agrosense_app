import 'package:agrosense_app/app/ui/screens/auth/auth_controller.dart';
import 'package:agrosense_app/app/ui/widgets/template.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final controller = AuthController();
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

    var safeArea = SafeArea(
      child:TemplateWidget(
        height: sizeOf.height,
        child: Form(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: sizeOf.height * .03,
                  ),
                  SizedBox(
                      width: sizeOf.width * .5,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                      )),
                  SizedBox(
                    height: sizeOf.height * .05,
                  ),
                  Text(
                    "Bem Vindo ao sistema AgroSense",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(
                    height: sizeOf.height * .02,
                  ),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                            width: sizeOf.width * .9,
                            child: TextFormField(
                              controller: nameController,
                              focusNode: nameFocus,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).requestFocus(emailFocus);
                              },
                              decoration: InputDecoration(
                                  labelText: "Digite o seu nome",
                                  prefixIcon: Icon(Icons.person)),
                            )),
                        SizedBox(height: sizeOf.height * .03),
                        SizedBox(
                            width: sizeOf.width * .9,
                            child: TextFormField(
                              controller: emailController,
                              focusNode: emailFocus,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(passwordFocus);
                              },
                              decoration: InputDecoration(
                                  labelText: "Digite o seu e-mail",
                                  prefixIcon: Icon(Icons.mail)),
                            )),
                        SizedBox(height: sizeOf.height * .03),
                        SizedBox(
                            width: sizeOf.width * .9,
                            child: TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              focusNode: passwordFocus,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).unfocus();
                              },
                              decoration: InputDecoration(
                                  labelText: "Digite a sua senha",
                                  prefixIcon: Icon(Icons.lock)),
                            )),
                        SizedBox(height: sizeOf.height * .05),
                        SizedBox(
                            width: sizeOf.width * .9,
                            height: sizeOf.height * .2 / 3,
                            child: ElevatedButton(
                                onPressed: () async {
                                  await controller.signUp(
                                      nameController.text,
                                      emailController.text,
                                      passwordController.text,
                                      context,
                                      sizeOf.width);
                                },
                                child:controller.isLoading ? CircularProgressIndicator() : Text(
                                  "Cadastrar-se",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ))),
                      ],
                    ),
                  ),
                  SizedBox(height: sizeOf.height * .03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () async {
                            controller.googleSignInOrSignUp(context);
                          },
                          child: Image.asset("assets/images/googleIcon.png")),
                    ],
                  ),
                  SizedBox(
                    height: sizeOf.height * .03,
                  ),
                  GestureDetector(
                      onTap: () {
                        context.go("/sign_in");
                      },
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: [
                                TextSpan(text: "Já possui uma conta?"),
                                TextSpan(
                                    text: "\nEntre",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 214, 173, 10),
                                        fontWeight: FontWeight.bold))
                              ]))),
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
      body: ListenableBuilder(
          listenable: controller, builder: (context, child) => controller.isLoading ? Center(child: CircularProgressIndicator()) : safeArea),
    );
  }
}
