import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:morsel_application_1/Pages/sellerAddItem.dart';
import 'package:morsel_application_1/Pages/sellerEditItemPage.dart';
import 'package:morsel_application_1/Pages/sellerProfile.dart';
import 'package:morsel_application_1/constants/customVariables.dart'
    as customVariables;
import 'package:cloud_firestore/cloud_firestore.dart';

// Done
//    a. Updating the list based on time (removing expired items)

// Pending tasks -
// 1. End to end seller flow completion
//    a. Currently the circular loading graphic is never called. Need to fix that
//    b. Option to delete or edit existing listings
//    c. Creating "My Orders page"
//    d. Set-up variables and calculations for Profile stats
//    e. Restaurant logo/picture upload in my profile
//    f. Help page set-up - FAQs
//    g. image picker in Add itme
//Integrating orders - creating order backend to keep track of succesful orders

class sellerHomePage extends StatefulWidget {
  const sellerHomePage({super.key});

  @override
  State<sellerHomePage> createState() => _sellerHomePageState();
}

class _sellerHomePageState extends State<sellerHomePage> {
  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance
        .collection('items')
        .where('userID', isEqualTo: customVariables.activeUser.userID)
        .snapshots();
    var _sellerItemCounter = 0;
    return Scaffold(
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      color: Colors.white,
                      child: Text(
                        customVariables.activeUser.businessName.toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Text(customVariables.activeUser.businessAddress.toString())
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 10, bottom: 20),
              alignment: Alignment.center,
              child: Text(
                "Your open listings",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ),
            Container(
              height: 600,
              // alignment: Alignment.center,
              child: StreamBuilder<QuerySnapshot>(
                stream: db,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "Add your first item to start selling",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: customVariables.morselGreenColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                          ),
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  } else {
                    return ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: snapshot.data!.docs.map(
                          (doc) {
                            var _visibile = true;
                            customVariables.activeUser.sellerItemCount =
                                snapshot.data!.size;
                            DateTime date = (doc['AvailableUntilCharity'] ??
                                    doc['AvailableUntil'] as Timestamp)
                                .toDate();
                            date.isAfter(DateTime.now())
                                ? _visibile = true
                                : _visibile = false;
                            return Visibility(
                              visible: _visibile,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                      color: Colors.grey.shade500,
                                      width: 1,
                                      strokeAlign: 1),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(1),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                doc['itemImageUrl']),
                                            fit: BoxFit.cover,
                                            alignment: FractionalOffset.center,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  doc['ItemName'].toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 22),
                                                ),
                                              ),
                                              Text(
                                                "x ${doc['ItemQuantity'].toString()}",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  sellerEditItemPage()));
                                                    },
                                                    child: Icon(
                                                      Icons.edit,
                                                      size: 24,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      // deleteItem();
                                                      _buildDialog(
                                                          context,
                                                          'Are you sure you want to delete the collection?',
                                                          doc.id);
                                                    },
                                                    child: Icon(
                                                      Icons.delete,
                                                      size: 24,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Spacer(),
                                      Container(
                                        height: 100,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              customVariables.morselGreenColor,
                                        ),
                                        padding:
                                            EdgeInsets.only(left: 5, right: 5),
                                        child: Text(
                                          "\$ ${doc['ItemPrice'].toString()}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList());
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        width: 350,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => sellerHomePage())),
                child: Column(children: [
                  Icon(Icons.list, size: 35, color: Colors.green.shade900),
                  Text("Listings",
                      style: TextStyle(
                          color: Colors.green.shade900,
                          fontWeight: FontWeight.bold))
                ])),
            GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => sellerAddItem())),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Icon(Icons.add, size: 35), Text("Add Item")])),
            GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => sellerProfile())),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Icon(Icons.store, size: 35), Text("Profile")])),
          ],
        ),
      ),
    );
  }
}

// Function to delete an item

Future<void> _buildDialog(BuildContext context, _message, _docID) {
  return showDialog(
    builder: (context) {
      return AlertDialog(
        title: Text('Delete'),
        content: Text(_message),
        actions: <Widget>[
          TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          TextButton(
              child: Text('Delete'),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('items')
                    .doc(_docID)
                    .delete();
                Navigator.of(context).pop();
              })
        ],
      );
    },
    context: context,
  );
}
