import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/constants/text_constant.dart';

class VendorHomeScreen extends StatefulWidget {
  final String email;

  const VendorHomeScreen({super.key, required this.email});

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {
  double size = 80;
  bool activeOrder = false;
  bool newOrder = true;
  bool completedOrder = false;
  CollectionReference orderRef = FirebaseFirestore.instance.collection("Order");
  CollectionReference restaurantRef =
      FirebaseFirestore.instance.collection("Restaurant");
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      height: MediaQuery.of(context).size.height - 165,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Restaurant",
                style: CustomFont().pageLabel,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder(
                            stream: orderRef.snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                int counter = 0;
                                for (int i = 0;
                                    i < snapshot.data!.docs.length;
                                    i++) {
                                  if (snapshot.data!.docs[i]['code'] == "1" &&
                                      snapshot.data!.docs[i]['vendor_email'] ==
                                          widget.email) {
                                    counter++;
                                  }
                                }
                                return Text(
                                  counter.toString(),
                                  style: const TextStyle(fontSize: 36),
                                );
                              }
                              return const Text(
                                "0",
                                style: TextStyle(fontSize: 36),
                              );
                            }),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "New",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder(
                            stream: orderRef.snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                int counter = 0;
                                for (int i = 0;
                                    i < snapshot.data!.docs.length;
                                    i++) {
                                  if (snapshot.data!.docs[i]['code'] == "2" &&
                                      snapshot.data!.docs[i]['vendor_email'] ==
                                          widget.email) {
                                    counter++;
                                  }
                                }
                                return Text(
                                  counter.toString(),
                                  style: const TextStyle(fontSize: 36),
                                );
                              }
                              return const Text(
                                "0",
                                style: TextStyle(fontSize: 36),
                              );
                            }),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "Active",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder(
                            stream: orderRef.snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                int counter = 0;
                                for (int i = 0;
                                    i < snapshot.data!.docs.length;
                                    i++) {
                                  if (snapshot.data!.docs[i]['code'] == "3" &&
                                      snapshot.data!.docs[i]['vendor_email'] ==
                                          widget.email) {
                                    counter++;
                                  }
                                }
                                return Text(
                                  counter.toString(),
                                  style: const TextStyle(fontSize: 36),
                                );
                              }
                              return const Text(
                                "0",
                                style: TextStyle(fontSize: 36),
                              );
                            }),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "Completed",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Order",
                style: CustomFont().pageLabel,
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                  height: MediaQuery.of(context).size.height - 350,
                  child: StreamBuilder(
                    stream: orderRef.snapshots(),
                    builder: (context, orderSnapshot) {
                      if (orderSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (orderSnapshot.hasData) {
                        if (orderSnapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: orderSnapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                if (orderSnapshot.data!.docs[index]
                                            ['vendor_email'] ==
                                        widget.email &&
                                    orderSnapshot.data!.docs[index]['code'] ==
                                        "1") {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Row(children: [
                                      Container(
                                        height: 80,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                              image: NetworkImage(orderSnapshot
                                                  .data!.docs[index]['image']),
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            orderSnapshot.data!.docs[index]
                                                ['food_name'],
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                              "# ${orderSnapshot.data!.docs[index]['order_number']}"),
                                        ],
                                      ),
                                      const Spacer(),
                                      newOrder == true
                                          ? InkWell(
                                              onTap: () {
                                                setState(() {
                                                  newOrder = false;
                                                  activeOrder = true;
                                                  completedOrder = false;
                                                  orderSnapshot.data!
                                                      .docs[index].reference
                                                      .update({"code": "2"});
                                                });
                                              },
                                              child: Container(
                                                  width: 100,
                                                  alignment: Alignment.center,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: const Text("New")),
                                            )
                                          : activeOrder == true
                                              ? InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      newOrder = false;
                                                      activeOrder = false;
                                                      completedOrder = true;
                                                      orderSnapshot.data!
                                                          .docs[index].reference
                                                          .update(
                                                              {"code": "3"});
                                                    });
                                                  },
                                                  child: Container(
                                                      width: 100,
                                                      alignment:
                                                          Alignment.center,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          color: Colors.blue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child:
                                                          const Text("Active")),
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                      width: 100,
                                                      alignment:
                                                          Alignment.center,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: const Text(
                                                          "Completed")),
                                                )
                                    ]),
                                  );
                                }
                                return const SizedBox();
                              });
                        }
                        return const Text("No data available at the moment");
                      }
                      return const SizedBox();
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
