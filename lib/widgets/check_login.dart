import 'package:block_chain/UI/LoginSucess/login_sucess.dart';
import 'package:block_chain/UI/Welcome%20Screen/walking_through.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckLogin extends StatelessWidget {
  const CheckLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData &&
                FirebaseAuth.instance.currentUser?.emailVerified == true) {
              print("Logged In");
              return LogInSucess();
            } else if (snapshot.hasError) {
              return const Center(child: Text("Something went Wrong"));
            } else {
              return const WalkThroughScreen();
            }
          }),
    );
  }
}
