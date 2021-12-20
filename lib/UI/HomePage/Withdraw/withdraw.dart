import 'package:block_chain/UI/HomePage/Withdraw/withdraw_form.dart';
import 'package:block_chain/UI/HomePage/widgets/header_with_search_box.dart';
import 'package:flutter/material.dart';

class WithDrawScreen extends StatelessWidget {
  const WithDrawScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: const <Widget>[
        HeaderWithSearchBox(),
        WithDrawForm(),
      ]),
    );
  }
}
