import 'package:flutter/material.dart';

class CartComponent extends StatelessWidget {
  final String image, foodName, quantity, price, totalPrice;

  const CartComponent(
      {super.key,
      required this.image,
      required this.foodName,
      required this.quantity,
      required this.price,
      required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(children: [
        Container(
          width: 100,
          height: 80,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(8)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                foodName,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
              Text("Quantity: $quantity"),
              const SizedBox(
                height: 8,
              ),
              Text("RM $price"),
            ],
          ),
        ),
        const Spacer(),
        Text(
          "RM $totalPrice",
          style: const TextStyle(fontSize: 18),
        ),
      ]),
    );
  }
}
