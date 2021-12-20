import 'package:block_chain/UI/HomePage/TransferScreen/transfer_form.dart';
import 'package:block_chain/UI/HomePage/widgets/header_with_search_box.dart';
import 'package:flutter/material.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        HeaderWithSearchBox(),
        TransferForm(),
      ]),
    );
  }
}
