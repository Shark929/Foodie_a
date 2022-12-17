import 'package:flutter/material.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/screens.dart';

class ReceiptScreen extends StatefulWidget {
  final String orderNum,
      vendorEmail,
      time,
      dineIn,
      foodName,
      email,
      image,
      price,
      totalPrice,
      quantity;
  const ReceiptScreen(
      {super.key,
      required this.orderNum,
      required this.vendorEmail,
      required this.time,
      required this.dineIn,
      required this.foodName,
      required this.email,
      required this.image,
      required this.price,
      required this.totalPrice,
      required this.quantity});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  widget.dineIn == "1"
                      ? Image.asset(
                          "assets/dine-in.png",
                          width: 50,
                          height: 50,
                          color: Colors.green,
                        )
                      : Image.asset(
                          "assets/take-away.png",
                          width: 50,
                          height: 50,
                          color: Colors.blue,
                        ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "#${widget.orderNum}",
                    style: CustomFont().pageLabel,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: NetworkImage(widget.image), fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                widget.foodName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ReceiptComponent(
                detail: widget.price,
                label: 'Price:',
              ),
              const SizedBox(
                height: 16,
              ),
              ReceiptComponent(
                detail: widget.quantity,
                label: 'Quantity:',
              ),
              const SizedBox(
                height: 16,
              ),
              ReceiptComponent(
                detail: widget.totalPrice,
                label: 'Total Price:',
              ),
              const SizedBox(
                height: 16,
              ),
              ReceiptComponent(
                detail: widget.time,
                label: 'Time:',
              ),
              const SizedBox(
                height: 16,
              ),
              ReceiptComponent(
                detail: widget.vendorEmail,
                label: 'Vendor Email:',
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                  buttonLabel: "Back to home",
                  buttonFunction: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Screens(
                                  userEmail: widget.email,
                                )),
                        (route) => false);
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}

class ReceiptComponent extends StatelessWidget {
  String label, detail;
  ReceiptComponent({super.key, required this.label, required this.detail});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        const SizedBox(
          width: 8,
        ),
        Text(
          detail,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
