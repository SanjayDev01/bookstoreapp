import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
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
          Center(
            child: InkWell(
              onTap: () {},
              child: Container(
                width: 250,
                height: 60,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Image.asset("assets/images/google.png"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
