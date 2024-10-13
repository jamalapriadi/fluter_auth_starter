import 'dart:async';
import 'package:flutter/material.dart';
import '../pages/check_auth.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    startLaunching();
  }

  startLaunching() async {
    var durasi = const Duration(seconds: 3);
    return Timer(durasi, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return const CheckAuth();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(
            "assets/img/flutter_icon.png",
            height: 120,
          ),
        ));
  }
}
