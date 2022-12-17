import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/components/input_field.dart';
import 'package:foodie/components/logo.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/choose_role_screen.dart';
import 'package:foodie/screens/screens.dart';
import 'package:foodie/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  CollectionReference userRefs = FirebaseFirestore.instance.collection("Users");
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: userRefs.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
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
                        InputField(
                          controller: emailController,
                          labelIcon: const Icon(Icons.email),
                          hintText: "Email",
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
                            buttonFunction: () {
                              for (int i = 0;
                                  i < snapshot.data!.docs.length;
                                  i++) {
                                if (snapshot.data!.docs[i]['user_email'] ==
                                        emailController.text &&
                                    snapshot.data!.docs[i]['password'] ==
                                        passwordController.text) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Screens(
                                        userEmail: snapshot
                                            .data!.docs[i]['user_email']
                                            .toString(),
                                      ),
                                    ),
                                  );
                                }
                              }

                              setState(() {
                                emailController.clear();
                                passwordController.clear();
                              });
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
                                        builder: (context) =>
                                            const ChooseRoleScreen()),
                                  );
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      color: CustomColor().buttonColor),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return SizedBox();
        });
  }
}



              //=====

