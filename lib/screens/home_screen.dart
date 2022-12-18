import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/search_component.dart';
import 'package:foodie/components/trending_component.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/cuisine_page.dart';
import 'package:foodie/screens/location_screen.dart';
import 'package:foodie/screens/menu_customization_screen.dart';
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

  CollectionReference locationRef =
      FirebaseFirestore.instance.collection("Location");

  void searchFunction(String searchText) {}
  @override
  Widget build(BuildContext context) {
    CollectionReference restaurantRef =
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("Cuisine")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const SizedBox();
                                  }
                                  if (snapshot.hasData) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => CuisinePage(
                                                            userEmail: widget
                                                                .userEmail,
                                                            cuisine: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                [
                                                                'cuisine_name'])));
                                              },
                                              child: Container(
                                                height: 30,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                margin: const EdgeInsets.only(
                                                    right: 8),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: CustomColor()
                                                        .buttonColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Text(
                                                  snapshot.data!.docs[index]
                                                      ['cuisine_name'],
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            );
                                          }),
                                    );
                                  }
                                  return const SizedBox();
                                }),
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
                                stream: restaurantRef.snapshots(),
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
                                                      builder: (context) => MenuCustomizationScreen(
                                                          food_code: snapshot.data!.docs[index]
                                                              ['food_code'],
                                                          food_name: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ['food_name'],
                                                          food_category: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ['food_category'],
                                                          vendorEmail: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ['email'],
                                                          image: snapshot.data!
                                                              .docs[index]['image'],
                                                          price: snapshot.data!.docs[index]['price'],
                                                          userEmail: widget.userEmail)));
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
                                stream: FirebaseFirestore.instance
                                    .collection("Location")
                                    .snapshots(),
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
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LocationScreen(
                                                            location: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['location'],
                                                            image: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['image'],
                                                            userEmail: widget
                                                                .userEmail)));
                                          },
                                          child: TrendingComponent(
                                              title: snapshot.data!.docs[index]
                                                  ['location'],
                                              location: "",
                                              image: snapshot.data!.docs[index]
                                                  ['image']),
                                        );
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
