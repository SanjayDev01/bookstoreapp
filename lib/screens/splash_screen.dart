import 'package:bookstoreapp/auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkUser();
  }

  checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Future.delayed(const Duration(seconds: 3), () {
      if (prefs.getString('user_id') != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const SignIn()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
          ),
          Center(
            child: Lottie.asset(
              "assets/images/student.json",
              width: 300,
              height: 300,
              repeat: true,
              frameRate: FrameRate.max,
            ),
          ),
          const Text(
            "Book Store",
            style: TextStyle(
              fontSize: 40,
              color: Colors.black54,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 150,
          ),
        ],
      ),
    );
  }
}
