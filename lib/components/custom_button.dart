import 'package:flutter/material.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/constants/text_constant.dart';

class CustomButton extends StatelessWidget {
  final String buttonLabel;
  final double? buttonWidth;
  final double? buttonHeight;
  final Color? color;
  final Function() buttonFunction;

  const CustomButton(
      {super.key,
      required this.buttonLabel,
      this.buttonWidth,
      this.buttonHeight,
      required this.buttonFunction,
      this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: buttonFunction,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color ?? CustomColor().buttonColor,
            borderRadius: BorderRadius.circular(8)),
        width: buttonWidth ?? MediaQuery.of(context).size.width,
        height: 40,
        child: Text(
          buttonLabel,
          style: CustomFont().buttonText,
        ),
      ),
    );
  }
}
