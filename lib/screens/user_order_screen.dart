// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/components/details_component.dart';
import 'package:foodie/screens/cart_screen.dart';

class UserOrderScreen extends StatefulWidget {
  final String foodName, location, price, image, mall, userName, restaurantName;

  const UserOrderScreen(
      {super.key,
      required this.foodName,
      required this.location,
      required this.price,
      required this.image,
      required this.mall,
      required this.userName,
      required this.restaurantName});

  @override
  State<UserOrderScreen> createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends State<UserOrderScreen> {
  TextEditingController quantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
              ),
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.image), fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              DetailComponent(
                  label: "Restaurant", detail: widget.restaurantName),
              DetailComponent(label: "Food Name", detail: widget.foodName),
              DetailComponent(label: "Price", detail: widget.price),
              DetailComponent(label: "Mall", detail: widget.mall),
              DetailComponent(label: "Location", detail: widget.location),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const Text(
                    "Quantity: ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                      width: 50,
                      child: TextField(
                        controller: quantityController,
                      )),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                  buttonLabel: "Add to cart",
                  buttonFunction: () {
                    double totalPrice = double.parse(widget.price) *
                        double.parse(quantityController.text);
                    FirebaseFirestore.instance.collection(widget.userName).add({
                      "image": widget.image,
                      "user_name": widget.userName,
                      "food_name": widget.foodName,
                      "restaurant_name": widget.restaurantName,
                      "price": widget.price,
                      "quantity": quantityController.text,
                      "total_price": totalPrice.toString(),
                    }).then((value) {
                      print(value.id);
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CartScreen(
                                    userEmail: widget.userName,
                                  )));
                    }).catchError((err) => print("Failed to add new data"));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
