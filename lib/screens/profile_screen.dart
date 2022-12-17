import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/components/details_component.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/login_screen.dart';
import 'package:foodie/screens/user_wallet_screen.dart';

class ProfileScreen extends StatefulWidget {
  final userEmail;
  const ProfileScreen({
    super.key,
    required this.userEmail,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference vendorRef =
      FirebaseFirestore.instance.collection("Vendor");
  CollectionReference ref = FirebaseFirestore.instance.collection("Users");
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 165,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
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
                    Text(
                      widget.userEmail,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserWalletScreen(
                                  userEmail: widget.userEmail,
                                )));
                  },
                  child: Image.asset(
                    "assets/wallet.png",
                    width: 30,
                    height: 30,
                  ),
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
            DetailComponent(
              label: "Email",
              detail: widget.userEmail,
            ),
            // DetailComponent(
            //   label: "Phone",
            //   detail: widget.phoneNum,
            // ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 600,
            ),
            CustomButton(
                buttonLabel: "Logout",
                buttonFunction: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }),
          ],
        ),
      )),
    );
  }
}
