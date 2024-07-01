import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controllers/auth_controller.dart';
import 'package:threads_clone/routes/route_names.dart';

import 'package:threads_clone/widgets/auth_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");
  final AuthController authController = Get.put(AuthController());

  //* Submit Method
  void submit() {
    if (_form.currentState!.validate()) {
      authController.login(emailController.text, passwordController.text);
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _form,
          child: Column(
            children: [
              Image.asset(
                "assets/images/logo.png",
                width: 60,
                height: 60,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text("Welcome back!")
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AuthInput(
                controller: emailController,
                label: "Email",
                hintText: "Enter your email",
                validatorCallback: ValidationBuilder().email().build(),
              ),
              const SizedBox(
                height: 20,
              ),
              AuthInput(
                controller: passwordController,
                label: "Password",
                hintText: "Enter your Password",
                isPasswordField: true,
                validatorCallback: ValidationBuilder().required().build(),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(const Size.fromHeight(48)),
                  ),
                  onPressed: submit,
                  child: const Text("Submit")),
              const SizedBox(
                height: 20,
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: " Sign up",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.toNamed(RouteNames.register))
                ], text: "Don't have an account ?"),
              )
            ],
          ),
        ),
      ))),
    );
  }
}
