import 'package:flutter/material.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/screens/activity_screen.dart';
import 'package:foodie/screens/home_screen.dart';
import 'package:foodie/screens/profile_screen.dart';

class Screens extends StatefulWidget {
  const Screens({super.key});

  @override
  State<Screens> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Screens> {
  bool isHome = true;
  bool isActivity = false;
  bool isProfile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            //screens go here
            isHome
                ? const HomeScreen()
                : isActivity
                    ? ActivityScreen()
                    : ProfileScreen(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.transparent,
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isHome = true;
                          isActivity = false;
                          isProfile = false;
                        });
                      },
                      child: Image.asset(
                        "assets/home.png",
                        color: isHome ? CustomColor().logoColor : Colors.black,
                        height: 30,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isHome = false;
                          isActivity = true;
                          isProfile = false;
                        });
                      },
                      child: Image.asset(
                        "assets/activity.png",
                        height: 30,
                        color:
                            isActivity ? CustomColor().logoColor : Colors.black,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isHome = false;
                          isActivity = false;
                          isProfile = true;
                        });
                      },
                      child: Image.asset(
                        "assets/user.png",
                        height: 30,
                        color:
                            isProfile ? CustomColor().logoColor : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
