import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/restaurant_component.dart';
import 'package:foodie/screens/restaurant_detail_screen.dart';

class MallScreen extends StatefulWidget {
  final String mall, image, userEmail;
  const MallScreen(
      {super.key,
      required this.mall,
      required this.image,
      required this.userEmail});

  @override
  State<MallScreen> createState() => _MallScreenState();
}

class _MallScreenState extends State<MallScreen> {
  CollectionReference vendorRef =
      FirebaseFirestore.instance.collection("Vendor");
  @override
  Widget build(BuildContext context) {
    print(widget.mall);
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
                      image: NetworkImage(widget.image != ""
                          ? widget.image
                          : "https://i.picsum.photos/id/57/2448/3264.jpg?hmac=ewraXYesC6HuSEAJsg3Q80bXd1GyJTxekI05Xt9YjfQ"),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                widget.mall,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 16,
              ),
              StreamBuilder(
                  stream: vendorRef.snapshots(),
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
                            if (snapshot.data!.docs[index]['mall'] ==
                                widget.mall) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RestaurantDetailScreen(
                                                  userEmail: widget.userEmail,
                                                  restaurant:
                                                      snapshot.data!.docs[index]
                                                          ['restaurant'],
                                                  vendorEmail: snapshot.data!
                                                      .docs[index]['email'])));
                                },
                                child: RestaurantComponent(
                                  location: snapshot.data!.docs[index]
                                      ['location'],
                                  restaurantName: snapshot.data!.docs[index]
                                      ['restaurant'],
                                  image: snapshot.data!.docs[index]['image'],
                                ),
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
