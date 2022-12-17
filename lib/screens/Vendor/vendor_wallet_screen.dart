import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/components/input_field.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:intl/intl.dart';

class VendorWalletScreen extends StatefulWidget {
  final String email;

  const VendorWalletScreen({super.key, required this.email});

  @override
  State<VendorWalletScreen> createState() => _VendorWalletScreenState();
}

class _VendorWalletScreenState extends State<VendorWalletScreen> {
  CollectionReference withdrawRef =
      FirebaseFirestore.instance.collection("Withdrawal");
  DateTime now = DateTime.now();

  double balance = 0;
  double adminCommission = 0.2;
  double totalRevenue = 0;

  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "My Wallet",
                  style: CustomFont().pageLabel,
                ),
                const SizedBox(
                  height: 16,
                ),
                StreamBuilder(
                    stream: withdrawRef.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        for (int i = 0; i < snapshot.data!.docs.length; i++) {
                          if (snapshot.data!.docs[i]['email'] == widget.email) {
                            balance =
                                double.parse(snapshot.data!.docs[i]['balance']);

                            if (balance == 0.0) {
                              return StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("Order")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      for (int i = 0;
                                          i < snapshot.data!.docs.length;
                                          i++) {
                                        if (snapshot.data!.docs[i]
                                                ['vendor_email'] ==
                                            widget.email) {
                                          if (snapshot.data!.docs[i]['code'] ==
                                              "3") {
                                            balance += double.parse(snapshot
                                                .data!.docs[i]['total_price']);
                                          }
                                          return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: CustomColor().logoColor,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Text(
                                                  "Total Balance",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  "RM ${balance.toStringAsFixed(2)}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 24),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      }
                                    }
                                    return const Text("No data shown");
                                  });
                            }
                          }
                        }

                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          decoration: BoxDecoration(
                              color: CustomColor().logoColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "Total Balance",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "RM ${balance.toStringAsFixed(2)}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 24),
                              ),
                            ],
                          ),
                        );
                      }
                      return const Text("No data shown");
                    }),
                const SizedBox(
                  height: 30,
                ),
                const Text("Amount to withdraw"),
                InputField(
                  controller: amountController,
                  hintText: "RM 10.00",
                ),
                StreamBuilder(
                    stream: withdrawRef.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        for (int i = 0; i < snapshot.data!.docs.length; i++) {
                          if (snapshot.data!.docs[i]['email'] == widget.email) {
                            balance =
                                double.parse(snapshot.data!.docs[i]['balance']);

                            return CustomButton(
                                buttonLabel: "Withdraw",
                                buttonFunction: () {
                                  if (amountController.text != "") {
                                    double newBalance = balance -
                                        double.parse(amountController.text);

                                    double adminCom =
                                        double.parse(amountController.text) *
                                            0.2;
                                    snapshot.data!.docs[i].reference.update({
                                      "balance": newBalance.toStringAsFixed(2),
                                      "current_withdrawal":
                                          amountController.text,
                                      "admin_commission":
                                          adminCom.toStringAsFixed(2)
                                    });

                                    //add to transaction collection
                                    var formatterDate = DateFormat('dd/MM/yy');
                                    var formatterTime = DateFormat('kk:mm');
                                    String actualDate =
                                        formatterDate.format(now);
                                    String actualTime =
                                        formatterTime.format(now);
                                    FirebaseFirestore.instance
                                        .collection("Transaction")
                                        .add({
                                      "amount":
                                          double.parse(amountController.text)
                                              .toStringAsFixed(2),
                                      "food_name": "Withdrawal",
                                      "payment_code": "3",
                                      "time": "$actualDate $actualTime",
                                      "user_email": widget.email,
                                    });
                                  }
                                });
                          }
                        }
                      }
                      return const SizedBox();
                    }),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Transaction History",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Transaction")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                if (snapshot.data!.docs[index]['user_email'] ==
                                    widget.email) {
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/takeover.png",
                                          width: 40,
                                          height: 40,
                                          color: const Color.fromARGB(
                                              255, 229, 79, 4),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data!.docs[index]
                                                ['food_name']),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              snapshot.data!.docs[index]
                                                  ['time'],
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Text(
                                          "RM ${snapshot.data!.docs[index]['amount']}",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromARGB(
                                                  255, 229, 79, 4)),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return const SizedBox();
                              });
                        }
                        return const SizedBox();
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
