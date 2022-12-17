import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/screens.dart';

class MenuCustomizationScreen extends StatefulWidget {
  final String food_code,
      food_name,
      food_category,
      vendorEmail,
      image,
      price,
      userEmail;
  const MenuCustomizationScreen(
      {super.key,
      required this.food_code,
      required this.food_name,
      required this.food_category,
      required this.vendorEmail,
      required this.image,
      required this.price,
      required this.userEmail});

  @override
  State<MenuCustomizationScreen> createState() =>
      _MenuCustomizationScreenState();
}

class _MenuCustomizationScreenState extends State<MenuCustomizationScreen> {
  CollectionReference categoryRef =
      FirebaseFirestore.instance.collection("Category");
  CollectionReference customizationRef =
      FirebaseFirestore.instance.collection("Customization");
  List isChosen = [];
  String foodNameCart = "";
  String foodPriceCart = "";
  String foodTypeCart = "";
  int quantity = 1;
  double totalPrice = 0;
  String categoryCode = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                "Customization",
                style: CustomFont().pageLabel,
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
                      image: NetworkImage(widget.image), fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.food_name,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "RM ${widget.price}",
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              ),
              const SizedBox(
                height: 16,
              ),
              StreamBuilder(
                  stream: categoryRef.snapshots(),
                  builder: (context, snapshotC) {
                    if (snapshotC.hasData) {
                      for (int i = 0; i < snapshotC.data!.docs.length; i++) {
                        if (snapshotC.data!.docs[i]['category_name'] ==
                            widget.food_category) {
                          categoryCode =
                              snapshotC.data!.docs[i]['category_name'];
                        }
                      }
                      return StreamBuilder(
                          stream: customizationRef.snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    if (snapshot.data!.docs[index]
                                            ['category_id'] ==
                                        categoryCode) {
                                      for (int i = 0;
                                          i < snapshot.data!.docs.length;
                                          i++) {
                                        if (isChosen.isEmpty ||
                                            isChosen.length <
                                                snapshot.data!.docs.length) {
                                          isChosen.add("0");
                                        }
                                      }

                                      return Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (isChosen[index] == "0") {
                                                    setState(() {
                                                      isChosen[index] = "1";
                                                    });
                                                  } else {
                                                    setState(() {
                                                      isChosen[index] = "0";
                                                    });
                                                  }

                                                  if (isChosen[index] == "1") {
                                                    foodNameCart =
                                                        widget.food_name;
                                                    foodTypeCart = snapshot
                                                        .data!
                                                        .docs[index]['type'];
                                                  }
                                                },
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: isChosen[index] == "1"
                                                      ? Image.asset(
                                                          "assets/check-mark.png")
                                                      : Container(),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              Text(snapshot.data!.docs[index]
                                                  ['type']),
                                            ],
                                          ));
                                    } else {}
                                    return const SizedBox();
                                  });
                            }
                            return const SizedBox();
                          });
                    }
                    return const SizedBox();
                  }),
              const SizedBox(
                height: 16,
              ),
              const Text("Quantity: "),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (quantity > 1) {
                        setState(() {
                          quantity--;
                        });
                      }
                    },
                    child: Container(
                      width: 40,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                        "--",
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 60,
                    child: Text(
                      quantity.toString(),
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (quantity < 2 || quantity > 1) {
                        setState(() {
                          quantity++;
                        });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 40,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                        "+",
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                buttonLabel: "Add to cart",
                buttonFunction: () {
                  totalPrice = quantity * double.parse(widget.price);
                  FirebaseFirestore.instance.collection(widget.userEmail).add({
                    "food_name": widget.food_name,
                    "user_email": widget.userEmail,
                    "image": widget.image,
                    "food_code": widget.food_code,
                    "price": widget.price,
                    "food_type": foodTypeCart,
                    "quantity": quantity,
                    "total_price": totalPrice.toStringAsFixed(2),
                    "vendor_email": widget.vendorEmail,
                  }).then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Screens(
                                  userEmail: widget.userEmail,
                                )));
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
