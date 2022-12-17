import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/screens/order_screen.dart';
import 'package:foodie/screens/cart_screen.dart';
import 'package:foodie/screens/home_screen.dart';
import 'package:foodie/screens/profile_screen.dart';

class Screens extends StatefulWidget {
  final String userEmail;

  const Screens({
    super.key,
    required this.userEmail,
  });

  @override
  State<Screens> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Screens> {
  bool isHome = true;
  bool isActivity = false;
  bool isProfile = false;
  bool isCart = false;

  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    CollectionReference cartRef =
        FirebaseFirestore.instance.collection(widget.userEmail);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            //screens go here
            isHome
                ? HomeScreen(
                    userEmail: widget.userEmail,
                  )
                : isActivity
                    ? OrderScreen(
                        userEmail: widget.userEmail,
                      )
                    : isProfile
                        ? ProfileScreen(
                            userEmail: widget.userEmail,
                          )
                        : CartScreen(
                            userEmail: widget.userEmail,
                          ),
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
                          isCart = false;
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
                          isCart = false;
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
                            isProfile = false;
                            isCart = true;
                          });
                        },
                        child: StreamBuilder<QuerySnapshot>(
                          stream: cartRef.snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Stack(
                                children: [
                                  Image.asset(
                                    "assets/shopping-bag.png",
                                    height: 30,
                                    color: isCart
                                        ? CustomColor().logoColor
                                        : Colors.black,
                                  ),
                                  snapshot.data!.docs.isNotEmpty
                                      ? Positioned(
                                          right: 0,
                                          child: Container(
                                            height: 18,
                                            width: 18,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red),
                                            child: Text(
                                              snapshot.data!.docs.length
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              );
                            } else {
                              return Image.asset(
                                "assets/user.png",
                                height: 30,
                                color: isCart
                                    ? CustomColor().logoColor
                                    : Colors.black,
                              );
                            }
                          },
                        )),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isHome = false;
                          isActivity = false;
                          isProfile = true;
                          isCart = false;
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
