import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/menu_component.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/menu_customization_screen.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final String restaurant, vendorEmail, userEmail;
  const RestaurantDetailScreen(
      {super.key,
      required this.restaurant,
      required this.vendorEmail,
      required this.userEmail});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  CollectionReference restaurantRef =
      FirebaseFirestore.instance.collection("Restaurants");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              "${widget.restaurant} Menu",
              style: CustomFont().pageLabel,
            ),
            const SizedBox(
              height: 16,
            ),
            StreamBuilder(
                stream: restaurantRef.snapshots(),
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
                          if (snapshot.data!.docs[index]['email'] ==
                              widget.vendorEmail) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MenuCustomizationScreen(
                                            userEmail: widget.userEmail,
                                            price: snapshot.data!.docs[index]
                                                ['price'],
                                            image: snapshot.data!.docs[index]
                                                ['image'],
                                            food_code: snapshot
                                                .data!.docs[index]['food_code'],
                                            food_name: snapshot
                                                .data!.docs[index]['food_name'],
                                            food_category: snapshot.data!
                                                .docs[index]['food_category'],
                                            vendorEmail: snapshot
                                                .data!.docs[index]['email'])));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: MenuComponent(
                                  category: snapshot.data!.docs[index]
                                      ['food_category'],
                                  code: snapshot.data!.docs[index]['food_code'],
                                  color: Colors.white,
                                  foodName: snapshot.data!.docs[index]
                                      ['food_name'],
                                  image: snapshot.data!.docs[index]['image'],
                                  price: snapshot.data!.docs[index]['price'],
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        });
                  }
                  return const SizedBox();
                })
          ],
        ),
      )),
    );
  }
}
