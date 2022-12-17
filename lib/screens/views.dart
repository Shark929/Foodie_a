import 'package:flutter/material.dart';
import 'package:foodie/screens/login_screen.dart';
import 'package:foodie/screens/choose_role_screen.dart';

class Views extends StatefulWidget {
  const Views({super.key});

  @override
  State<Views> createState() => _ViewsState();
}

class _ViewsState extends State<Views> {
  bool isSignIn = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
            child: isSignIn == true
                ? const LoginScreen()
                : const ChooseRoleScreen()),
      ),
    );
  }
}
