import 'package:block_chain/constants/constants.dart';
import 'package:block_chain/helper/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class WithDrawForm extends StatefulWidget {
  const WithDrawForm({Key? key}) : super(key: key);

  @override
  _WithDrawFormState createState() => _WithDrawFormState();
}

class _WithDrawFormState extends State<WithDrawForm> {
  final TextEditingController _EnterICX = TextEditingController();
  final TextEditingController _EnterDes = TextEditingController();
  late Web3Client ethClient;
  late Client httpClient;
  final _formkey = GlobalKey<FormState>();
  double myAmount = 0;
  String _address = "";
  final List<String> errors = [];
  @override
  void initState() {
    super.initState();
    httpClient = Client();
    ethClient = Web3Client(url, httpClient);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  Future<String> withdrawCoin() async {
    var bigAmount = BigInt.from(myAmount);
    EthereumAddress targetAddress = EthereumAddress.fromHex(_address);
    var response = await submit("withdrawBalance", [targetAddress, bigAmount]);
    print("WithDrawn");
    return response;
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString("assets/json/abi.json");
    String contractAddress = "0x989Cb4fFca8CBBF2EBb3DB138f0062cb35DfB950";

    final contract = DeployedContract(ContractAbi.fromJson(abi, "PKCoin"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<String> submit(String functionName, List<dynamic> args) async {
    EthPrivateKey credential = EthPrivateKey.fromHex(privateKey);
    DeployedContract contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.sendTransaction(
        credential,
        Transaction.callContract(
            contract: contract, function: ethFunction, parameters: args),
        chainId: null,
        fetchChainIdFromNetworkId: true);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          const Text("Withdraw ICX",
              style: TextStyle(fontSize: 34, fontFamily: 'Helvetice')),
          const SizedBox(height: 20),
          buildICXFormField(),
          const SizedBox(height: 20),
          buildAddressFormField(),
          const SizedBox(height: 20),
          ConstrainedBox(
              constraints:
                  const BoxConstraints.tightFor(width: 200, height: 70),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    KeyboardUtil.hideKeyboard(context);
                  }
                  setState(() {
                    withdrawCoin();
                  });
                },
                child: const Text(
                  'Withdraw',
                  style: TextStyle(
                      fontFamily: 'Helvetica Neue',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor),
                ),
                style: ElevatedButton.styleFrom(
                    primary: kBackGroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
              ))
        ],
      ),
    );
  }

  TextFormField buildICXFormField() {
    return TextFormField(
      controller: _EnterICX,
      onSaved: (newValue) => myAmount = double.parse(newValue!),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Please Enter your ICX Value");
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Please Enter your ICX Value");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "ICX Value",
          hintText: "Enter your ICX",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const Icon(Icons.money),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFF9B9B9B)),
            gapPadding: 10,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFF9B9B9B)),
            gapPadding: 10,
          )),
      style: const TextStyle(color: Colors.black),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      controller: _EnterDes,
      onSaved: (newValue) => _address = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Please Enter your Address");
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Please Enter your Address");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Address",
          hintText: "Enter your Address",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const Icon(Icons.streetview),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFF9B9B9B)),
            gapPadding: 10,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFF9B9B9B)),
            gapPadding: 10,
          )),
      style: const TextStyle(color: Colors.black),
    );
  }
}
