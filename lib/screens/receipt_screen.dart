import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/constants/text_constant.dart';

class ReceiptScreen extends StatefulWidget {
  final String orderNum,
      vendorEmail,
      time,
      dineIn,
      foodName,
      email,
      image,
      price,
      totalPrice,
      quantity;
  final bool? cancel;
  final String? userEmail;
  final String? label;

  final Function() buttonFunc;
  const ReceiptScreen(
      {super.key,
      required this.orderNum,
      required this.vendorEmail,
      required this.time,
      required this.dineIn,
      required this.foodName,
      required this.email,
      required this.image,
      required this.price,
      required this.totalPrice,
      required this.quantity,
      required this.buttonFunc,
      this.label,
      this.cancel,
      this.userEmail});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.cancel == false
        ? Scaffold(
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
                        Row(
                          children: [
                            widget.dineIn == "1"
                                ? Image.asset(
                                    "assets/dine-in.png",
                                    width: 50,
                                    height: 50,
                                    color: Colors.green,
                                  )
                                : Image.asset(
                                    "assets/take-away.png",
                                    width: 50,
                                    height: 50,
                                    color: Colors.blue,
                                  ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "#${widget.orderNum}",
                              style: CustomFont().pageLabel,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                image: NetworkImage(widget.image),
                                fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          widget.foodName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ReceiptComponent(
                          detail: widget.price,
                          label: 'Price:',
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ReceiptComponent(
                          detail: widget.quantity,
                          label: 'Quantity:',
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ReceiptComponent(
                          detail: widget.totalPrice,
                          label: 'Total Price:',
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ReceiptComponent(
                          detail: widget.time,
                          label: 'Time:',
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ReceiptComponent(
                          detail: widget.vendorEmail,
                          label: 'Vendor Email:',
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomButton(
                            buttonLabel: widget.label ?? "Back to home",
                            buttonFunction: widget.buttonFunc),
                      ]),
                ),
              ),
            ),
          )
        : Scaffold(
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
                        Row(
                          children: [
                            widget.dineIn == "1"
                                ? Image.asset(
                                    "assets/dine-in.png",
                                    width: 50,
                                    height: 50,
                                    color: Colors.green,
                                  )
                                : Image.asset(
                                    "assets/take-away.png",
                                    width: 50,
                                    height: 50,
                                    color: Colors.blue,
                                  ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "#${widget.orderNum} Order Cancelled",
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                image: NetworkImage(widget.image),
                                fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          widget.foodName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ReceiptComponent(
                          detail: widget.price,
                          label: 'Price:',
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ReceiptComponent(
                          detail: widget.quantity,
                          label: 'Quantity:',
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ReceiptComponent(
                          detail: widget.totalPrice,
                          label: 'Total Price:',
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ReceiptComponent(
                          detail: widget.time,
                          label: 'Time:',
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ReceiptComponent(
                          detail: widget.vendorEmail,
                          label: 'Vendor Email:',
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("CancelOrder")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox();
                              }
                              if (snapshot.hasData) {
                                for (int i = 0;
                                    i < snapshot.data!.docs.length;
                                    i++) {
                                  if (snapshot.data!.docs[i]['user_email'] ==
                                          widget.email &&
                                      snapshot.data!.docs[i]['order_number']
                                              .toString() ==
                                          widget.orderNum) {
                                    return ReceiptComponent(
                                      detail: snapshot.data!.docs[i]['reason'],
                                      label: 'Reason:',
                                    );
                                  }
                                }
                              }
                              return const SizedBox();
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomButton(
                            buttonLabel: widget.label ?? "Back to home",
                            buttonFunction: widget.buttonFunc),
                      ]),
                ),
              ),
            ),
          );
    ;
  }
}

class ReceiptComponent extends StatelessWidget {
  String label, detail;
  ReceiptComponent({super.key, required this.label, required this.detail});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        const SizedBox(
          width: 8,
        ),
        Text(
          detail,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
