import 'package:flutter/material.dart';

class OrderComponent extends StatelessWidget {
  final String foodName, orderNumber, price, dineIn;
  const OrderComponent(
      {super.key,
      required this.foodName,
      required this.orderNumber,
      required this.price,
      required this.dineIn});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(
            dineIn == "1" ? "assets/dine-in.png" : "assets/take-away.png",
            width: 40,
            height: 30,
            color: Colors.green,
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                foodName,
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                orderNumber,
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
          const Spacer(),
          Text(
            "RM $price",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
