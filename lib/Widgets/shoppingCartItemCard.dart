import 'package:flutter/material.dart';
import 'package:morsel_application_1/constants/customVariables.dart'
    as customVariables;

class shoppingCartItemCard extends StatelessWidget {
  shoppingCartItemCard({super.key, required this.itemID});
  String itemID;

  @override
  Widget build(BuildContext context) {
    // customVariables.newOrder.itemIDs!.add(itemID);
    // customVariables.newOrder.itemPrices!
    //     .add(customVariables.ItemsDB![itemID]!['ItemPrice']);
    // customVariables.newOrder.itemQuantities!
    //     .add(customVariables.ItemsDB![itemID]!['CartQuantity']);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              customVariables.ItemsDB![itemID]!['ItemName'].toString(),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            "${customVariables.ItemsDB![itemID]!['ItemPrice']}\$x ${customVariables.ItemsDB![itemID]!['CartQuantity']}",
          ),
          Text(
            "\$${(customVariables.ItemsDB![itemID]!['ItemPrice'] * customVariables.ItemsDB![itemID]!['CartQuantity']).toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
