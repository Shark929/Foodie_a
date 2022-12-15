import 'package:flutter/material.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/components/input_field.dart';
import 'package:foodie/components/logo.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/screens.dart';
import 'package:foodie/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              "Login Now",
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
            CustomButton(
                buttonFunction: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Screens()),
                  );
                },
                buttonLabel: "Login"),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: Text(
                      "Sign Up",
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
