import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/order_component.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/receipt_screen.dart';

class OrderScreen extends StatefulWidget {
  final String email;
  const OrderScreen({super.key, required this.email});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  CollectionReference orderRed = FirebaseFirestore.instance.collection("Order");
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 165,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
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
              SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: orderRed.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                if (snapshot.data!.docs[index]['code'] == "3" &&
                                    snapshot.data!.docs[index]
                                            ['vendor_email'] ==
                                        widget.email) {
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReceiptScreen(
                                                          cancel: false,
                                                          label: "Back",
                                                          buttonFunc: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          orderNum:
                                                              snapshot.data!.docs[index]['order_number']
                                                                  .toString(),
                                                          vendorEmail: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ['vendor_email'],
                                                          time: snapshot.data!.docs[index]
                                                              ['time'],
                                                          dineIn: snapshot.data!
                                                                  .docs[index]
                                                              ['dine_in'],
                                                          foodName: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ['food_name'],
                                                          email: snapshot.data!.docs[index]
                                                              ['user_email'],
                                                          image: snapshot.data!.docs[index]['image'],
                                                          price: snapshot.data!.docs[index]['price'],
                                                          totalPrice: snapshot.data!.docs[index]['total_price'],
                                                          quantity: snapshot.data!.docs[index]['quantity'])));
                                        },
                                        child: OrderComponent(
                                          foodName: snapshot.data!.docs[index]
                                              ['food_name'],
                                          dineIn: snapshot.data!.docs[index]
                                              ['dine_in'],
                                          orderNumber: snapshot
                                              .data!.docs[index]['order_number']
                                              .toString(),
                                          price: snapshot.data!.docs[index]
                                              ['total_price'],
                                        ),
                                      ));
                                } else if (snapshot.data!.docs[index]['code'] ==
                                        "4" &&
                                    snapshot.data!.docs[index]
                                            ['vendor_email'] ==
                                        widget.email) {
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ReceiptScreen(
                                                      label: "Back",
                                                      buttonFunc: () {
                                                        Navigator.pop(context);
                                                      },
                                                      cancel: true,
                                                      orderNum: snapshot
                                                          .data!
                                                          .docs[index]
                                                              ['order_number']
                                                          .toString(),
                                                      vendorEmail:
                                                          snapshot.data!.docs[index]
                                                              ['vendor_email'],
                                                      time: snapshot.data!.docs[index]
                                                          ['time'],
                                                      dineIn: snapshot.data!.docs[index]
                                                          ['dine_in'],
                                                      foodName:
                                                          snapshot.data!.docs[index]
                                                              ['food_name'],
                                                      email: snapshot.data!.docs[index]
                                                          ['user_email'],
                                                      image: snapshot.data!
                                                          .docs[index]['image'],
                                                      price: snapshot.data!.docs[index]['price'],
                                                      totalPrice: snapshot.data!.docs[index]['total_price'],
                                                      quantity: snapshot.data!.docs[index]['quantity']),
                                            ),
                                          );
                                        },
                                        child: OrderComponent(
                                          cancel: true,
                                          foodName: snapshot.data!.docs[index]
                                              ['food_name'],
                                          dineIn: snapshot.data!.docs[index]
                                              ['dine_in'],
                                          orderNumber: snapshot
                                              .data!.docs[index]['order_number']
                                              .toString(),
                                          price: snapshot.data!.docs[index]
                                              ['total_price'],
                                        ),
                                      ));
                                }
                                return const SizedBox();
                              });
                        }
                        return const Text("No data available at the moment");
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
