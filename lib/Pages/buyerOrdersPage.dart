import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:morsel_application_1/constants/customVariables.dart'
    as customVariables;

class buyerOrderPage extends StatefulWidget {
  const buyerOrderPage({super.key});

  @override
  State<buyerOrderPage> createState() => _buyerOrderPageState();
}

class _buyerOrderPageState extends State<buyerOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
        backgroundColor: customVariables.morselGreenColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: Text(
                "Your order is succesful!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.green.shade900,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // child:
            // child: ListView.builder(),
          ),
        ],
      ),
    );
  }
}

// getOrdersData() async {
//   try {
//     customVariables.ordersDB = FirebaseFirestore.instance
//         .collection("Orders")
//         .where('buyerID',
//             isEqualTo: customVariables.activeUser.userID.toString())
//         .get();
//   } catch (e) {
//     print(e);
//   }
// }
