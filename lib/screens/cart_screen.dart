import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/cart_component.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/constants/text_constant.dart';
import 'dart:math';

import 'package:foodie/screens/payment_screen.dart';

class CartScreen extends StatefulWidget {
  final String userEmail;

  const CartScreen({super.key, required this.userEmail});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String foodNameCheckOut = "";
  String foodQuantityCheckOut = "";
  String foodPrice = "";
  String foodTotalPrice = "";
  String foodVendorEmail = "";
  String foodCode = "";
  String foodType = "";
  String foodImage = "";
  String isDineIn = "";
  bool dineInLoading = false;
  bool showTickDineIn = false;
  bool showTickTakeAway = false;
  bool takeAwayLoading = false;
  late Timer timer;

  dineInProgressIndicator() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        dineInLoading = false;
        showTickDineIn = true;
      });
    });
  }

  takeAwayProgressIndicator() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        takeAwayLoading = false;
        showTickTakeAway = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 165,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cart",
                    style: CustomFont().pageLabel,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection(widget.userEmail)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  var data = snapshot.data!.docs[index];

                                  if (widget.userEmail == data['user_email']) {
                                    foodNameCheckOut =
                                        snapshot.data!.docs[index]['food_name'];
                                    foodQuantityCheckOut = snapshot
                                        .data!.docs[index]['quantity']
                                        .toString();

                                    foodPrice = snapshot
                                        .data!.docs[index]['price']
                                        .toString();

                                    foodTotalPrice = snapshot
                                        .data!.docs[index]['total_price']
                                        .toString();

                                    foodVendorEmail = snapshot.data!.docs[index]
                                        ['vendor_email'];

                                    foodCode =
                                        snapshot.data!.docs[index]['food_code'];

                                    foodType =
                                        snapshot.data!.docs[index]['food_type'];

                                    foodImage =
                                        snapshot.data!.docs[index]['image'];

                                    return CartComponent(
                                        image: data['image'],
                                        foodName: data['food_name'],
                                        quantity: data['quantity'].toString(),
                                        price: data['price'],
                                        totalPrice:
                                            data['total_price'].toString());
                                  }
                                },
                              ),
                              snapshot.data!.docs.isNotEmpty
                                  ? Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  dineInLoading = true;
                                                  takeAwayLoading = false;
                                                  showTickTakeAway = false;
                                                  dineInProgressIndicator();
                                                  isDineIn = "1";
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  dineInLoading == true
                                                      ? const CircularProgressIndicator()
                                                      : Container(
                                                          height: 100,
                                                          width: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  image:
                                                                      DecorationImage(
                                                                    image:
                                                                        AssetImage(
                                                                      showTickDineIn
                                                                          ? "assets/check-mark.png"
                                                                          : "assets/dine-in.png",
                                                                    ),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                  color: const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      224,
                                                                      150,
                                                                      22)),
                                                        ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  const Text(
                                                    "Dine In",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  )
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  dineInLoading = false;
                                                  takeAwayLoading = true;
                                                  showTickDineIn = false;
                                                  isDineIn = "0";
                                                  takeAwayProgressIndicator();
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  takeAwayLoading == true
                                                      ? CircularProgressIndicator()
                                                      : Container(
                                                          height: 100,
                                                          width: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  image:
                                                                      DecorationImage(
                                                                    image:
                                                                        AssetImage(
                                                                      showTickTakeAway
                                                                          ? "assets/check-mark.png"
                                                                          : "assets/take-away.png",
                                                                    ),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                  color: const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      156,
                                                                      33,
                                                                      243)),
                                                        ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  const Text(
                                                    "Take Away",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        CustomButton(
                                            buttonLabel: "Checkout",
                                            buttonFunction: () {
                                              var randomNum = Random();

                                              int code =
                                                  randomNum.nextInt(1000);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => PaymentScreen(
                                                          code: foodCode,
                                                          dineIn: isDineIn,
                                                          foodName:
                                                              foodNameCheckOut,
                                                          userEmail:
                                                              widget.userEmail,
                                                          foodVendorEmail:
                                                              foodVendorEmail,
                                                          foodImage: foodImage,
                                                          foodCode: foodCode,
                                                          price: foodPrice,
                                                          foodType: foodType,
                                                          quantity:
                                                              foodQuantityCheckOut,
                                                          totalPrice:
                                                              foodTotalPrice)));
                                            }),
                                      ],
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            "assets/shopping-bag.png",
                                            width: 100,
                                            height: 100,
                                          ),
                                          const Text("No order at the moment"),
                                        ],
                                      ),
                                    )
                            ],
                          );
                        }
                        return const SizedBox();
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
