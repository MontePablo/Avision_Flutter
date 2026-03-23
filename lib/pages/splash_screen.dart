

import 'dart:async';
import 'dart:convert';

import 'package:avision/storage/shared_preferences.dart';
import 'package:avision/utils/constants.dart';
import 'package:avision/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



void main(){
  runApp(const SplashScreen());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const Color startColor = Color(0xFF71D3E1); // Example hex color
  static const Color endColor = Color(0xFF074F8F);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      MySharedPreferences().getUserDetail().then((value){
        print("user: "+jsonEncode(value));
        if (mounted) {
          if(value==null) {
            Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
          } else {
            Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
          }
        }
      });
    });
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [SplashScreen.endColor,SplashScreen.startColor], // Define your gradient colors here
            ),
          ),
          child: Stack(children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset('assets/images/splash2.png',), // Replace with your image asset
            ),
            Positioned(
              top: MyConstants.sh*.17,
              left: 0,
              right: 0,
              child: Image.asset('assets/images/splash1.png'), // Replace with your image asset
            ),
          ],),
        ),
      ),
    );
  }
}