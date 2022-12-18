import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/custom_button.dart';
import 'package:foodie/components/details_component.dart';
import 'package:foodie/components/promotion_component.dart';
import 'package:foodie/constants/color_constant.dart';
import 'package:foodie/constants/text_constant.dart';
import 'package:foodie/screens/login_screen.dart';
import 'package:foodie/screens/user_wallet_screen.dart';

class ProfileScreen extends StatefulWidget {
  final userEmail;
  const ProfileScreen({
    super.key,
    required this.userEmail,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference vendorRef =
      FirebaseFirestore.instance.collection("Vendor");
  CollectionReference ref = FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 165,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/user.png",
                  width: 50,
                  height: 50,
                  color: CustomColor().logoColor,
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userEmail,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserWalletScreen(
                                  userEmail: widget.userEmail,
                                )));
                  },
                  child: Image.asset(
                    "assets/wallet.png",
                    width: 30,
                    height: 30,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Details",
              style: CustomFont().pageLabel,
            ),
            const SizedBox(
              height: 20,
            ),
            DetailComponent(
              label: "Email",
              detail: widget.userEmail,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Promotion Code",
              style: CustomFont().pageLabel,
            ),
            const SizedBox(
              height: 16,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("UserPromotion")
                    .snapshots(),
                builder: (context, snapshot) {
                  List promoCode = [];

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  }
                  if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      if (snapshot.data!.docs[i]['user_email'] ==
                                  widget.userEmail &&
                              promoCode.isEmpty ||
                          promoCode.length < snapshot.data!.docs.length) {
                        promoCode.add(snapshot.data!.docs[i]['promo_code']);
                      }
                    }

                    return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Promotion")
                            .snapshots(),
                        builder: (context, snapshot1) {
                          if (snapshot1.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot1.data!.docs.length,
                                itemBuilder: (context, index) {
                                  if (promoCode.length <
                                      snapshot1.data!.docs.length) {
                                    promoCode.add("");
                                    for (int j = 0;
                                        j < snapshot1.data!.docs.length;
                                        j++) {
                                      for (int k = 0;
                                          k < snapshot1.data!.docs.length;
                                          k++) {
                                        if (promoCode[j] !=
                                            snapshot1.data!.docs[k]
                                                ['promotion_code']) {
                                          return InkWell(
                                            onTap: () {
                                              FirebaseFirestore.instance
                                                  .collection("UserPromotion")
                                                  .add({
                                                "amount":
                                                    snapshot1.data!.docs[index]
                                                        ['promo_amount'],
                                                "code": "1",
                                                "promotion_title":
                                                    snapshot1.data!.docs[index]
                                                        ['promotion_title'],
                                                "user_email": widget.userEmail,
                                                "promo_code":
                                                    snapshot1.data!.docs[index]
                                                        ['promotion_code'],
                                              }).then((value) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            UserWalletScreen(
                                                                userEmail: widget
                                                                    .userEmail)));
                                              });
                                            },
                                            child: PromotionComponent(
                                                amount:
                                                    snapshot1.data!.docs[index]
                                                        ['promo_amount'],
                                                code:
                                                    snapshot1.data!.docs[index]
                                                        ['promotion_code'],
                                                title:
                                                    snapshot1.data!.docs[index]
                                                        ['promotion_title']),
                                          );
                                        }
                                      }
                                    }
                                  }

                                  return const SizedBox();
                                });
                          }
                          return const SizedBox();
                        });
                  }
                  return const SizedBox();
                }),
            CustomButton(
                buttonLabel: "Logout",
                buttonFunction: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }),
          ],
        ),
      )),
    );
  }
}
