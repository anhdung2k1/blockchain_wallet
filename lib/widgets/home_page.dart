import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'check_login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<FirebaseApp> _fbapp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) => Scaffold(
      body: FutureBuilder(
          future: _fbapp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something Error!");
            } else if (snapshot.hasData) {
              return AnimatedSplashScreen(
                splash: 'assets/images/logo.png',
                pageTransitionType: PageTransitionType.bottomToTop,
                duration: 3000,
                nextScreen: CheckLogin(),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }));
}
