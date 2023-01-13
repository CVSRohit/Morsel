import 'package:flutter/material.dart';
import 'package:morsel_application_1/constants/customVariables.dart'
    as customVariables;

class categorySelector extends StatefulWidget {
  categorySelector(
      {super.key, required this.categoryNameText, required this.isSelected});
  String categoryNameText;
  bool isSelected;

  @override
  State<categorySelector> createState() => _categorySelectorState();
}

class _categorySelectorState extends State<categorySelector> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        setState(() {
          widget.isSelected = !widget.isSelected;
        })
      },
      child: Container(
        alignment: Alignment.center,
        child: Text(widget.categoryNameText),
        width: 100,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
        decoration: BoxDecoration(
            color: (widget.isSelected == false)
                ? Colors.grey.shade300
                : customVariables.morselLiteGreen,
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
