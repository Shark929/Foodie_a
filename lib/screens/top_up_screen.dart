import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/components/input_field.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:intl/intl.dart';

class TopUpScreen extends StatefulWidget {
  final String userEmail;
  const TopUpScreen({super.key, required this.userEmail});

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  TextEditingController topUpController = TextEditingController();
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            color: CustomColor().focusColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Top Up",
                  style: CustomFont().pageLabel,
                ),
                const SizedBox(
                  height: 16,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("MyWallet")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasData) {
                        for (int i = 0; i < snapshot.data!.docs.length; i++) {
                          if (snapshot.data!.docs[i]['user_email'] ==
                              widget.userEmail) {
                            return SizedBox(
                                child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "RM",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  snapshot.data!.docs[i]['balance'],
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ));
                          }
                        }
                      }
                      return const SizedBox();
                    }),
              ],
            ),

            //details here
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Transaction")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        if (snapshot.data!.docs[index]['user_email'] ==
                            widget.userEmail) {
                          return Container(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(children: [
                              Image.asset(
                                snapshot.data!.docs[index]['payment_code'] ==
                                        "1"
                                    ? "assets/dish.png"
                                    : "assets/top-up.png",
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      " ${snapshot.data!.docs[index]['food_name']}"),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                      " ${snapshot.data!.docs[index]['time']}"),
                                ],
                              ),
                              const Spacer(),
                              Text(
                                  "RM ${snapshot.data!.docs[index]['amount']}"),
                            ]),
                          );
                        }
                      });
                }
                return const SizedBox();
              },
            ),
          )
        ]),
      ),
    );
  }
}
