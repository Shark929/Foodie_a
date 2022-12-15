import 'package:flutter/material.dart';

class DetailComponent extends StatelessWidget {
  final String label, detail;

  const DetailComponent({super.key, required this.label, required this.detail});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          Text(
            detail,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
