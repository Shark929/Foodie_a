import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/activity_component.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/receipt_screen.dart';
import 'package:foodie/screens/screens.dart';

class OrderScreen extends StatefulWidget {
  final String userEmail;
  const OrderScreen({super.key, required this.userEmail});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  TextEditingController reasonController = TextEditingController();
  CollectionReference orderRef = FirebaseFirestore.instance.collection("Order");
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
        height: MediaQuery.of(context).size.height - 165,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order",
                style: CustomFont().pageLabel,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Recent",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const SizedBox(
                height: 16,
              ),
              StreamBuilder(
                  stream: orderRef.snapshots(),
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
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReceiptScreen(
                                            cancel: false,
                                            buttonFunc: () {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Screens(
                                                            userEmail: widget
                                                                .userEmail,
                                                          )),
                                                  (route) => false);
                                            },
                                            orderNum: snapshot.data!
                                                .docs[index]['order_number']
                                                .toString(),
                                            vendorEmail: snapshot.data!
                                                .docs[index]['vendor_email'],
                                            time: snapshot.data!.docs[index]
                                                ['time'],
                                            dineIn: snapshot.data!.docs[index]
                                                ['dine_in'],
                                            foodName: snapshot.data!.docs[index]
                                                ['food_name'],
                                            email: snapshot.data!.docs[index]
                                                ['user_email'],
                                            image: snapshot.data!.docs[index]
                                                ['image'],
                                            price: snapshot.data!.docs[index]
                                                ['price'],
                                            totalPrice: snapshot.data!
                                                .docs[index]['total_price'],
                                            quantity: snapshot.data!.docs[index]
                                                ['quantity'])));
                              },
                              child: ActivityComponent(
                                  cancelFunction: () {
                                    double refundAmount = double.parse(snapshot
                                        .data!.docs[index]['total_price']);
                                    print(refundAmount.toString());
                                    String cancelCode = "4";

                                    showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0),
                                                child: SizedBox(
                                                  height: 200,
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 16,
                                                      ),
                                                      const Text(
                                                          "Reason for cancel"),
                                                      const SizedBox(
                                                        height: 16,
                                                      ),
                                                      TextField(
                                                        controller:
                                                            reasonController,
                                                      ),
                                                      const SizedBox(
                                                        height: 16,
                                                      ),
                                                      StreamBuilder(
                                                          stream:
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "MyWallet")
                                                                  .snapshots(),
                                                          builder: (context,
                                                              walletSnapshot) {
                                                            if (walletSnapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              CustomButton(
                                                                  buttonLabel:
                                                                      "Confirm Cancel",
                                                                  buttonFunction:
                                                                      () {});
                                                            }
                                                            if (walletSnapshot
                                                                .hasData) {
                                                              for (int i = 0;
                                                                  i <
                                                                      walletSnapshot
                                                                          .data!
                                                                          .docs
                                                                          .length;
                                                                  i++) {
                                                                if (walletSnapshot
                                                                            .data!
                                                                            .docs[i]
                                                                        [
                                                                        'user_email'] ==
                                                                    widget
                                                                        .userEmail) {
                                                                  return CustomButton(
                                                                      buttonLabel:
                                                                          "Confirm Cancel",
                                                                      buttonFunction:
                                                                          () {
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection("CancelOrder")
                                                                            .add({
                                                                          "order_number": snapshot
                                                                              .data!
                                                                              .docs[index]['order_number'],
                                                                          "food_name": snapshot
                                                                              .data!
                                                                              .docs[index]['food_name'],
                                                                          "user_email":
                                                                              widget.userEmail,
                                                                          "vendor_email": snapshot
                                                                              .data!
                                                                              .docs[index]['vendor_email'],
                                                                          "reason":
                                                                              reasonController.text,
                                                                        });

                                                                        double
                                                                            newBalance =
                                                                            refundAmount +
                                                                                double.parse(walletSnapshot.data!.docs[i]['balance']);
                                                                        walletSnapshot
                                                                            .data!
                                                                            .docs[i]
                                                                            .reference
                                                                            .update({
                                                                          "balance":
                                                                              newBalance.toStringAsFixed(2),
                                                                        });
                                                                        snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .reference
                                                                            .update({
                                                                          "code":
                                                                              "4",
                                                                        });
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
                                            ));
                                  },
                                  code: snapshot.data!.docs[index]['code'],
                                  orderNum: snapshot
                                      .data!.docs[index]['order_number']
                                      .toString(),
                                  time: snapshot.data!.docs[index]['time'],
                                  totalPrice: snapshot.data!.docs[index]
                                      ['total_price'],
                                  foodName: snapshot.data!.docs[index]
                                      ['food_name'],
                                  dineInCode: snapshot.data!.docs[index]
                                      ['dine_in']),
                            );
                          }
                          return const SizedBox();
                        },
                      );
                    }

                    return const SizedBox();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
