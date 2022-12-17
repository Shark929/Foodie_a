import 'package:flutter/material.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/screens/Vendor/vendor_login_screen.dart';
import 'package:foodie/screens/choose_role_screen.dart';
import 'package:foodie/screens/login_screen.dart';
import 'package:foodie/screens/register_as_new_vendor.dart';
import 'package:foodie/screens/register_as_vendor_screen.dart';
import 'package:foodie/screens/register_screen.dart';

class ChooseRoleLoginScreen extends StatefulWidget {
  const ChooseRoleLoginScreen({super.key});

  @override
  State<ChooseRoleLoginScreen> createState() => _ChooseRoleLoginScreenState();
}

class _ChooseRoleLoginScreenState extends State<ChooseRoleLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
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
            "Login as a user",
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
                      builder: (context) => const VendorLoginScreen()));
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
            "Login as a vendor",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 100,
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChooseRoleScreen()));
                },
                child: Text(
                  "Register",
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
