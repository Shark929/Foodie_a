import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/sales_component.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/Vendor/vendor_details_screen.dart';

class VendorProfileScreen extends StatefulWidget {
  final String email, restaurantName, location, mall, unitNum;

  const VendorProfileScreen(
      {super.key,
      required this.email,
      required this.restaurantName,
      required this.location,
      required this.mall,
      required this.unitNum});
  @override
  State<VendorProfileScreen> createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> {
  CollectionReference orderRef = FirebaseFirestore.instance.collection("Order");
  double totalOrders = 0;
  int totalCustomer = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 100,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/user.png",
                    width: 50,
                    height: 50,
                    color: CustomColor().logoColor,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.restaurantName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VendorDetailsScreen(
                                      restaurantName: widget.restaurantName,
                                      email: widget.email,
                                      location: widget.location,
                                      mall: widget.mall,
                                      unitNum: widget.unitNum,
                                    )));
                      },
                      child: const Icon(Icons.more_vert)),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              StreamBuilder(
                  stream: orderRef.snapshots(),
                  builder: (context, snapshot) {
                    double totalRevenue = 0;

                    if (snapshot.hasData) {
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        if (snapshot.data!.docs[i]['vendor_email'] ==
                            widget.email) {
                          if (snapshot.data!.docs[i]['code'] == "3") {
                            totalRevenue += double.parse(
                                snapshot.data!.docs[i]['total_price']);
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
                              "Total Revenue",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "RM ${totalRevenue.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 24),
                            ),
                          ],
                        ),
                      );
                    }
                    return const Text("No data shown");
                  }),
              // StreamBuilder(
              //     stream: FirebaseFirestore.instance
              //         .collection("Withdrawal")
              //         .snapshots(),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return ListView.builder(
              //             itemCount: snapshot.data!.docs.length,
              //             itemBuilder: (context, index) {
              //               if (snapshot.data!.docs[index]['email'] ==
              //                       widget.email &&
              //                   snapshot.data!.docs[index]['balance'] ==
              //                       "0.00") {
              //                 snapshot.data!.docs[index].reference.update({
              //                   "balance": totalRevenue,
              //                 });
              //               }
              //             });
              //       }
              //       return const SizedBox();
              //     }),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Sales",
                style: CustomFont().pageLabel,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  StreamBuilder(
                      stream: orderRef.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          int counter = 0;
                          for (int i = 0; i < snapshot.data!.docs.length; i++) {
                            if (snapshot.data!.docs[i]['code'] == "3" &&
                                snapshot.data!.docs[i]['vendor_email'] ==
                                    widget.email) {
                              counter++;
                            }
                          }
                          return SalesComponent(
                            data: counter.toString(),
                            label: "Day",
                          );
                        }
                        return const Text(
                          "0",
                          style: TextStyle(fontSize: 36),
                        );
                      }),
                  const SizedBox(
                    width: 8,
                  ),
                  StreamBuilder(
                      stream: orderRef.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          int counter = 0;
                          for (int i = 0; i < snapshot.data!.docs.length; i++) {
                            if (snapshot.data!.docs[i]['code'] == "3" &&
                                snapshot.data!.docs[i]['vendor_email'] ==
                                    widget.email) {
                              counter++;
                            }
                          }
                          return SalesComponent(
                            data: counter.toString(),
                            label: "Month",
                          );
                        }
                        return const Text(
                          "0",
                          style: TextStyle(fontSize: 36),
                        );
                      }),
                  const SizedBox(
                    width: 8,
                  ),
                  StreamBuilder(
                      stream: orderRef.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          int counter = 0;
                          for (int i = 0; i < snapshot.data!.docs.length; i++) {
                            if (snapshot.data!.docs[i]['code'] == "3" &&
                                snapshot.data!.docs[i]['vendor_email'] ==
                                    widget.email) {
                              counter++;
                            }
                          }
                          return SalesComponent(
                            data: counter.toString(),
                            label: "Year",
                          );
                        }
                        return const Text(
                          "0",
                          style: TextStyle(fontSize: 36),
                        );
                      }),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              StreamBuilder(
                  stream: orderRef.snapshots(),
                  builder: (context, snapshot) {
                    int counter = 0;
                    if (snapshot.hasData) {
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        if (snapshot.data!.docs[i]['vendor_email'] ==
                            widget.email) {
                          counter++;
                        }
                      }

                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                            color: CustomColor().focusColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Total Orders",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              counter.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 36,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  }),
              const SizedBox(
                height: 18,
              ),
              StreamBuilder(
                  stream: orderRef.snapshots(),
                  builder: (context, snapshot) {
                    int counter = 0;
                    if (snapshot.hasData) {
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        if (snapshot.data!.docs[i]['vendor_email'] ==
                                widget.email &&
                            snapshot.data!.docs[i]['user_email'] != "") {
                          counter++;
                        }
                      }

                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                            color: CustomColor().focusColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Customers",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              counter.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 36,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  }),
              const SizedBox(
                height: 18,
              ),
              StreamBuilder(
                  stream: orderRef.snapshots(),
                  builder: (context, snapshot) {
                    int dineIn = 0;
                    int takeAway = 0;
                    int counter = 0;
                    if (snapshot.hasData) {
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        if (snapshot.data!.docs[i]['vendor_email'] ==
                            widget.email) {
                          counter++;
                        }
                        if (snapshot.data!.docs[i]['vendor_email'] ==
                                widget.email &&
                            snapshot.data!.docs[i]['dine_in'] == "1") {
                          dineIn++;
                        }
                      }

                      takeAway = counter - dineIn;
                      double takeAwayPercentage = (takeAway * 100) / counter;
                      double dineInPercentage = 100 - takeAwayPercentage;
                      return Row(
                        children: [
                          SalesComponent(
                            color: const Color.fromARGB(255, 51, 182, 64),
                            label: "Dine In",
                            data: "${dineInPercentage.toStringAsFixed(1)}%",
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          SalesComponent(
                            color: Color.fromARGB(255, 51, 84, 182),
                            label: "Take Away",
                            data: "${takeAwayPercentage.toStringAsFixed(1)}%",
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
