import 'dart:ffi';

import 'package:flutter/material.dart';

// Colors
const Color morselGreenColor = Color.fromRGBO(126, 171, 85, 1);
const Color morselLiteGreen = Color.fromRGBO(112, 173, 71, 1);
const Color greyTransparentColor = Color.fromRGBO(0, 0, 0, 0.1);

// Constants
var cartCounter = 0;

// class seller {
//   String? sellerID;
//   int? sellerItemCount;
//   String? sellerAddress;
//   List<Image>? sellerImages;
//   seller(
//       {this.sellerID,
//       this.sellerItemCount,
//       this.sellerImages,
//       this.sellerAddress});
// }

class user {
  String? userID;
  String? userType;
  String? businessAddress;
  bool? loginStatus;
  String? emailID;
  String? password;
  String? confirmPassword;
  String? businessName;
  int? sellerItemCount;
  user(
      {this.userID,
      this.businessAddress,
      this.userType,
      this.loginStatus,
      this.emailID,
      this.password,
      this.confirmPassword,
      this.businessName,
      this.sellerItemCount});
  clear() {
    userID = null;
    businessAddress = null;
    userType = null;
    loginStatus = null;
    emailID = null;
    password = null;
    confirmPassword = null;
    businessName = null;
    sellerItemCount = 0;
  }
}

user activeUser = user(loginStatus: false);

class itemSKU {
  String? name;
  double? price;
  int? quantity;
  String? type;
  DateTime? availableUntil;
  bool? itemAvailable;
  bool? donateLater = false;
  DateTime? availableUntilCharity;
  String? id;
  String? itemImageUrl;

  itemSKU({
    this.name,
    this.price,
    this.quantity,
    this.type,
    this.availableUntil,
    this.itemAvailable,
    this.donateLater,
    this.availableUntilCharity,
    this.id,
    this.itemImageUrl,
  });
}

Map<String, Map<String, dynamic>>? ItemsDB = {};
Map<String, dynamic>? usersDB = {};
Map<String, int> activeListingSellers = {};

double cartTotalValue = 0;
Map<String, dynamic> ordersDB = {};

class orderConfirmed {
  String? buyerID;
  String? sellerID;
  List<String>? itemIDs;
  List<double>? itemPrices;
  List<int>? itemQuantities;
  double? billTotal;

  orderConfirmed({
    this.buyerID,
    this.sellerID,
    this.itemIDs,
    this.itemPrices,
    this.itemQuantities,
    this.billTotal,
  });
}

orderConfirmed newOrder = orderConfirmed();


    // "buyerID": customVariables.activeUser.userID.toString(),
    //   "sellerID": customVariables.activeUser.businessName.toString(),
    //   "BusinessName": customVariables.activeUser.businessName.toString(),
    //   "ItemName": newItem.name.toString(),
    //   "ItemPrice": newItem.price,
    //   "ItemQuantity": newItem.quantity,
    //   "ItemType": newItem.type.toString(),
    //   "BillTotal": 0,
