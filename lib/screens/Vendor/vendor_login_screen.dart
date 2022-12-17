import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/components/input_field.dart';
import 'package:foodie/components/logo.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/Vendor/vendor_screens.dart';
import 'package:foodie/screens/choose_role_screen.dart';

class VendorLoginScreen extends StatefulWidget {
  const VendorLoginScreen({super.key});

  @override
  State<VendorLoginScreen> createState() => _VendorLoginScreenState();
}

class _VendorLoginScreenState extends State<VendorLoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  CollectionReference vendorRefs =
      FirebaseFirestore.instance.collection("Vendor");
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: vendorRefs.snapshots(),
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
                          "Vendor Login",
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
                                if (snapshot.data!.docs[i]['email'] ==
                                        emailController.text &&
                                    snapshot.data!.docs[i]['password'] ==
                                        passwordController.text) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VendorScreens(
                                              restaurantName: snapshot
                                                  .data!.docs[i]['restaurant'],
                                              location: snapshot.data!.docs[i]
                                                  ['location'],
                                              mall: snapshot.data!.docs[i]
                                                  ['mall'],
                                              unitNum: snapshot.data!.docs[i]
                                                  ['unit_no'],
                                              email: snapshot.data!.docs[i]
                                                  ['email'])));
                                }

                                setState(() {
                                  emailController.clear();
                                  passwordController.clear();
                                });
                              }
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

