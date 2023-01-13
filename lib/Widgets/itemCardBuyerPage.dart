import 'package:flutter/material.dart';
import 'package:morsel_application_1/constants/customVariables.dart'
    as customVariables;

// Pending tasks -
// 1. Adding payment gateway api
// 2. Formatting the view
// 3. Adding 'money saved' statistics
class itemListBuyerSellerPage extends StatefulWidget {
  itemListBuyerSellerPage({super.key, required this.itemID});
  String? itemID;

  @override
  State<itemListBuyerSellerPage> createState() =>
      _itemListBuyerSellerPageState();
}

class _itemListBuyerSellerPageState extends State<itemListBuyerSellerPage> {
  var _itemCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300)),
      margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                customVariables.ItemsDB![widget.itemID]!['ItemName'],
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "${customVariables.ItemsDB![widget.itemID]!['ItemPrice']}\$",
                  style: TextStyle(
                      color: Colors.green.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              // Text(
              //   "Save 4.99\$",
              //   style: TextStyle(
              //       color: Colors.black,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 14),
              // ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber.shade600,
                ),
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text(
                  "${customVariables.ItemsDB![widget.itemID]!['ItemQuantity']} in stock",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage(customVariables
                          .ItemsDB![widget.itemID]!['itemImageUrl']),
                      fit: BoxFit.cover,
                      alignment: FractionalOffset.center,
                    )),
              ),
              _itemCounter == 0
                  ? GestureDetector(
                      onTap: () => {
                        setState(() {
                          if (customVariables
                                  .ItemsDB![widget.itemID]!['ItemQuantity'] >
                              _itemCounter) {
                            _itemCounter++;
                            customVariables.cartCounter++;
                            customVariables
                                    .ItemsDB![widget.itemID]!['CartQuantity'] =
                                _itemCounter;

                            customVariables.cartTotalValue =
                                customVariables.cartTotalValue +
                                    customVariables
                                        .ItemsDB![widget.itemID]!['ItemPrice'];
                          }
                        })
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 0),
                        width: 150,
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: Text(
                          "Add",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 0),
                      width: 150,
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () => {
                              setState(() {
                                if (customVariables.ItemsDB![widget.itemID]![
                                        'ItemQuantity'] >
                                    _itemCounter) {
                                  _itemCounter--;
                                  customVariables.cartCounter--;
                                  customVariables.ItemsDB![widget.itemID]![
                                      'CartQuantity'] = _itemCounter;

                                  customVariables.cartTotalValue =
                                      customVariables.cartTotalValue -
                                          customVariables.ItemsDB![
                                              widget.itemID]!['ItemPrice'];
                                }
                              })
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(
                                Icons.arrow_downward_rounded,
                                color: Colors.black,
                                size: 22,
                              ),
                            ),
                          ),
                          Text(
                            "$_itemCounter",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          GestureDetector(
                            onTap: () => {
                              setState(() {
                                if (customVariables.ItemsDB![widget.itemID]![
                                        'ItemQuantity'] >
                                    _itemCounter) {
                                  _itemCounter++;
                                  customVariables.cartCounter++;
                                  customVariables.ItemsDB![widget.itemID]![
                                      'CartQuantity'] = _itemCounter;
                                  customVariables.cartTotalValue =
                                      customVariables.cartTotalValue +
                                          customVariables.ItemsDB![
                                              widget.itemID]!['ItemPrice'];
                                }
                              })
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(
                                Icons.arrow_upward_rounded,
                                color: Colors.black,
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
