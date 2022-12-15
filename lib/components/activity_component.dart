import 'package:flutter/material.dart';

class ActivityComponent extends StatelessWidget {
  final String location, time, price;

  const ActivityComponent(
      {super.key,
      required this.location,
      required this.time,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(
            "assets/dish.png",
            width: 40,
            height: 40,
            color: Colors.green,
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location,
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                time,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          Text(price),
        ],
      ),
    );
  }
}
