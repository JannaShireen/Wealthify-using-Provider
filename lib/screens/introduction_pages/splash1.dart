import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // goToOnboardPage();
    checkWhereToGo();

    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: SafeArea(
        child: Center(
          // heightFactor: 3,
          // widthFactor: 0.8,

          child: Text(
            'Wealthify',
            textScaleFactor: 3,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkWhereToGo() async {
    await Future.delayed(const Duration(seconds: 2));

    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool seen = preferences.getBool('seen') ?? false;
    seen ? goHome() : goToOnboardPage();

    preferences.setBool('seen', true);
  }

  Future<void> goToOnboardPage() async {
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/onboard',
      (Route<dynamic> route) => false,
    );
  }

  Future<void> goHome() async {
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/home',
      (Route<dynamic> route) => false,
    );
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(
    //     builder: ((context) => RootPage()),
    //   ),
    // );
  }
}
