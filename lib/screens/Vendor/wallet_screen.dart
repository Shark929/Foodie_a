import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/components/input_field.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/constants/text_constant.dart';

class WalletScreen extends StatefulWidget {
  final String email;

  const WalletScreen({super.key, required this.email});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  CollectionReference withdrawRef =
      FirebaseFirestore.instance.collection("Withdrawal");
  double balance = 0;
  double adminCommission = 0.2;
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                                      double.parse(amountController.text) * 0.2;
                                  snapshot.data!.docs[i].reference.update({
                                    "balance": newBalance.toStringAsFixed(2),
                                    "current_withdrawal": amountController.text,
                                    "admin_commission":
                                        adminCom.toStringAsFixed(2)
                                  });
                                }
                              });
                        }
                      }
                    }
                    return SizedBox();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
