import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/components/input_field.dart';
import 'package:foodie/components/loading_component.dart';
import 'package:foodie/components/logo.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/login_screen.dart';
import 'package:foodie/screens/screens.dart';
import 'package:foodie/service/user_value.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  late Timer timer;
  bool isRegistered = false;

  animateProgressIndicator() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isRegistered = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const AppLogo(),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Register Now",
                style: CustomFont().pageLabel,
              ),
              const SizedBox(
                height: 30,
              ),
              InputField(
                controller: userNameController,
                labelIcon: const Icon(Icons.account_circle),
                hintText: "Username",
              ),
              InputField(
                controller: userEmailController,
                labelIcon: const Icon(Icons.email),
                hintText: "Email",
              ),
              InputField(
                controller: phoneNumController,
                labelIcon: const Icon(Icons.phone),
                hintText: "Phone Number",
              ),
              InputField(
                obscureText: true,
                controller: passwordController,
                labelIcon: const Icon(Icons.key),
                hintText: "Password",
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                  buttonFunction: () async {
                    FirebaseFirestore.instance.collection("MyWallet").add({
                      "balance": "0",
                      "user_email": userEmailController.text,
                    });
                    FirebaseFirestore.instance.collection("Users").add({
                      "user_name": userNameController.text,
                      "user_email": userEmailController.text,
                      "phone_number": phoneNumController.text,
                      "password": passwordController.text,
                      "code": 1,
                    }).then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Screens(
                                    userEmail: userEmailController.text,
                                  )));
                    }).catchError((err) => print("Failed to add new data"));
                  },
                  buttonLabel: "Register"),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: CustomColor().buttonColor),
                      )),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
