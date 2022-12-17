import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/components/details_component.dart';
import 'package:foodie/components/input_field.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/Vendor/vendor_approval_screen.dart';
import 'package:foodie/screens/Vendor/vendor_screens.dart';
import 'package:foodie/service/user_value.dart';
import 'package:foodie/service/vendor_value.dart';

class RegisterVendorScreen extends StatefulWidget {
  final String? name, email, phoneNum;

  const RegisterVendorScreen({super.key, this.name, this.email, this.phoneNum});

  @override
  State<RegisterVendorScreen> createState() => _RegisterVendorScreenState();
}

class _RegisterVendorScreenState extends State<RegisterVendorScreen> {
  TextEditingController restaurantNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController mallController = TextEditingController();
  TextEditingController unitNumberController = TextEditingController();
  CollectionReference userRefs = FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: userRefs.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      if (snapshot.data!.docs[i]['user_email'] ==
                          widget.email) {
                        return Container(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "New Vendor",
                                style: CustomFont().pageLabel,
                              ),
                              DetailComponent(
                                  label: "Name",
                                  detail: widget.name.toString()),
                              DetailComponent(
                                  label: "Email",
                                  detail: widget.email.toString()),
                              DetailComponent(
                                  label: "Phone",
                                  detail: widget.phoneNum.toString()),
                              InputField(
                                controller: restaurantNameController,
                                hintText: "Restaurant Name",
                              ),
                              InputField(
                                controller: locationController,
                                hintText: "Location",
                              ),
                              InputField(
                                controller: mallController,
                                hintText: "Mall",
                              ),
                              InputField(
                                controller: unitNumberController,
                                hintText: "Unit Number",
                              ),
                              CustomButton(
                                  buttonLabel: "Register As Vendor",
                                  buttonFunction: () async {
                                    snapshot.data!.docs[i].reference.update({
                                      "code": 2,
                                    });
                                    vendorValue.setString(
                                      restaurantName1:
                                          restaurantNameController.text,
                                      location1: locationController.text,
                                      mall1: mallController.text,
                                      unitNum1: unitNumberController.text,
                                      email1: widget.email.toString(),
                                    );
                                    FirebaseFirestore.instance
                                        .collection("Vendor_details")
                                        .add({
                                      "bio": "",
                                      "description": "",
                                      "email": widget.email.toString(),
                                    });
                                    FirebaseFirestore.instance
                                        .collection("Vendor")
                                        .add({
                                      "restaurant_name":
                                          restaurantNameController.text,
                                      "location": locationController.text,
                                      "Mall": mallController.text,
                                      "unit_number": unitNumberController.text,
                                      "email": widget.email.toString(),
                                    }).then((value) {
                                      print(value.id);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const VendorApprovalScreen()));
                                    }).catchError((err) =>
                                            print("Failed to add new data"));
                                  }),
                            ],
                          ),
                        );
                      }
                    }
                  }
                  return SizedBox();
                }),
          ],
        ),
      ),
    );
  }
}
