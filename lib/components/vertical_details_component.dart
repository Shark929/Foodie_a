import 'package:flutter/material.dart';

class VertDetailsComponent extends StatelessWidget {
  final String? title, details;
  const VertDetailsComponent({super.key, this.title, this.details});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          details ?? "",
        ),
      ],
    );
  }
}
