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

    var safeArea = SafeArea(
      child: TemplateWidget(
        height: sizeOf.height,
        child: Form(
          child: SingleChildScrollView(
            reverse: false,
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
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(passwordFocus);
                              },
                              controller: emailController,
                              decoration: InputDecoration(
                                  labelText: "Digite o seu e-mail",
                                  prefixIcon: Icon(Icons.mail)),
                            )),
                        SizedBox(height: sizeOf.height * .03),
                        SizedBox(
                            width: sizeOf.width * .9,
                            child: TextFormField(
                              focusNode: passwordFocus,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).unfocus();
                              },
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  labelText: "Digite a sua senha",
                                  prefixIcon: Icon(Icons.lock)),
                            )),
                        SizedBox(height: sizeOf.height * .03),
                        GestureDetector(
                          child: Text(
                            "Esqueçeu a senha",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          onTap: () {},
                        ),
                        SizedBox(height: 26),
                        SizedBox(
                            width: sizeOf.width * .9,
                            height: sizeOf.height * .2 / 3,
                            child: ElevatedButton(
                                onPressed: () {
                                  controller.signIn(emailController.text,
                                      passwordController.text, context);
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
                    height: sizeOf.height * .05,
                  ),
                  GestureDetector(
                      onTap: () {
                        context.go("/sign_up");
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: Theme.of(context).textTheme.labelMedium,
                            children: [
                              TextSpan(text: "Não possui uma conta?\n"),
                              TextSpan(
                                  text: "Crie agora",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 214, 173, 10),
                                      fontWeight: FontWeight.bold) )
                            ]),
                      )),
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
      body: ListenableBuilder(
          listenable: controller, builder: (context, child) => safeArea),
    );
  }
}
