import 'package:flutter/material.dart';

class MenuComponent extends StatelessWidget {
  final String image, foodName, price;

  const MenuComponent(
      {super.key,
      required this.image,
      required this.foodName,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Image.asset(
            image,
            width: 100,
            height: 80,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                foodName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "RM ${price}",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }
}
