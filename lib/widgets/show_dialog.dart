import 'package:block_chain/widgets/transaction_dialog.dart';
import 'package:flutter/material.dart';

class ChoiceView extends StatelessWidget {
  String txhash;
  String addressFrom;
  String addressTo;
  int amount;
  ChoiceView(
      {required this.txhash,
      required this.addressFrom,
      required this.addressTo,
      required this.amount,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text("Transaction Details",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'avenir')),
          TextDialog(titile: "Transaction ID", content: txhash),
          TextDialog(titile: "From", content: addressFrom),
          TextDialog(titile: "To", content: addressTo),
          TextDialog(titile: "Total Amount", content: amount.toString())
        ],
      ),
    );
  }
}
