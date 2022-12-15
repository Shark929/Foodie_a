import 'package:flutter/material.dart';
import 'package:foodie/components/order_component.dart';
import 'package:foodie/constants/text_constant.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List orderList = [
    {
      "food_name": "Garlic Chicken",
      "order_number": "98712",
      "total_price": "RM46.00",
      "order_code": 1,
    },
    {
      "food_name": "Garlic Chicken",
      "order_number": "98712",
      "total_price": "RM46.00",
      "order_code": 2,
    },
    {
      "food_name": "Garlic Chicken",
      "order_number": "98712",
      "total_price": "RM46.00",
      "order_code": 1,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 165,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order",
                style: CustomFont().pageLabel,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Recent",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 200,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: orderList.length,
                    itemBuilder: (context, index) {
                      return OrderComponent(
                        orderCode: orderList[index]['order_code'],
                        foodName: orderList[index]['food_name'],
                        orderNumber: orderList[index]['order_number'],
                        price: orderList[index]['total_price'],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
