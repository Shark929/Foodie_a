import 'package:flutter/material.dart';
import 'package:foodie/components/search_input.dart';
import 'package:foodie/components/trending_component.dart';
import 'package:foodie/constants/text_constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List trendingList = [
    {
      "Title": "Korean BBQ Chicken",
      "Location": "Location A",
      "Image": "assets/chicken.jpg"
    },
    {
      "Title": "BreadBoss",
      "Location": "Location B",
      "Image": "assets/breadBoss.jpg"
    },
    {
      "Title": "Spanish Foods",
      "Location": "Location C",
      "Image": "assets/spaggheti.jpg"
    },
    {
      "Title": "Famous Mamak",
      "Location": "Location D",
      "Image": "assets/meeMamak.jpg"
    },
    {
      "Title": "Homemade Burger",
      "Location": "Location E",
      "Image": "assets/burger.jpg"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 120,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/fork.png",
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Foodie",
                        style: CustomFont().pageLabel,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const SearchInput(),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    "Trending",
                    style: CustomFont().pageLabel,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: trendingList.length,
                      itemBuilder: (context, index) {
                        return TrendingComponent(
                          image: trendingList[index]['Image'],
                          location: trendingList[index]['Location'],
                          title: trendingList[index]['Title'],
                        );
                      },
                    ),
                  ),
                  Text(
                    "Hot Location",
                    style: CustomFont().pageLabel,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: trendingList.length,
                      itemBuilder: (context, index) {
                        return TrendingComponent(
                          image: trendingList[index]['Image'],
                          location: trendingList[index]['Location'],
                          title: trendingList[index]['Title'],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
