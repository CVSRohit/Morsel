import 'dart:ffi';

import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:morsel_application_1/constants/customVariables.dart'
    as customVariables;
import 'package:morsel_application_1/Widgets/categorySelector.dart';
import 'package:morsel_application_1/Widgets/sellerCard.dart';
import 'buyerProfile.dart';

// Competed tasks -
//    e. Make the firestore code async
//    a. Extract data of list of sellers and list of listings for those sellers
//    b. Create cards for each seller
// This page collects all the sellers' cards
// Pending tasks -
//    c. Location picker
//    d. Filter by options (e.g, distance)
//    e. Add distance in the card

class buyerHomePage extends StatefulWidget {
  const buyerHomePage({super.key});

  @override
  State<buyerHomePage> createState() => _buyerHomePageState();
}

class _buyerHomePageState extends State<buyerHomePage> {
  var db;
  @override
  void initState() {
    super.initState();
    getDataBasesFromFirestore().then((value) async {
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => {},
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade200,
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Row(
                      children: [
                        Icon(Icons.location_on),
                        Text("105 St. George st"),
                        Spacer(),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "What are you saving today?",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    categorySelector(
                      categoryNameText: "Groceries",
                      isSelected: false,
                    ),
                    categorySelector(
                      categoryNameText: "Meals",
                      isSelected: false,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "Recommendations",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              // Recommendations list view
              Container(
                height: 500,
                child: customVariables.activeListingSellers.keys.length == 0
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: customVariables.usersDB!.length,
                        itemBuilder: (context, index) {
                          String key =
                              customVariables.usersDB!.keys.elementAt(index);
                          if (customVariables.usersDB![key]
                                  ['activeItemNumber'] !=
                              null) {
                            if (customVariables.usersDB![key]
                                    ['activeItemNumber'] >
                                0) {
                              return sellerCard(
                                itemsAvailableCount: customVariables
                                    .usersDB![key]['activeItemNumber'],
                                businessName: customVariables.usersDB![key]
                                    ['businessName'],
                                businessAddress: customVariables.usersDB![key]
                                    ['businessAddress'],
                                sellerID: key,
                              );
                            }
                          } else {
                            return Container();
                          }
                        },
                      ),
              ),
            ],
          ),
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
    );
  }
}

Future getDataBasesFromFirestore() async {
  // Getting available items database
  customVariables.ItemsDB!.clear();
  var collectionReference = await FirebaseFirestore.instance
      .collection('items')
      .where('AvailableUntil', isGreaterThan: Timestamp.now());

  await collectionReference.get().then((QuerySnapshot snapshot) {
    snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
      Map<String, dynamic> ds = documentSnapshot.data() as Map<String, dynamic>;

      customVariables.ItemsDB![documentSnapshot.id] =
          documentSnapshot.data() as Map<String, dynamic>;
    });
  });

  // Getting users database
  customVariables.usersDB!.clear();
  customVariables.activeListingSellers.clear();
  var userReference = await FirebaseFirestore.instance
      .collection('user')
      .where('Type', isEqualTo: "Seller");

  await userReference.get().then((QuerySnapshot snapshot) {
    snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
      Map<String, dynamic> ds = documentSnapshot.data() as Map<String, dynamic>;

      customVariables.usersDB![documentSnapshot.id] =
          documentSnapshot.data() as Map<String, dynamic>;
    });
  });

  // Counting number of active (for sale) items per seller
  // Move this to server side for efficient code
  List<String>? itemsSellerIDList = [];
  // var sellerIDList = customVariables.usersDB!.keys.toList();
  customVariables.ItemsDB!.forEach((Key, value) {
    itemsSellerIDList.add(value['userID']);
  });
  itemsSellerIDList!.length > 0
      ? {
          for (var sellerID in itemsSellerIDList!)
            {
              if (customVariables.activeListingSellers.containsKey(sellerID))
                {
                  customVariables.activeListingSellers[sellerID] =
                      customVariables.activeListingSellers![sellerID]! + 1
                }
              else
                {customVariables.activeListingSellers[sellerID] = 1}
            }
        }
      : null;
  List<String> sellersWithItems =
      customVariables.activeListingSellers.keys.toList();
  print(sellersWithItems);
  customVariables.activeListingSellers.forEach((key, value) {
    customVariables.usersDB![key] != null
        ? customVariables.usersDB![key]["activeItemNumber"] = value
        : null;
  });

  // print("Active sellers list - ${customVariables.activeListingSellers}");
}
