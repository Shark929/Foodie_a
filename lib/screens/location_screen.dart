import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/mall_component.dart';
import 'package:foodie/screens/mall_screen.dart';

class LocationScreen extends StatefulWidget {
  final String location, image, userEmail;
  const LocationScreen(
      {super.key,
      required this.location,
      required this.image,
      required this.userEmail});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  CollectionReference restaurantRef =
      FirebaseFirestore.instance.collection("Mall");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.image), fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                widget.location,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                            if (snapshot.data!.docs[index]['location'] ==
                                widget.location) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MallScreen(
                                                userEmail: widget.userEmail,
                                                mall: snapshot.data!.docs[index]
                                                    ['mall_name'],
                                                image: snapshot
                                                    .data!.docs[index]['image'],
                                              )));
                                },
                                child: MallComponent(
                                    image: snapshot.data!.docs[index]['image'],
                                    mallName: snapshot.data!.docs[index]
                                        ['mall_name']),
                              );
                            }
                            return const SizedBox();
                          });
                    }
                    return Text("No data");
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
