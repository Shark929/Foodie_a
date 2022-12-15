import 'package:flutter/material.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/components/details_component.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/Vendor/vendor_screens.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 165,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/user.png",
                    width: 50,
                    height: 50,
                    color: CustomColor().logoColor,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Renesa",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const VendorScreens()));
                        },
                        child: const Text("View as vendor"),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Details",
                style: CustomFont().pageLabel,
              ),
              const SizedBox(
                height: 20,
              ),
              const DetailComponent(
                label: "Email",
                detail: "renesa@gmail.com",
              ),
              const DetailComponent(
                label: "Phone",
                detail: "+60 1234 5678",
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                alignment: Alignment.center,
                child: const Text("This account is not a vendor"),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Register as a vendor",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: CustomColor().logoColor,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 600,
              ),
              CustomButton(buttonLabel: "Logout", buttonFunction: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
