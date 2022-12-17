import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/components/input_field.dart';
import 'package:foodie/components/logo.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/Vendor/vendor_approval_screen.dart';
import 'package:foodie/screens/login_screen.dart';

class RegisterNewVendorScreen extends StatefulWidget {
  const RegisterNewVendorScreen({super.key});

  @override
  State<RegisterNewVendorScreen> createState() =>
      _RegisterNewVendorScreenState();
}

class _RegisterNewVendorScreenState extends State<RegisterNewVendorScreen> {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController restaurantController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController mallController = TextEditingController();
  TextEditingController unitNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
              const AppLogo(
                logo: "assets/vendor.png",
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Register Now",
                style: CustomFont().pageLabel,
              ),
              InputField(
                controller: userEmailController,
                labelIcon: const Icon(Icons.email),
                hintText: "Email",
              ),
              InputField(
                obscureText: true,
                controller: passwordController,
                labelIcon: const Icon(Icons.store_mall_directory),
                hintText: "Password",
              ),
              InputField(
                controller: restaurantController,
                labelIcon: const Icon(Icons.account_circle),
                hintText: "Restaurant",
              ),
              InputField(
                controller: locationController,
                labelIcon: const Icon(Icons.location_city),
                hintText: "Location",
              ),
              InputField(
                controller: mallController,
                labelIcon: const Icon(Icons.local_mall),
                hintText: "Mall",
              ),
              InputField(
                controller: unitNoController,
                labelIcon: const Icon(Icons.store_mall_directory),
                hintText: "Unit No",
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                  buttonFunction: () async {
                    FirebaseFirestore.instance
                        .collection("Vendor_details")
                        .add({
                      "bio": "",
                      "description": "",
                      "email": userEmailController.text,
                    });
                    FirebaseFirestore.instance.collection("New_Vendor").add({
                      "restaurant": restaurantController.text,
                      "location": locationController.text,
                      "mall": mallController.text,
                      "unit_no": unitNoController.text,
                      "code": 1,
                      "email": userEmailController.text,
                      "password": passwordController.text,
                    }).then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const VendorApprovalScreen()));
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
              const SizedBox(
                height: 150,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
