import 'package:flutter/material.dart';
import 'package:foodie/constants/text_constant.dart';

class PromotionComponent extends StatelessWidget {
  final String amount, code, title;
  const PromotionComponent(
      {super.key,
      required this.amount,
      required this.code,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            width: 100,
            height: 80,
            margin: const EdgeInsets.only(bottom: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 212, 84, 29),
                borderRadius: BorderRadius.circular(8)),
            child: Text(
              "RM $amount",
              style: CustomFont().buttonText,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "# $code",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }
}
