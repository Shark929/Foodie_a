import 'package:flutter/material.dart';

class TrendingComponent extends StatelessWidget {
  final String title, location, image;

  const TrendingComponent(
      {super.key,
      required this.title,
      required this.location,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            image,
            fit: BoxFit.fill,
            width: 250,
            height: 150,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            location,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
