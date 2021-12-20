import 'dart:async';
import 'package:block_chain/UI/HomePage/TransferScreen/transfer.dart';
import 'package:block_chain/UI/HomePage/Withdraw/withdraw.dart';
import 'package:block_chain/UI/HomePage/widgets/header_with_search_box.dart';
import 'package:block_chain/UI/HomePage/widgets/service_widget.dart';
import 'package:block_chain/routes/routes.dart';
import 'package:block_chain/widgets/navigation_drawer.dart';
import 'package:clipboard/clipboard.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:block_chain/UI/HomePage/Screen/Apps/apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:block_chain/constants/constants.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _isVisible = true;
  int currentIndex = 0;
  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget buildCopy(String text) => Builder(
      builder: (context) => IconButton(
          onPressed: () async {
            await FlutterClipboard.copy(text);
            Scaffold.of(context).showSnackBar(
                const SnackBar(content: Text("Copied to ClipBoard")));
          },
          icon: const Icon(Icons.content_copy)));

  late Client httpClient;
  late Web3Client ethClient;
  int myAmount = 0;
  bool data = false;
  // ignore: prefer_typing_uninitialized_variables
  var myData;
  var balance;
  final _formKey = GlobalKey<FormState>();
  late var myaddress = address;
  var newAdress;
  @override
  void initState() {
    super.initState();
    httpClient = Client();
    ethClient = Web3Client(url, httpClient);
    getBalance(myaddress);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString("assets/json/abi.json");
    String contractAddress = "0x989Cb4fFca8CBBF2EBb3DB138f0062cb35DfB950";

    final contract = DeployedContract(ContractAbi.fromJson(abi, "PKCoin"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.call(
        contract: contract, function: ethFunction, params: args);
    return result;
  }

  Future<void> getBalance(String targetAddress) async {
    List<dynamic> result = await query("getBalance", []);
    myData = result[0];
    data = true;
    setState(() {
      balance = myData;
    });
  }

  Future<String> sendCoin() async {
    var bigAmount = BigInt.from(myAmount);
    var response = await submit("depositBalance", [bigAmount]);
    print("Deposited");
    return response;
  }

  Future<String> submit(String functionName, List<dynamic> args) async {
    EthPrivateKey credential = EthPrivateKey.fromHex(privateKey);
    DeployedContract contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.sendTransaction(
        credential,
        Transaction.callContract(
            contract: contract,
            function: ethFunction,
            parameters: args,
            maxGas: 1000000),
        chainId: null,
        fetchChainIdFromNetworkId: true);
    return result;
  }

  List<Widget> listWidgets = [
    const LandingPage(),
    const TransferScreen(),
    const WithDrawScreen(),
    const Apps()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Align(
          alignment: Alignment.center,
          child: Text("ICON WALLET",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                fontFamily: 'avenir',
                color: Colors.white,
              ),
              textAlign: TextAlign.center),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.LogIn);
              },
              icon: const Icon(Icons.logout, color: Colors.white)),
        ],
      ),
      drawer: const NavigationDrawer(),
      body: listWidgets[currentIndex] == listWidgets[0]
          ? SingleChildScrollView(
              child: Column(children: <Widget>[
              const HeaderWithSearchBox(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'))),
                  ),
                  const SizedBox(width: 5),
                  const Text("eWallet",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'ubuntu',
                          fontSize: 25))
                ])
              ]),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Account Overview",
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'avenir')),
                  _isVisible
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                          icon: const Icon(Icons.visibility_outlined),
                          color: kPrimaryColor,
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                          icon: const Icon(Icons.visibility_off_outlined),
                          color: kPrimaryColor,
                        )
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xffff1f3f6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _isVisible
                            ? Text(
                                "${myData}",
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w700),
                              )
                            : const Text("*******",
                                style: TextStyle(fontSize: 22)),
                        const SizedBox(height: 5),
                        const Text("Current Balance",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400))
                      ],
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffffac30)),
                      child: IconButton(
                        icon: const Icon(Icons.refresh),
                        iconSize: 30,
                        onPressed: () {
                          getBalance(myaddress);
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Address",
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'avenir')),
                  Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/scanqr.png'))),
                      child: InkWell(
                        onTap: () {},
                      )),
                ],
              ),
              Row(
                children: [
                  Wrap(
                    children: [
                      Container(
                        height: 150,
                        width: 120,
                        margin: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xFFF1F3F6)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: IconButton(
                                icon: const Icon(Icons.add, size: 40),
                                color: Colors.orange,
                                onPressed: () {
                                  setState(() {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Positioned(
                                                    right: -40.0,
                                                    top: -40.0,
                                                    child: InkResponse(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const CircleAvatar(
                                                        child:
                                                            Icon(Icons.close),
                                                        backgroundColor:
                                                            Colors.red,
                                                      ),
                                                    )),
                                                Form(
                                                  key: _formKey,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextFormField(
                                                          onSaved: (newValue) =>
                                                              newAdress =
                                                                  newValue!,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      "Address",
                                                                  hintText:
                                                                      "Enter your Address",
                                                                  floatingLabelBehavior:
                                                                      FloatingLabelBehavior
                                                                          .always,
                                                                  suffixIcon:
                                                                      const Icon(
                                                                          Icons
                                                                              .map),
                                                                  contentPadding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          42,
                                                                      vertical:
                                                                          20),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    borderSide:
                                                                        const BorderSide(
                                                                            color:
                                                                                Color(0xFF9B9B9B)),
                                                                    gapPadding:
                                                                        10,
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    borderSide:
                                                                        const BorderSide(
                                                                            color:
                                                                                Color(0xFF9B9B9B)),
                                                                    gapPadding:
                                                                        10,
                                                                  )),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: InkWell(
                                                              onTap: () {
                                                                if (_formKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  _formKey
                                                                      .currentState!
                                                                      .save();
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                }
                                                              },
                                                              child: const Text(
                                                                  "Add New Address",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontFamily:
                                                                          'avenir',
                                                                      color:
                                                                          kPrimaryColor))))
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                  });
                                },
                              ),
                            ),
                            const Text(
                              "Add New Address",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'avenir'),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      newAdress != null
                          ? InkWell(
                              onTap: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Address"),
                                      content: SingleChildScrollView(
                                        child: Wrap(
                                          children: [
                                            Text("Address: ${newAdress}"),
                                            buildCopy(newAdress)
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                              child: Container(
                                height: 150,
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color(0xFFF1F3F6)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/avatar1.png"),
                                              fit: BoxFit.contain),
                                          border: Border.all(
                                              color: Colors.black, width: 2)),
                                    ),
                                    const Text(
                                      "Anh Dũng",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Avenir',
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  )
                ],
              ),
              Wrap(
                children: [
                  SizedBox(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.count(
                      crossAxisCount: 4,
                      childAspectRatio: 0.7,
                      children: [
                        serviceWidget(img: "sendMoney", name: "Send\nMoney"),
                        serviceWidget(
                            img: "receiveMoney", name: "Receive\nMoney"),
                        serviceWidget(img: "phone", name: "Mobile\nRecharge"),
                        serviceWidget(
                            img: "electricity", name: "Electricity\nBill"),
                        serviceWidget(img: "tag", name: "Cashback\nOffer"),
                        serviceWidget(img: "movie", name: "Movie\nTicket"),
                        serviceWidget(img: "flight", name: "Flight\nTicket"),
                        serviceWidget(img: "more", name: "More\n"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ]))
          : (listWidgets[currentIndex]),
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.transform_outlined, title: 'Transfer'),
          TabItem(
              icon: Icons.account_balance_wallet_outlined, title: 'Withdraw'),
          TabItem(icon: Icons.apps, title: 'Account')
        ],
        height: 60,
        onTap: setBottomBarIndex,
        activeColor: Colors.white,
        backgroundColor: kBluePrimaryColor,
      ),
    );
  }
}
