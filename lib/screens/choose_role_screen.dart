import 'package:flutter/material.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/screens/choose_role_login_screen.dart';
import 'package:foodie/screens/register_as_new_vendor.dart';
import 'package:foodie/screens/register_screen.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()));
            },
            child: Container(
              height: 100,
              width: 100,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: CustomColor().logoColor),
              alignment: Alignment.center,
              child: Image.asset(
                "assets/user.png",
                width: 100.0,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Register as a new user",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 50,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterNewVendorScreen()));
            },
            child: Container(
              height: 100,
              width: 100,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: CustomColor().logoColor),
              alignment: Alignment.center,
              child: Image.asset(
                "assets/vendor.png",
                color: Colors.white,
                width: 100.0,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Register as a new vendor",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 100,
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
                          builder: (context) => const ChooseRoleLoginScreen()));
                },
                child: Text(
                  "Sign in",
                  style: TextStyle(color: CustomColor().logoColor),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
