import 'dart:async';

import 'package:aa_smart/screen/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 2),() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const HomeScreen();
    },)),);

    return SafeArea(child: Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset("assets/icons/logo.png"),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const Center(
              child: SizedBox(
                  height: 24,width: 24,
                  child: CircularProgressIndicator(color: Colors.grey,)),
            ),
          )
        ],
      ),
    ));
  }

}
