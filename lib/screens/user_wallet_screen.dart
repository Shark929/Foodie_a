import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/components/input_field.dart';
import 'package:foodie/components/promotion_component.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:intl/intl.dart';

class UserWalletScreen extends StatefulWidget {
  final String userEmail;
  const UserWalletScreen({super.key, required this.userEmail});

  @override
  State<UserWalletScreen> createState() => _UserWalletScreenState();
}

class _UserWalletScreenState extends State<UserWalletScreen> {
  TextEditingController topUpController = TextEditingController();
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              color: CustomColor().focusColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Wallet",
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                                child: Container(
                                                  height: 200,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 16,
                                                    vertical: 20,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                          "Top up amount"),
                                                      InputField(
                                                        controller:
                                                            topUpController,
                                                        hintText: "RM 0.00",
                                                      ),
                                                      CustomButton(
                                                          buttonLabel: "Top Up",
                                                          buttonFunction: () {
                                                            var formatterDate =
                                                                DateFormat(
                                                                    'dd/MM/yy');
                                                            var formatterTime =
                                                                DateFormat(
                                                                    'kk:mm');
                                                            String actualDate =
                                                                formatterDate
                                                                    .format(
                                                                        now);
                                                            String actualTime =
                                                                formatterTime
                                                                    .format(
                                                                        now);
                                                            double newBalance = double
                                                                    .parse(snapshot
                                                                            .data!
                                                                            .docs[i]
                                                                        [
                                                                        'balance']) +
                                                                double.parse(
                                                                    topUpController
                                                                        .text);
                                                            snapshot
                                                                .data!
                                                                .docs[i]
                                                                .reference
                                                                .update({
                                                              "balance": newBalance
                                                                  .toStringAsFixed(
                                                                      2),
                                                            }).then((value) {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "Transaction")
                                                                  .add({
                                                                "food_name":
                                                                    "Top Up",
                                                                "time":
                                                                    "$actualDate $actualTime",
                                                                "user_email":
                                                                    widget
                                                                        .userEmail,
                                                                "payment_code":
                                                                    "2",
                                                                "amount":
                                                                    "${topUpController.text}.00",
                                                              });
                                                            }).then((value) =>
                                                                    Navigator.pop(
                                                                        context));
                                                          }),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                    },
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
            const SizedBox(
              height: 16,
            ),
            //Promotion Code here

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Promotion",
                    style: CustomFont().pageLabel,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("UserPromotion")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        }
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                if (snapshot.data!.docs[index]['user_email'] ==
                                        widget.userEmail &&
                                    snapshot.data!.docs[index]['code'] == "1") {
                                  return InkWell(
                                      onTap: () {
                                        snapshot.data!.docs[index].reference
                                            .update({"code": "2"});
                                      },
                                      child: PromotionComponent(
                                          amount: snapshot.data!.docs[index]
                                              ['amount'],
                                          code: snapshot.data!.docs[index]
                                              ['promo_code'],
                                          title: snapshot.data!.docs[index]
                                              ['promotion_title']));
                                }
                                return SizedBox();
                              });
                        }
                        return const SizedBox();
                      }),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Transaction History",
                    style: CustomFont().pageLabel,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  StreamBuilder(
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
                                      snapshot.data!.docs[index]
                                                  ['payment_code'] ==
                                              "1"
                                          ? "assets/dish.png"
                                          : "assets/top-up.png",
                                      color: snapshot.data!.docs[index]
                                                  ['payment_code'] ==
                                              "1"
                                          ? Colors.green
                                          : Colors.blue,
                                      width: 40,
                                      height: 40,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                      "RM ${snapshot.data!.docs[index]['amount']}",
                                      style: TextStyle(
                                        color: snapshot.data!.docs[index]
                                                    ['payment_code'] ==
                                                "1"
                                            ? Colors.green
                                            : Colors.blue,
                                      ),
                                    ),
                                  ]),
                                );
                              }
                              return const SizedBox();
                            });
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
