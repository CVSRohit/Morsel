import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:morsel_application_1/Pages/sellerAddItem.dart';
import 'package:morsel_application_1/constants/customVariables.dart'
    as customVariables;

import '../Widgets/shoppingCartItemCard.dart';
import 'buyerOrdersPage.dart';

List<String> cartItemIDList = [];

class shoppingPaymentPage extends StatefulWidget {
  shoppingPaymentPage(
      {super.key, required this.cartCounter, required this.sellerID});
  var cartCounter;
  String? sellerID;

  @override
  State<shoppingPaymentPage> createState() => _shoppingPaymentPageState();
}

class _shoppingPaymentPageState extends State<shoppingPaymentPage> {
  @override
  void initState() {
    super.initState();
    getCartItemID().then((value) => null);
    setState(() {});
  }

  Widget build(BuildContext context) {
    customVariables.newOrder = customVariables.orderConfirmed();
    customVariables.newOrder.itemIDs = [];
    customVariables.newOrder.itemPrices = [];
    customVariables.newOrder.itemQuantities = [];
    customVariables.orderConfirmed newOrder;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customVariables.morselLiteGreen,
      ),
      body: cartItemIDList.length == 0
          ? Center(
              child: Text(
              "Your cart is empty. Please add morsels to save!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ))
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 400,
                  child: ListView.builder(
                    itemCount: cartItemIDList.length,
                    itemBuilder: (context, index) {
                      String key = cartItemIDList.elementAt(index);
                      if (customVariables.ItemsDB![key] != null) {
                        return Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.transparent, width: 0)),
                          child: shoppingCartItemCard(
                              itemID: cartItemIDList.elementAt(index)),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.grey.shade500,
                  height: 1,
                ),
                Text(
                  "\$${(customVariables.cartTotalValue).toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 40, color: customVariables.morselGreenColor),
                ),
                Text(
                  "Estiamted savings: \$${((customVariables.cartTotalValue) * 2).toStringAsFixed(2)}",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    customVariables.newOrder.billTotal =
                        customVariables.cartTotalValue;
                    customVariables.newOrder.buyerID =
                        customVariables.activeUser.userID;
                    customVariables.newOrder.sellerID = widget.sellerID;
                    customVariables.newOrder.itemIDs = cartItemIDList.toList();
                    for (var itemID in cartItemIDList) {
                      customVariables.newOrder.itemPrices
                          ?.add(customVariables.ItemsDB![itemID]!['ItemPrice']);
                      customVariables.newOrder.itemQuantities?.add(
                          customVariables.ItemsDB![itemID]!['CartQuantity']);
                    }
                    setState(() {
                      placeOrder();
                    });

                    // These steps should happen only after the payment returns succesful
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => buyerOrderPage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.apple,
                        size: 50,
                      ),
                      Text(
                        "Apple Pay",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.payment,
                      size: 50,
                    ),
                    Icon(
                      Icons.paypal,
                      color: Colors.blue,
                      size: 50,
                    ),
                  ],
                )
              ],
            ),
    );
  }
}

Future getCartItemID() async {
  cartItemIDList.clear();
  customVariables.newOrder.itemIDs?.clear();
  customVariables.newOrder.itemPrices?.clear();
  customVariables.newOrder.itemQuantities?.clear();

  for (var itemID in customVariables.ItemsDB!.keys.toList()) {
    if (customVariables.ItemsDB![itemID]!['CartQuantity'] != null) {
      if (customVariables.ItemsDB![itemID]!['CartQuantity'] > 0) {
        cartItemIDList.add(itemID);
        // customVariables.newOrder.itemIDs?.add(itemID);
        // customVariables.newOrder.itemPrices
        //     ?.add(customVariables.ItemsDB![itemID]!['ItemPrice']);
        // customVariables.newOrder.itemQuantities
        //     ?.add(customVariables.ItemsDB![itemID]!['CartQuantity']);
        // print(customVariables.ItemsDB![itemID]!['CartQuantity']);
      }
    }
  }
}

// customVariables.

placeOrder() async {
  try {
    final db = await FirebaseFirestore.instance;
    print(customVariables.newOrder.itemPrices);
    final order = await <String, dynamic>{
      "buyerID": customVariables.activeUser.userID.toString(),
      "sellerID": customVariables.newOrder.sellerID,
      "ItemIDs": customVariables.newOrder.itemIDs,
      "itemPrices": customVariables.newOrder.itemPrices,
      "itemQuantity": customVariables.newOrder.itemQuantities?.toList(),
      "billTotal": customVariables.newOrder.billTotal,
    };

    await db.collection("orders").add(order);
  } catch (e) {
    print(e);
  }
}
