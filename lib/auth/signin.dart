import 'package:bookstoreapp/models/user.dart';
import 'package:bookstoreapp/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

String userId = "";

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late final User currentUser;

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signin(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User user = result.user!;

      SharedPreferences prefs = await SharedPreferences.getInstance();

      print(user);

      if (result != null) {
        prefs.setString('user_id', user.uid);

        setState(() {
          userId = user.uid;
        });

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }

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
              onTap: () => signin(context),
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
