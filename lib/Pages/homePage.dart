import 'package:flutter/material.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => null,
                child: Center(
                  child: Container(
                    width: 200,
                    padding: EdgeInsets.all(10),
                    color: Colors.grey,
                    child: Row(
                      children: [
                        Text("105 St. George st"),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
