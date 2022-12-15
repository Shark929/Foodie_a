import 'package:flutter/material.dart';
import 'package:foodie/components/menu_component.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/Vendor/vendor_add_menu.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List menuList = [
    {
      "image": "assets/chicken.jpg",
      "food_name": "Garlic Chicken",
      "price": "15.90",
    },
    {
      "image": "assets/chicken.jpg",
      "food_name": "Garlic Chicken",
      "price": "15.90",
    },
    {
      "image": "assets/chicken.jpg",
      "food_name": "Garlic Chicken",
      "price": "15.90",
    },
    {
      "image": "assets/chicken.jpg",
      "food_name": "Garlic Chicken",
      "price": "15.90",
    },
    {
      "image": "assets/chicken.jpg",
      "food_name": "Garlic Chicken",
      "price": "15.90",
    },
    {
      "image": "assets/chicken.jpg",
      "food_name": "Garlic Chicken",
      "price": "15.90",
    },
    {
      "image": "assets/chicken.jpg",
      "food_name": "Garlic Chicken",
      "price": "15.90",
    },
    {
      "image": "assets/chicken.jpg",
      "food_name": "Garlic Chicken",
      "price": "15.90",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: menuList.length,
                itemBuilder: (context, index) {
                  return MenuComponent(
                    foodName: menuList[index]['food_name'],
                    price: menuList[index]['price'],
                    image: menuList[index]['image'],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VendorAddMenu()));
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
