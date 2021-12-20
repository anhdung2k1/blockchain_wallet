import 'package:block_chain/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding * 2.5),
      height: size.height * 0.2,
      width: size.width,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
            ),
            height: size.height * 0.2 - 27,
            decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36.0),
                    bottomRight: Radius.circular(36.0))),
            child: Row(
              children: <Widget>[
                Text(
                  "Hi Anh Dung !",
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        "https://scontent.fdad1-2.fna.fbcdn.net/v/t39.30808-6/240601223_2400388370093530_5908276801963571095_n.jpg?_nc_cat=105&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=MTenYRzZG08AX-QJpZI&_nc_ht=scontent.fdad1-2.fna&oh=00_AT8o8H2evaMX5uZz_VWgS2_qJmQu2U_8dHfI0mnVIf0Ncg&oe=61C003FD"))
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 54,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 10),
                          blurRadius: 50,
                          color: kPrimaryColor.withOpacity(0.23))
                    ]),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {},
                        decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: TextStyle(
                                color: kPrimaryColor.withOpacity(0.5),
                                fontSize: 20),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none),
                      ),
                    ),
                    Icon(
                      Icons.search_outlined,
                      color: kPrimaryColor.withOpacity(0.5),
                      size: 50,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
