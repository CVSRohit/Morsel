import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:morsel_application_1/Pages/buyerShoppingCart.dart';
import '../Widgets/itemCardBuyerPage.dart';
import 'buyerHomePage.dart';
import 'buyerProfile.dart';
import 'package:morsel_application_1/constants/customVariables.dart'
    as customVariables;

// Pending tasks -
// 1. Add store logo and image
// 2. Add ratings
// 3. Add condition such that cart quantity is not greater than item quantity

List<String> filteredItemsIDList = [];

class sellerPage extends StatefulWidget {
  sellerPage({super.key, required this.sellerID});
  String? sellerID;

  @override
  State<sellerPage> createState() => _sellerPageState();
}

class _sellerPageState extends State<sellerPage> {
  bool _isFavorite = false;
  @override
  void initState() {
    getActiveItemsOfUser(widget.sellerID);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              backgroundBlendMode: BlendMode.lighten,
              color: customVariables.greyTransparentColor,
              image: DecorationImage(
                fit: BoxFit.cover,
                alignment: FractionalOffset.center,
                image: AssetImage(
                  "images/Food_image_base_1.jpeg",
                ),
              ),
            ),
            child: Container(
              color: customVariables.greyTransparentColor,
              height: 200,
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber.shade600,
                        ),
                        margin: EdgeInsets.fromLTRB(10, 50, 10, 10),
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Text(
                          customVariables.usersDB![widget.sellerID]
                                      ['activeItemNumber'] >
                                  1
                              ? "${customVariables.usersDB![widget.sellerID]['activeItemNumber']} options"
                              : "${customVariables.usersDB![widget.sellerID]['activeItemNumber']} option",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                              height: 50,
                              width: 50,
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.store,
                                size: 40,
                              )),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                            padding: EdgeInsets.all(5),
                            color: Colors.white,
                            child: Text(
                              customVariables.usersDB![widget.sellerID]
                                      ['businessName'] ??
                                  null,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => setState(
                          () {
                            _isFavorite = !_isFavorite;
                          },
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.fromLTRB(10, 50, 10, 10),
                          child: Icon(
                            Icons.favorite,
                            size: 35,
                            color: _isFavorite
                                ? customVariables.morselGreenColor
                                : Colors.white,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey.shade300),
                        ),
                      ),
                      // Container(
                      //   color: Colors.grey.shade300,
                      //   padding: EdgeInsets.all(5),
                      //   width: 50,
                      //   margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      //   child: Column(
                      //     children: [
                      //       Icon(
                      //         Icons.star,
                      //         size: 30,
                      //         color: Colors.amber.shade800,
                      //       ),
                      //       Text("4.4/5")
                      //     ],
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            color: Colors.grey.shade500,
            height: 0.5,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.location_on,
                  size: 30,
                  color: customVariables.morselGreenColor,
                ),
                Text(
                  customVariables.usersDB![widget.sellerID]['businessAddress'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                // Text(
                //   "1.3 Km",
                //   style: TextStyle(fontSize: 18),
                // )
              ],
            ),
          ),
          Container(
            color: Colors.grey.shade500,
            height: 0.5,
          ),
          Container(
            height: 500,
            child: ListView.builder(
              itemCount: filteredItemsIDList.length,
              itemBuilder: (context, index) {
                String key = filteredItemsIDList.elementAt(index);
                if (customVariables.ItemsDB![key] != null) {
                  return Container(
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.transparent, width: 0)),
                    child: itemListBuyerSellerPage(
                      itemID: filteredItemsIDList[index],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        width: 350,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => buyerHomePage())),
                child: Column(children: [
                  Icon(Icons.map_outlined, size: 35),
                  Text("Map")
                ])),
            GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => buyerHomePage())),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.search,
                          size: 35, color: Colors.green.shade900),
                      Text("Explore",
                          style: TextStyle(
                              color: Colors.green.shade900,
                              fontWeight: FontWeight.bold))
                    ])),
            GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => buyerProfilePage())),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Icon(Icons.person, size: 35), Text("Profile")])),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green.shade900,
        splashColor: customVariables.morselGreenColor,
        focusColor: customVariables.morselGreenColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => shoppingPaymentPage(
                        sellerID: widget.sellerID,
                        cartCounter: customVariables.cartCounter,
                      )));
        },
        icon: Icon(
          Icons.shopping_bag_outlined,
          size: 40,
        ),
        label: const Text(
          "Save Morsel",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}

getActiveItemsOfUser(String? userID) {
  filteredItemsIDList.clear();
  for (var itemID in customVariables.ItemsDB!.keys.toList()) {
    if (customVariables.ItemsDB![itemID]!['userID'] != null) {
      if (customVariables.ItemsDB![itemID]!['userID'] == userID) {
        filteredItemsIDList.add(itemID);
        customVariables.ItemsDB![itemID]!['CartQuantity'] = 0;
      }
    }
  }
}
