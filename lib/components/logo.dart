import 'package:flutter/material.dart';
import 'package:foodie/constants/color_constant.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: CustomColor().logoColor),
      alignment: Alignment.center,
      child: Image.asset(
        "assets/fork.png",
        width: 100.0,
      ),
    );
  }
}
