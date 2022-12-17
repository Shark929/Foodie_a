import 'package:flutter/material.dart';

class ActivityComponent extends StatelessWidget {
  final String foodName, time, totalPrice, dineInCode, orderNum;

  const ActivityComponent({
    super.key,
    required this.time,
    required this.totalPrice,
    required this.foodName,
    required this.dineInCode,
    required this.orderNum,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          dineInCode == "1"
              ? Image.asset(
                  "assets/dine-in.png",
                  width: 40,
                  height: 40,
                  color: Colors.green,
                )
              : Image.asset(
                  "assets/take-away.png",
                  width: 40,
                  height: 40,
                  color: Colors.blue,
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
                "#$orderNum",
                style: TextStyle(
                    color: dineInCode == "0" ? Colors.blue : Colors.green),
              ),
              Text(
                time,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          Text(
            "RM $totalPrice",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
