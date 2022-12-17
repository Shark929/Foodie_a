import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/search_component.dart';
import 'package:foodie/components/search_input.dart';
import 'package:foodie/components/trending_component.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/cart_screen.dart';
import 'package:foodie/screens/location_screen.dart';
import 'package:foodie/screens/mall_screen.dart';
import 'package:foodie/screens/user_order_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userEmail;

  const HomeScreen({super.key, required this.userEmail});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String location = "";
  bool searchIsPressed = false;
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> locationData = [
    {
      "location_id": "1",
      "location": "Bukit Bintang",
      "image":
          "https://i.picsum.photos/id/10/2500/1667.jpg?hmac=J04WWC_ebchx3WwzbM-Z4_KC_LeLBWr5LZMaAkWkF68"
    },
    {
      "location_id": "2",
      "location": "Bukit Nenas",
      "image":
          "https://i.picsum.photos/id/13/2500/1667.jpg?hmac=SoX9UoHhN8HyklRA4A3vcCWJMVtiBXUg0W4ljWTor7s"
    },
    {
      "location_id": "3",
      "location": "Kota Damansara",
      "image":
          "https://i.picsum.photos/id/15/2500/1667.jpg?hmac=Lv03D1Y3AsZ9L2tMMC1KQZekBVaQSDc1waqJ54IHvo4"
    },
  ];
  CollectionReference locationRef =
      FirebaseFirestore.instance.collection("Location");

  void searchFunction(String searchText) {}
  @override
  Widget build(BuildContext context) {
    CollectionReference ref =
        FirebaseFirestore.instance.collection("Restaurants");
    CollectionReference cartRef =
        FirebaseFirestore.instance.collection(widget.userEmail);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 120,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/fork.png",
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Foodie",
                        style: CustomFont().pageLabel,
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        location = value;
                      });
                    },
                    controller: searchController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        hintText: "Search..."),
                  ),
                  location == ""
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 32,
                            ),
                            Text(
                              "Trending",
                              style: CustomFont().pageLabel,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              height: 250,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: ref.snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        return TrendingComponent(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserOrderScreen(
                                                    restaurantName: snapshot
                                                            .data!.docs[index]
                                                        ['restaurant_name'],
                                                    userName: widget.userEmail,
                                                    mall: snapshot.data!
                                                        .docs[index]['mall'],
                                                    image: snapshot.data!
                                                        .docs[index]['image'],
                                                    foodName: snapshot
                                                            .data!.docs[index]
                                                        ['food_name'],
                                                    price: snapshot.data!
                                                        .docs[index]['price'],
                                                    location: snapshot
                                                            .data!.docs[index]
                                                        ['location'],
                                                  ),
                                                ),
                                              );
                                            },
                                            title: snapshot.data!.docs[index]
                                                ['food_name'],
                                            location: snapshot.data!.docs[index]
                                                ['location'],
                                            image: snapshot.data!.docs[index]
                                                ['image']);
                                      },
                                    );
                                  }
                                  return const Text("There is no hot location");
                                },
                              ),
                            ),
                            Text(
                              "Hot Location",
                              style: CustomFont().pageLabel,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              height: 250,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: ref.snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        return TrendingComponent(
                                            title: snapshot.data!.docs[index]
                                                ['food_name'],
                                            location: snapshot.data!.docs[index]
                                                ['location'],
                                            image: snapshot.data!.docs[index]
                                                ['image']);
                                      },
                                    );
                                  }
                                  return Text("There is no hot location");
                                },
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            StreamBuilder(
                                stream: locationRef.snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.hasData) {
                                    for (int i = 0;
                                        i < snapshot.data!.docs.length;
                                        i++) {
                                      if (snapshot.data!.docs[i]['location']
                                          .toString()
                                          .toLowerCase()
                                          .startsWith(searchController.text
                                              .toLowerCase())) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LocationScreen(
                                                          userEmail:
                                                              widget.userEmail,
                                                          location: snapshot
                                                                  .data!.docs[i]
                                                              ['location'],
                                                          image: snapshot.data!
                                                              .docs[i]['image'],
                                                        )));
                                          },
                                          child: SearchComponent(
                                              image: snapshot.data!.docs[i]
                                                  ['image'],
                                              title: snapshot.data!.docs[i]
                                                  ['location']),
                                        );
                                      }
                                    }
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LocationScreen(
                                                            userEmail: widget
                                                                .userEmail,
                                                            location: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['location'],
                                                            image: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['image'],
                                                          )));
                                            },
                                            child: SearchComponent(
                                                image: snapshot
                                                    .data!.docs[index]['image'],
                                                title: snapshot.data!
                                                    .docs[index]['location']),
                                          );
                                        });
                                  }
                                  return Text("No Data");
                                })
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
