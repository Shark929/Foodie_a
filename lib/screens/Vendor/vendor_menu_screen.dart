import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/components/input_field.dart';
import 'package:foodie/components/menu_component.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/Vendor/vendor_add_menu.dart';

class MenuScreen extends StatefulWidget {
  final String location, email, mall;

  const MenuScreen(
      {super.key,
      required this.location,
      required this.email,
      required this.mall});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  TextEditingController foodNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  CollectionReference restaurantRefs =
      FirebaseFirestore.instance.collection("Restaurants");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My Menu",
              style: CustomFont().pageLabel,
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 550,
              child: StreamBuilder<QuerySnapshot>(
                  stream: restaurantRefs.snapshots(),
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
                                widget.email) {
                              return MenuComponent(
                                color: snapshot.data!.docs[index]['code'] == 2
                                    ? Colors.red
                                    : Colors.white,
                                onTap: () {
                                  foodNameController.text =
                                      snapshot.data!.docs[index]['food_name'];
                                  priceController.text =
                                      snapshot.data!.docs[index]['price'];
                                  showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ListView(
                                                shrinkWrap: true,
                                                children: [
                                                  InputField(
                                                    controller:
                                                        foodNameController,
                                                    hintText:
                                                        foodNameController.text,
                                                  ),
                                                  InputField(
                                                    controller: priceController,
                                                    hintText:
                                                        priceController.text,
                                                  ),
                                                  CustomButton(
                                                      color: Colors.green,
                                                      buttonLabel: "Update",
                                                      buttonFunction: () {
                                                        snapshot
                                                            .data!
                                                            .docs[index]
                                                            .reference
                                                            .update({
                                                          "food_name":
                                                              foodNameController
                                                                  .text,
                                                          "price":
                                                              priceController
                                                                  .text
                                                        }).whenComplete(() =>
                                                                Navigator.pop(
                                                                    context));
                                                      }),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  CustomButton(
                                                      buttonLabel: "Delete",
                                                      buttonFunction: () {
                                                        snapshot
                                                            .data!
                                                            .docs[index]
                                                            .reference
                                                            .delete()
                                                            .whenComplete(
                                                              () =>
                                                                  Navigator.pop(
                                                                      context),
                                                            );
                                                      }),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  CustomButton(
                                                      color: Colors.amber,
                                                      buttonLabel:
                                                          "Not Available",
                                                      buttonFunction: () {
                                                        snapshot
                                                            .data!
                                                            .docs[index]
                                                            .reference
                                                            .update({
                                                          "code": "2"
                                                        }).whenComplete(
                                                          () => Navigator.pop(
                                                              context),
                                                        );
                                                      }),
                                                ],
                                              ),
                                            ),
                                          ));
                                },
                                image: snapshot.data!.docs[index]['image'],
                                foodName: snapshot.data!.docs[index]
                                    ['food_name'],
                                price: snapshot.data!.docs[index]['price'],
                                category: snapshot.data!.docs[index]
                                    ['food_category'],
                                code: snapshot.data!.docs[index]['food_code'],
                              );
                            }
                            return const SizedBox();
                          });
                    }
                    return const Text("There is no suggestion at the moment");
                  }),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VendorAddMenu(
                              location: widget.location,
                              email: widget.email,
                              mall: widget.mall,
                            )));
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: CustomColor().buttonColor),
                child: Text(
                  "Add Menu",
                  style: CustomFont().buttonText,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
