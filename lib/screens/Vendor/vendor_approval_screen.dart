import 'package:flutter/material.dart';
import 'package:foodie/components/logo.dart';

class VendorApprovalScreen extends StatefulWidget {
  const VendorApprovalScreen({super.key});

  @override
  State<VendorApprovalScreen> createState() => _VendorApprovalScreenState();
}

class _VendorApprovalScreenState extends State<VendorApprovalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          AppLogo(),
          SizedBox(
            height: 16,
          ),
          Text("Waiting approval from admin..."),
        ],
      )),
    );
  }
}
