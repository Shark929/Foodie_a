import 'package:flutter/material.dart';
import 'package:foodie/components/activity_component.dart';
import 'package:foodie/constants/text_constant.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  List activityList = [
    {
      "location": "Location A",
      "time": "14 Dec 2022, 2:18 AM",
      "total_price": "RM46.00",
    },
    {
      "location": "Location B",
      "time": "14 Dec 2022, 2:18 AM",
      "total_price": "RM88.00",
    },
    {
      "location": "Location C",
      "time": "14 Dec 2022, 2:18 AM",
      "total_price": "RM12.00",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: MediaQuery.of(context).size.height - 165,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Activity",
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
            ListView.builder(
                shrinkWrap: true,
                itemCount: activityList.length,
                itemBuilder: (context, index) {
                  return ActivityComponent(
                      location: activityList[index]['location'],
                      time: activityList[index]['time'],
                      price: activityList[index]['total_price']);
                }),
          ],
        ),
      ),
    );
  }
}
