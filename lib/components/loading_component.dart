import 'package:flutter/material.dart';
import 'package:foodie/components/logo.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
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
          Text("Loading..."),
        ],
      )),
    );
  }
}
