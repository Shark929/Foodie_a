import 'package:flutter/material.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/screens/Vendor/vendor_home_screen.dart';
import 'package:foodie/screens/Vendor/vendor_menu_screen.dart';
import 'package:foodie/screens/Vendor/vendor_order_screen.dart';
import 'package:foodie/screens/Vendor/vendor_profile_screen.dart';

class VendorScreens extends StatefulWidget {
  const VendorScreens({super.key});

  @override
  State<VendorScreens> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<VendorScreens> {
  bool isHome = true;
  bool isMenu = false;
  bool isProfile = false;
  bool isOrder = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            //screens go here
            isHome
                ? const VendorHomeScreen()
                : isMenu
                    ? const MenuScreen()
                    : isProfile
                        ? VendorProfileScreen()
                        : const OrderScreen(),
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
                          isMenu = false;
                          isProfile = false;
                          isOrder = false;
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
                          isMenu = true;
                          isProfile = false;
                          isOrder = false;
                        });
                      },
                      child: Image.asset(
                        "assets/activity.png",
                        height: 30,
                        color: isMenu ? CustomColor().logoColor : Colors.black,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isHome = false;
                          isMenu = false;
                          isProfile = false;
                          isOrder = true;
                        });
                      },
                      child: Image.asset(
                        "assets/order-food.png",
                        height: 30,
                        color: isOrder ? CustomColor().logoColor : Colors.black,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isHome = false;
                          isMenu = false;
                          isProfile = true;
                          isOrder = false;
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
