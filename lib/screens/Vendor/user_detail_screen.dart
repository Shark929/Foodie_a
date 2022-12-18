import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/details_component.dart';
import 'package:foodie/constants/color_constant.dart';

class UserDetailScreen extends StatefulWidget {
  final String userEmail, foodName, foodQuantity;
  const UserDetailScreen(
      {super.key,
      required this.userEmail,
      required this.foodName,
      required this.foodQuantity});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
              height: 250,
              alignment: Alignment.bottomLeft,
              width: MediaQuery.of(context).size.width,
              color: CustomColor().buttonColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                children: [
                  Image.asset(
                    "assets/user.png",
                    height: 80,
                    width: 80,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    widget.userEmail,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              )),
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("Users").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  for (int i = 0; i < snapshot.data!.docs.length; i++) {
                    if (snapshot.data!.docs[i]['user_email'] ==
                        widget.userEmail) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        alignment: Alignment.centerLeft,
                        child: DetailComponent(
                          label: "Contact number",
                          detail: snapshot.data!.docs[i]['phone_number'],
                        ),
                      );
                    }
                  }
                }
                return const SizedBox();
              }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                DetailComponent(
                  label: "Order",
                  detail: widget.foodName,
                ),
                const SizedBox(
                  width: 16,
                ),
                DetailComponent(
                  label: "Quantity",
                  detail: widget.foodQuantity,
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
