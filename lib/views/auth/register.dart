import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controllers/auth_controller.dart';
import 'package:threads_clone/routes/route_names.dart';

import 'package:threads_clone/widgets/auth_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");
  final TextEditingController nameController = TextEditingController(text: "");
  final TextEditingController cpasswordController =
      TextEditingController(text: "");
  final AuthController controller = Get.put(AuthController());

  //* Submit Method
  void submit() {
    //showSnackBar("Sucess", "Hey I'm just Testing");
    if (_form.currentState!.validate()) {
      controller.register(
          nameController.text, emailController.text, passwordController.text);
      // if (kDebugMode) {
      //   // print("All is good");
      // }
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    cpasswordController.dispose();
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
                      "Sign Up",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text("Welcome to Threads!")
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AuthInput(
                controller: nameController,
                label: "Name",
                hintText: "Enter your name",
                validatorCallback: ValidationBuilder()
                    .required()
                    .minLength(3)
                    .maxLength(50)
                    .build(),
              ),
              const SizedBox(
                height: 20,
              ),
              AuthInput(
                controller: emailController,
                validatorCallback:
                    ValidationBuilder().required().email().build(),
                label: "Email",
                hintText: "Enter your email",
              ),
              const SizedBox(
                height: 20,
              ),
              AuthInput(
                controller: passwordController,
                label: "Password",
                hintText: "Enter your Password",
                validatorCallback: ValidationBuilder()
                    .required()
                    .minLength(6)
                    .maxLength(50)
                    .build(),
                isPasswordField: true,
              ),
              const SizedBox(
                height: 20,
              ),
              AuthInput(
                  controller: cpasswordController,
                  label: "Confirm Password",
                  hintText: "Enter your confirm Password",
                  isPasswordField: true,
                  validatorCallback: (arg) {
                    if (passwordController.text != arg) {
                      return "Confirm password not matached";
                    }
                    return null;
                  }),
              const SizedBox(
                height: 20,
              ),
              Obx(() => ElevatedButton(
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(const Size.fromHeight(48)),
                  ),
                  onPressed: submit,
                  child: Text(controller.registerLoading.value
                      ? "Proccessing.."
                      : "Submit"))),
              const SizedBox(
                height: 20,
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: " Sign In",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.toNamed(RouteNames.login))
                ], text: "Already have an account ?"),
              )
            ],
          ),
        ),
      ))),
    );
  }
}
