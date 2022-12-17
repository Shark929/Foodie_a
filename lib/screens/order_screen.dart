import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/activity_component.dart';
import 'package:foodie/constants/text_constant.dart';

class OrderScreen extends StatefulWidget {
  final String userEmail;
  const OrderScreen({super.key, required this.userEmail});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  CollectionReference orderRef = FirebaseFirestore.instance.collection("Order");
  @override
  Widget build(BuildContext context) {
    print(widget.userEmail);
    return Container(
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
                          return ActivityComponent(
                              orderNum: snapshot
                                  .data!.docs[index]['order_number']
                                  .toString(),
                              time: snapshot.data!.docs[index]['time'],
                              totalPrice: snapshot.data!.docs[index]
                                  ['total_price'],
                              foodName: snapshot.data!.docs[index]['food_name'],
                              dineInCode: snapshot.data!.docs[index]
                                  ['dine_in']);
                        }
                      },
                    );
                  }

                  return SizedBox();
                })
          ],
        ),
      ),
    );
  }
}
