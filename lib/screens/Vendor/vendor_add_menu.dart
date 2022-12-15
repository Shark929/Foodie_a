import 'package:flutter/material.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/components/input_field.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/Vendor/vendor_screens.dart';

class VendorAddMenu extends StatefulWidget {
  const VendorAddMenu({super.key});

  @override
  State<VendorAddMenu> createState() => _VendorAddMenuState();
}

class _VendorAddMenuState extends State<VendorAddMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add Menu",
            style: CustomFont().pageLabel,
          ),
          const SizedBox(
            height: 100,
          ),
          Container(
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
                Text("Add a photo")
              ],
            ),
          ),
          InputField(
            hintText: "Food name",
          ),
          InputField(
            hintText: "Price",
          ),
          CustomButton(
              buttonLabel: "Confirm",
              buttonFunction: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VendorScreens()));
              })
        ],
      ),
    )));
  }
}
