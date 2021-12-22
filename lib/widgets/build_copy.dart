import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class buildCopy extends StatelessWidget {
  String text;
  buildCopy({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) => IconButton(
            onPressed: () async {
              await FlutterClipboard.copy(text);
            },
            icon: const Icon(Icons.content_copy)));
  }
}
