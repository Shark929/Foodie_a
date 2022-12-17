import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/components/input_field.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:image_picker/image_picker.dart';

class VendorAddMenu extends StatefulWidget {
  final String location, email, mall;

  const VendorAddMenu(
      {super.key,
      required this.location,
      required this.email,
      required this.mall});

  @override
  State<VendorAddMenu> createState() => _VendorAddMenuState();
}

class _VendorAddMenuState extends State<VendorAddMenu> {
  TextEditingController foodNameController = TextEditingController();
  TextEditingController foodCodeController = TextEditingController();
  TextEditingController foodCategoryController = TextEditingController();
  TextEditingController foodDescriptionController = TextEditingController();

  TextEditingController priceController = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  XFile? file;
  String imageUrl = "";
  bool isLoading = false;
  bool canUpload = false;
  void pickImage() async {
    isLoading = true;
    file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
    // upload to firebase storage
    // get a reference to storage root
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('image');

    //create a reference for the image to be stored
    Reference referenceImageToUpload = referenceDirImages.child(uniqueName);

    //handle errors
    try {
      //Store the file
      await referenceImageToUpload.putFile(File(file!.path));

      imageUrl = await referenceImageToUpload.getDownloadURL();
      if (imageUrl != null) {
        setState(() {
          isLoading = false;
          canUpload = true;
        });
      }
      print(imageUrl);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Menu",
              style: CustomFont().pageLabel,
            ),
            const SizedBox(
              height: 30,
            ),
            imageUrl.isNotEmpty
                ? Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage(imageUrl), fit: BoxFit.cover)),
                  )
                : InkWell(
                    onTap: pickImage,
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add),
                          SizedBox(
                            height: 16,
                          ),
                          Text("Add a food picture")
                        ],
                      ),
                    ),
                  ),
            InputField(
              controller: foodNameController,
              hintText: "Item Name",
            ),
            InputField(
              controller: foodCodeController,
              hintText: "Item Code",
            ),
            InputField(
              controller: foodCategoryController,
              hintText: "Item Category",
            ),
            InputField(
              controller: foodDescriptionController,
              hintText: "Item Description",
            ),
            InputField(
              controller: priceController,
              hintText: "Price",
            ),
            CustomButton(
                buttonLabel: "Confirm",
                buttonFunction: () {
                  FirebaseFirestore.instance.collection("Restaurants").add({
                    "food_name": foodNameController.text,
                    "food_code": foodCodeController.text,
                    "food_category": foodCategoryController.text,
                    "food_description": foodDescriptionController.text,
                    "price": priceController.text,
                    "location": widget.location,
                    "image": imageUrl,
                    "email": widget.email,
                    "mall": widget.mall,
                    "code": "1",
                  }).then((value) {
                    print(value.id);
                    Navigator.pop(context);
                  }).catchError((err) => print("Failed to add new data"));
                })
          ],
        ),
      ),
    )));
  }
}
