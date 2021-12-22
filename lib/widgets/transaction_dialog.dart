import 'package:block_chain/constants/constants.dart';
import 'package:block_chain/widgets/build_copy.dart';
import 'package:flutter/material.dart';

class TextDialog extends StatelessWidget {
  String titile;
  String content;
  TextDialog({required this.titile, required this.content, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(titile,
                style: const TextStyle(
                    fontFamily: 'avenir',
                    fontSize: 24,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w400)),
            buildCopy(text: content)
          ],
        ),
        Text(
          content,
          style: const TextStyle(
              fontFamily: 'Avenir', fontSize: 24, fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
