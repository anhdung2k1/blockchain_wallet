import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: <Widget>[
          Container(
            width: size.width * 0.3,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/sideImg.png'),
                    fit: BoxFit.cover)),
          ),
          Container(
            width: size.width * 0.7,
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "06:22 AM",
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'avenir',
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                        height: 20,
                        width: 20,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/cloud.png'),
                                fit: BoxFit.contain))),
                    const SizedBox(height: 5),
                    const Text("34˚ C",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'avenir',
                            fontWeight: FontWeight.w800)),
                  ],
                ),
                const Text(
                  "Aug 1, 2020 | Wednesday",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/logo.png'),
                                fit: BoxFit.contain)),
                      ),
                      const Text(
                        "eWallet",
                        style: TextStyle(
                            fontSize: 50,
                            fontFamily: 'ubuntu',
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Open An Account For \nDigital E-Wallet Solutions. \nInstant Payouts.\n\nJoin For Free",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
                Container(
                  width: size.width - 30,
                  height: 40,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      color: Colors.yellow),
                  child: const Text(
                    'Join With Us !',
                    style: TextStyle(
                        fontFamily: 'ubuntu',
                        fontSize: 28,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  top: 0,
                  child: Image.asset(
                    'assets/images/walk_through_1_2.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
