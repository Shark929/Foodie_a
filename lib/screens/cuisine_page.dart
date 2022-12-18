import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:foodie/components/menu_component.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/menu_customization_screen.dart';

class CuisinePage extends StatefulWidget {
  final String cuisine, userEmail;
  const CuisinePage(
      {super.key, required this.cuisine, required this.userEmail});

  @override
  State<CuisinePage> createState() => _CuisinePageState();
}

class _CuisinePageState extends State<CuisinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              widget.cuisine,
              style: CustomFont().pageLabel,
            ),
            const SizedBox(
              height: 16,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Restaurants")
                    .snapshots(),
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
                          if (snapshot.data!.docs[index]['cuisine_name'] ==
                              widget.cuisine) {
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
                              child: MenuComponent(
                                  image: snapshot.data!.docs[index]['image'],
                                  foodName: snapshot.data!.docs[index]
                                      ['food_name'],
                                  price: snapshot.data!.docs[index]['price'],
                                  category: snapshot.data!.docs[index]
                                      ['food_category'],
                                  code: snapshot.data!.docs[index]['food_code'],
                                  color: Colors.white),
                            );
                          }
                          return const SizedBox();
                        });
                  }
                  return Text("No Data Available at the moment");
                }),
          ],
        ),
      )),
    );
  }
}
