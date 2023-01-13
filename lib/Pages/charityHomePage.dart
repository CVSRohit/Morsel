import 'package:flutter/material.dart';

import '../Widgets/categorySelector.dart';
import '../Widgets/sellerCard.dart';
import 'charityProfilePage.dart';

class charityHomePage extends StatelessWidget {
  const charityHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => null,
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
                  "Available donations",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              // Recommendations list view

              Container(
                height: 513,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // sellerCard(),
                      // sellerCard(),
                      // sellerCard(),
                      // sellerCard(),
                      // sellerCard(),
                      // sellerCard(),
                      // sellerCard(),
                    ],
                  ),
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
                    MaterialPageRoute(builder: (context) => charityHomePage())),
                child: Column(children: [
                  Icon(Icons.map_outlined, size: 35),
                  Text("Map")
                ])),
            GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => charityHomePage())),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.search,
                          size: 35, color: Colors.green.shade900),
                      Text("Donations",
                          style: TextStyle(
                              color: Colors.green.shade900,
                              fontWeight: FontWeight.bold))
                    ])),
            GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => charityProfilePage())),
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
