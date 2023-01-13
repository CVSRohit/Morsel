import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:morsel_application_1/Pages/sellerHomePage.dart';
import 'package:morsel_application_1/Pages/sellerProfile.dart';
import 'package:morsel_application_1/Widgets/inputTextBox.dart';
import 'package:morsel_application_1/Widgets/theActionButton.dart';
import 'package:morsel_application_1/constants/customVariables.dart'
    as customVariables;

import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

customVariables.itemSKU newItem = customVariables.itemSKU();
Color _timingErrorColor = Colors.white;
XFile? imageFile = null;

class sellerAddItem extends StatefulWidget {
  const sellerAddItem({super.key});

  @override
  State<sellerAddItem> createState() => _sellerAddItemState();
}

class _sellerAddItemState extends State<sellerAddItem> {
  DateTime? date = null;
  TimeOfDay? time = null;
  @override
  bool isDonate = false;
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                        // padding: EdgeInsets.only(5),
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
                      Text(
                          customVariables.activeUser.businessAddress.toString())
                    ],
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  var statusCamera = await Permission.camera.status;
                  var statusGallery = await Permission.photos.status;
                  ImagePicker imagePicker = new ImagePicker();
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext bc) {
                        return Container(
                            child: Wrap(children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListTile(
                                title: Text('Camera'),
                                leading: Icon(Icons.camera),
                                onTap: () async {
                                  if (statusCamera.isGranted == false) {
                                    await Permission.camera.request();
                                  }
                                  imageFile = await imagePicker.pickImage(
                                      source: ImageSource.camera);
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: Text('Gallery'),
                                leading: Icon(Icons.photo_album),
                                onTap: () async {
                                  if (statusGallery.isGranted == false) {
                                    await Permission.photos.request();
                                  }
                                  imageFile = await imagePicker.pickImage(
                                      source: ImageSource.gallery);
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(height: 30),
                            ],
                          ),
                        ]));
                      });
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(width: 2, color: Colors.grey.shade400),
                  ),
                  child: imageFile != null
                      ? Container(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.bottomRight,
                            child: Icon(
                              Icons.camera_alt,
                              size: 40,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            backgroundBlendMode: BlendMode.lighten,
                            color: customVariables.greyTransparentColor,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                alignment: FractionalOffset.center,
                                image: AssetImage(imageFile!.path)),
                          ))
                      : Icon(
                          Icons.camera_alt,
                          color: Colors.green.shade900,
                          size: 80,
                        ),
                  height: 150,
                  width: 300,
                ),
              ),
              inputTextBox(
                hintText: "Name",
                obscureText: false,
                onTextChanged: (value) {
                  setState(() {
                    newItem.name = value;
                  });
                },
              ),
              inputTextBox(
                hintText: "Price",
                obscureText: false,
                onTextChanged: (value) {
                  setState(() {
                    try {
                      newItem.price = double.parse(value);
                    } catch (e) {
                      print(e);
                    }
                  });
                },
              ),
              inputTextBox(
                hintText: "Quantity",
                obscureText: false,
                onTextChanged: (value) {
                  setState(() {
                    newItem.quantity = int.parse(value);
                  });
                },
              ),
              inputTextBox(
                hintText: "Type",
                obscureText: false,
                onTextChanged: (value) {
                  setState(() {
                    newItem.type = value;
                  });
                },
              ),
              Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Available for sale until",
                          textAlign: TextAlign.left,
                        ),
                        TextButton(
                            onPressed: () async {
                              date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(DateTime.now().year),
                                  lastDate: DateTime(DateTime.now().year + 1));
                              time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              if (date == null) return;
                              setState(() {
                                newItem.availableUntil = DateTime(
                                    date!.year,
                                    date!.day,
                                    date!.day,
                                    time!.hour,
                                    time!.minute);
                              });
                            },
                            child: Text(newItem.availableUntil == null
                                ? "Pick date & time"
                                : "${newItem.availableUntil!.month}/${newItem.availableUntil!.day} ${newItem.availableUntil!.hour}:${newItem.availableUntil!.minute}"))
                      ],
                    ),
                    Visibility(
                      visible: isDonate,
                      child: Column(
                        children: [
                          Text(
                            "Available for charity until",
                            textAlign: TextAlign.left,
                          ),
                          TextButton(
                              onPressed: () async {
                                DateTime? date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(DateTime.now().year),
                                    lastDate:
                                        DateTime(DateTime.now().year + 1));
                                TimeOfDay? time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now());
                                if (date == null) return;
                                setState(() {
                                  newItem.availableUntilCharity = DateTime(
                                      date.year,
                                      date.day,
                                      date.day,
                                      time!.hour,
                                      time.minute);
                                  newItem.availableUntil!.isAfter(
                                          newItem.availableUntilCharity!)
                                      ? _timingErrorColor = Colors.red
                                      : _timingErrorColor = Colors.white;
                                });
                              },
                              child: Text(newItem.availableUntilCharity == null
                                  ? "Pick date & time"
                                  : "${newItem.availableUntilCharity!.month}/${newItem.availableUntilCharity!.day} ${newItem.availableUntilCharity!.hour}:${newItem.availableUntilCharity!.minute}"))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      value: isDonate,
                      activeColor: Colors.green.shade900,
                      onChanged: (value) {
                        setState(() {
                          isDonate = value!;
                        });
                      }),
                  Text("Donate to charities post Available Until time")
                ],
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6),
                  child: Text(
                    "Available for charity until is before Available for sale, please correct",
                    style: TextStyle(color: _timingErrorColor),
                  ),
                ),
              ),
              theActionButton(
                buttonText: "Add Morsel",
                onTap: () async {
                  newItem.donateLater = isDonate;
                  await addNewItem();
                  setState(() {});
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => sellerHomePage()));
                },
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
                    MaterialPageRoute(builder: (context) => sellerHomePage())),
                child: Column(
                    children: [Icon(Icons.list, size: 35), Text("Listings")])),
            GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => sellerAddItem())),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.add, size: 35, color: Colors.green.shade900),
                      Text("Add Item",
                          style: TextStyle(
                              color: Colors.green.shade900,
                              fontWeight: FontWeight.bold))
                    ])),
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

addNewItem() async {
  try {
    final db = await FirebaseFirestore.instance;
    final item = <String, dynamic>{
      "userID": customVariables.activeUser.userID.toString(),
      "BusinessName": customVariables.activeUser.businessName.toString(),
      "ItemName": newItem.name.toString(),
      "ItemPrice": newItem.price,
      "ItemQuantity": newItem.quantity,
      "ItemType": newItem.type.toString(),
      "AvailableUntil": newItem.availableUntil,
      "AvailableUntilCharity": newItem.availableUntilCharity,
      "DonateLater?": newItem.donateLater,
      "AvailabilityStatus":
          DateTime.now().isBefore(newItem.availableUntil!) ? true : false,
      "SaleStatus": false,
      "itemImageUrl": "",
    };
    try {
      DocumentReference docRef = await db.collection("items").add(item);
      newItem.id = docRef.id;
      await uploadFile();
      Map<String, dynamic> data = {"itemImageUrl": newItem.itemImageUrl};
      print(newItem.itemImageUrl);
      await docRef.update(data);
    } catch (e) {
      print("This one - $e");
    }
  } catch (e) {
    print("No no this one - $e");
  }
}

Future uploadFile() async {
  final fileName = newItem.id;
  final destination = 'itemImages/$fileName.jpg';

  try {
    final ref =
        firebase_storage.FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(imageFile!.path)).then(((p0) async {
      newItem.itemImageUrl = await ref.getDownloadURL();
      print(newItem.itemImageUrl);
    }));
  } catch (e) {
    print('error occured $e');
  }
}
