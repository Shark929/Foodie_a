import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/components/details_component.dart';
import 'package:foodie/components/input_field.dart';
import 'package:foodie/components/vertical_details_component.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/screens/Vendor/vendor_wallet_screen.dart';
import 'package:foodie/screens/choose_role_login_screen.dart';

class VendorDetailsScreen extends StatefulWidget {
  final String email, restaurantName, location, mall, unitNum;

  const VendorDetailsScreen(
      {super.key,
      required this.email,
      required this.restaurantName,
      required this.location,
      required this.mall,
      required this.unitNum});
  @override
  State<VendorDetailsScreen> createState() => _VendorDetailsScreenState();
}

class _VendorDetailsScreenState extends State<VendorDetailsScreen> {
  CollectionReference vendorDetailRef =
      FirebaseFirestore.instance.collection("Vendor_details");

  CollectionReference vendorRef =
      FirebaseFirestore.instance.collection("Vendor");
  bool isOpen = true;
  TextEditingController bioController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
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
                          StreamBuilder(
                              stream: vendorRef.snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  for (int i = 0;
                                      i < snapshot.data!.docs.length;
                                      i++) {
                                    if (snapshot.data!.docs[i]['email'] ==
                                        widget.email) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            isOpen = !isOpen;
                                            if (isOpen == false) {
                                              snapshot.data!.docs[i].reference
                                                  .update({
                                                "code": "3",
                                              });
                                            } else {
                                              snapshot.data!.docs[i].reference
                                                  .update({
                                                "code": "2",
                                              });
                                            }
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8.0, top: 8, bottom: 8),
                                          child: isOpen
                                              ? const Text(
                                                  "Open",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )
                                              : const Text(
                                                  "Closed",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.red),
                                                ),
                                        ),
                                      );
                                    }
                                  }
                                }
                                return SizedBox();
                              })
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      VendorWalletScreen(email: widget.email)));
                        },
                        child: Image.asset(
                          "assets/wallet.png",
                          width: 30,
                          height: 30,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DetailComponent(label: "Email", detail: widget.email),
                  DetailComponent(label: "Location", detail: widget.location),
                  DetailComponent(label: "Mall", detail: widget.mall),
                  DetailComponent(label: "Unit No", detail: widget.unitNum),
                  const SizedBox(
                    height: 16,
                  ),
                  StreamBuilder(
                      stream: vendorDetailRef.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                if (snapshot.data!.docs[index]['email'] ==
                                    widget.email) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      VertDetailsComponent(
                                        title: "Bio",
                                        details: snapshot.data!.docs[index]
                                            ['bio'],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      VertDetailsComponent(
                                        title: "Description",
                                        details: snapshot.data!.docs[index]
                                            ['description'],
                                      )
                                    ],
                                  );
                                }
                                return SizedBox();
                              });
                        }
                        return SizedBox();
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  StreamBuilder(
                      stream: vendorDetailRef.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                if (snapshot.data!.docs[index]['email'] ==
                                    widget.email) {
                                  return Column(
                                    children: [
                                      CustomButton(
                                          color: Colors.blueAccent,
                                          buttonLabel: "Edit",
                                          buttonFunction: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) => Dialog(
                                                      child: Container(
                                                        height: 300,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 16),
                                                        child: Column(
                                                          children: [
                                                            InputField(
                                                              controller:
                                                                  bioController,
                                                              hintText: snapshot
                                                                      .data!
                                                                      .docs[
                                                                  index]['bio'],
                                                            ),
                                                            InputField(
                                                              controller:
                                                                  descriptionController,
                                                              hintText: snapshot
                                                                          .data!
                                                                          .docs[
                                                                      index][
                                                                  'description'],
                                                            ),
                                                            CustomButton(
                                                                buttonLabel:
                                                                    "Save",
                                                                buttonFunction:
                                                                    () {
                                                                  snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .reference
                                                                      .update({
                                                                    "bio":
                                                                        bioController
                                                                            .text,
                                                                    "description":
                                                                        descriptionController
                                                                            .text
                                                                  }).then((value) =>
                                                                          Navigator.pop(
                                                                              context));
                                                                }),
                                                          ],
                                                        ),
                                                      ),
                                                    ));
                                          }),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      CustomButton(
                                          color: Colors.grey,
                                          buttonLabel: "Logout",
                                          buttonFunction: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ChooseRoleLoginScreen()));
                                          }),
                                    ],
                                  );
                                }
                                return const SizedBox();
                              });
                        }
                        return SizedBox();
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
