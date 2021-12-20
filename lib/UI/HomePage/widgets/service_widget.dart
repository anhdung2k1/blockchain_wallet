import 'package:flutter/material.dart';

class serviceWidget extends StatelessWidget {
  String img;
  String name;
  serviceWidget({required this.img, required this.name, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: InkWell(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xFFFF1F3F6)),
            child: Center(
              child: Container(
                margin: EdgeInsets.all(25),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/$img.png"))),
              ),
            ),
          ),
        )),
        const SizedBox(height: 5),
        Text(
          name,
          style: const TextStyle(
            fontFamily: 'Avenir',
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
