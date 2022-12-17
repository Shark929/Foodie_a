import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/screens.dart';
import 'package:foodie/screens/user_wallet_screen.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class PaymentScreen extends StatefulWidget {
  final String code,
      dineIn,
      foodName,
      userEmail,
      foodImage,
      foodCode,
      price,
      foodType,
      quantity,
      totalPrice,
      foodVendorEmail;
  const PaymentScreen(
      {super.key,
      required this.code,
      required this.dineIn,
      required this.foodName,
      required this.userEmail,
      required this.foodImage,
      required this.foodCode,
      required this.price,
      required this.foodType,
      required this.quantity,
      required this.totalPrice,
      required this.foodVendorEmail});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  CollectionReference myWalletRef =
      FirebaseFirestore.instance.collection("MyWallet");
  String myBalance = "";
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    CollectionReference cartRef =
        FirebaseFirestore.instance.collection(widget.userEmail);

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  "Pay Now",
                  style: CustomFont().pageLabel,
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
              height: 16,
            ),
            const Text(
              "Total amount to be paid: ",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "RM ${widget.totalPrice}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(8)),
              width: MediaQuery.of(context).size.width,
              height: 160,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/credit-cards.png",
                      width: 100,
                    ),
                    const Text(
                      "Pay with card",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                  ]),
            ),
            const SizedBox(
              height: 16,
            ),
            StreamBuilder(
                stream: myWalletRef.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      if (snapshot.data!.docs[i]['user_email'] ==
                          widget.userEmail) {
                        myBalance = snapshot.data!.docs[i]['balance'];
                      }
                    }

                    return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(widget.userEmail)
                            .snapshots(),
                        builder: (context, cartSnapshot) {
                          if (cartSnapshot.hasData) {
                            return InkWell(
                              onTap: () async {
                                if (double.parse(myBalance) >
                                    double.parse(widget.totalPrice)) {
                                  double newBalance = double.parse(myBalance) -
                                      double.parse(widget.totalPrice);

                                  for (int i = 0;
                                      i < snapshot.data!.docs.length;
                                      i++) {
                                    if (snapshot.data!.docs[i]['user_email'] ==
                                        widget.userEmail) {
                                      snapshot.data!.docs[i].reference.update({
                                        "balance":
                                            newBalance.toStringAsFixed(2),
                                      });
                                    }
                                  }

                                  cartSnapshot.data!.docs[0].reference.delete();
                                  var formatterDate = DateFormat('dd/MM/yy');
                                  var formatterTime = DateFormat('kk:mm');
                                  String actualDate = formatterDate.format(now);
                                  String actualTime = formatterTime.format(now);
                                  Random random = new Random();
                                  int randomNumber = random.nextInt(100);
                                  FirebaseFirestore.instance
                                      .collection("Transaction")
                                      .add({
                                    "food_name": widget.foodName,
                                    "time": "$actualDate $actualTime",
                                    "user_email": widget.userEmail,
                                    "payment_code": "1",
                                    "amount": widget.totalPrice,
                                  });
                                  FirebaseFirestore.instance
                                      .collection("Order")
                                      .add({
                                    "order_number": randomNumber,
                                    "vendor_email": widget.foodVendorEmail,
                                    "time": "$actualDate $actualTime",
                                    "code": "1",
                                    "dine_in": widget.dineIn,
                                    "food_name": widget.foodName,
                                    "user_email": widget.userEmail,
                                    "image": widget.foodImage,
                                    "food_code": widget.foodCode,
                                    "price": widget.price,
                                    "food_type": widget.foodType,
                                    "quantity": widget.quantity,
                                    "total_price": widget.totalPrice,
                                  }).then((value) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Screens(
                                                  userEmail: widget.userEmail,
                                                )));
                                  });
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                            child: Container(
                                                height: 50,
                                                alignment: Alignment.center,
                                                color: const Color.fromARGB(
                                                    255, 232, 167, 162),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: const Text(
                                                    "Insufficient Balance in Wallet")),
                                          ));
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(8)),
                                width: MediaQuery.of(context).size.width,
                                height: 160,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        "assets/wallet.png",
                                        width: 100,
                                      ),
                                      const Text(
                                        "Pay with wallet",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        "RM $myBalance",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ]),
                              ),
                            );
                          }
                          return SizedBox();
                        });
                  }
                  return SizedBox();
                }),
          ]),
        ),
      )),
    );
  }
}
