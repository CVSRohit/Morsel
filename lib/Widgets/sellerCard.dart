import 'package:flutter/material.dart';
import 'package:morsel_application_1/constants/customVariables.dart'
    as customVariables;

import '../Pages/buyerSellerPage.dart';

class sellerCard extends StatefulWidget {
  sellerCard(
      {super.key,
      required this.itemsAvailableCount,
      required this.businessName,
      required this.businessAddress,
      this.minPrice,
      required this.sellerID});
  int? itemsAvailableCount = 0;
  String? businessName;
  String? businessAddress;
  double? minPrice;
  String? sellerID;
  @override
  State<sellerCard> createState() => _sellerCardState();
}

class _sellerCardState extends State<sellerCard> {
  @override
  bool _isFavorite = false;
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          // color: Colors.grey,
          border: Border.all(color: Colors.grey.shade500)),
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => sellerPage(sellerID: widget.sellerID))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
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
                height: 125,
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber.shade600,
                          ),
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text(
                            widget.itemsAvailableCount! > 1
                                ? "${widget.itemsAvailableCount} options"
                                : "${widget.itemsAvailableCount} option",
                            // "${widget.itemsAvailableCount} options",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey.shade300,
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.store,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                            margin: EdgeInsets.all(10),
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
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green.shade900,
                          ),
                          margin: EdgeInsets.all(9),
                          padding: EdgeInsets.all(4),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text(
                                "Starting @",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Text(
                                "2.98\$",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          widget.businessName.toString(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      FittedBox(
                          fit: BoxFit.contain,
                          child: Text(widget.businessAddress.toString()))
                    ],
                  ),
                  // Text(
                  //   "1.3 Km",
                  //   style: TextStyle(fontSize: 20),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
