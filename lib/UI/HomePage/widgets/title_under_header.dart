import 'package:block_chain/constants/constants.dart';
import 'package:flutter/material.dart';

class TitleUnderHeader extends StatelessWidget {
  String title;
  double size;
  TitleUnderHeader({required this.title, required this.size, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 4),
            child: Text("${title}",
                style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontSize: size,
                    fontWeight: FontWeight.w600)),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.only(right: kDefaultPadding / 4),
              height: 10,
              color: kPrimaryColor.withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}
