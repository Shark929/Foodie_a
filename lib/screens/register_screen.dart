import 'package:flutter/material.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/components/input_field.dart';
import 'package:foodie/components/logo.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
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
            const InputField(
              labelIcon: Icon(Icons.email),
              hintText: "Email",
            ),
            const InputField(
              labelIcon: Icon(Icons.key),
              hintText: "Password",
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(buttonFunction: () {}, buttonLabel: "Register"),
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
                    onTap: () {
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
            )
          ],
        ),
      )),
    );
  }
}
