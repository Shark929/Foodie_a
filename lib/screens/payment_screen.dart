import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/receipt_screen.dart';
import 'package:foodie/screens/screens.dart';
import 'package:foodie/screens/user_wallet_screen.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

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
  double replaceTotal = 0;

  DateTime now = DateTime.now();

  //for  messaging
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String mToken = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  //get device token
  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mToken = token!;
        print("my token is $mToken");
      });
      saveToken(mToken);
    });
  }

  void saveToken(String token) async {
    await FirebaseFirestore.instance.collection("UserToken").doc().set({
      'token': token,
    });
  }

  void sendPushMessage(
      {required String token,
      required String title,
      required String body}) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAHgpjrMM:APA91bFg45AqVXWSC_zUFAZT7Joa4tLYow3eIIWGxFvHxEnk_8CbMyfG3_7F43xV8ZfR0LMnnynZGH6RXzVhzeTE2uga-pxunI7DUO3Ap-HP1HHeAuP177Pi6AQoe3YMdGG8KPi1ktqu'
        },
        body: jsonEncode(<String, dynamic>{
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': 'done',
            'body': body,
            'title': title,
          },
          "notification": <String, dynamic>{
            "title": title,
            "body": body,
            "android_channel_id": "Foodie",
          },
          "to": token,
        }),
      );
    } catch (e) {
      if (kDebugMode) {
        print("error push notifiction");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference cartRef =
        FirebaseFirestore.instance.collection(widget.userEmail);
    replaceTotal = double.parse(widget.totalPrice);
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
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("UserPromotion")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      if (snapshot.data!.docs[i]['user_email'] ==
                          widget.userEmail) {
                        //calculate total here
                        replaceTotal = double.parse(widget.totalPrice) -
                            double.parse(snapshot.data!.docs[i]['amount']);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Promotion Code Applied"),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Promotion amount RM: ${snapshot.data!.docs[i]['amount']}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: CustomColor().buttonColor),
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
                              "RM ${replaceTotal.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        );
                      }
                    }
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Total amount to be paid: ",
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "RM ${replaceTotal.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  );
                }),
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
                    print("My balance: ${myBalance}");

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
                                  DocumentSnapshot snap =
                                      await FirebaseFirestore.instance
                                          .collection("UserToken")
                                          .doc("X3w7BwwchMUPC9yOZV9I")
                                          .get();

                                  String token = snap['token'];
                                  print(token);
                                  sendPushMessage(
                                      title: widget.foodName,
                                      body: widget.quantity,
                                      token: token);
                                  double newBalance =
                                      double.parse(myBalance) - replaceTotal;

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
                                  int randomNumber = random.nextInt(1000);
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
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ReceiptScreen(
                                                  cancel: false,
                                                  buttonFunc: () {
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Screens(
                                                                          userEmail:
                                                                              widget.userEmail,
                                                                        )),
                                                            (route) => false);
                                                  },
                                                  orderNum:
                                                      randomNumber.toString(),
                                                  vendorEmail:
                                                      widget.foodVendorEmail,
                                                  time:
                                                      "$actualDate $actualTime",
                                                  dineIn: widget.dineIn,
                                                  foodName: widget.foodName,
                                                  email: widget.userEmail,
                                                  image: widget.foodImage,
                                                  price: widget.price,
                                                  totalPrice: replaceTotal
                                                      .toStringAsFixed(2),
                                                  quantity: widget.quantity,
                                                )),
                                        (route) => false);
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
