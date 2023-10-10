// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class GroceryItemTile extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String imagePath;
  void Function()? onPressed;
  final color;

  GroceryItemTile({
    Key? key,
    required this.itemName,
    required this.itemPrice,
    required this.imagePath,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
          height: 1000,
          // width: 20,
          decoration: BoxDecoration(
              color: color[100], borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Image.asset(
                imagePath,
                height: (screenSize.width > 1350 && screenSize.width < 1550)
                    ? 220
                    : (screenSize.width > 901 && screenSize.width < 1150)
                        ? 200
                        : (screenSize.width > 691 && screenSize.width < 800)
                            ? 220
                            : (screenSize.width) > 690
                                ? 280
                                : (screenSize.width >= 500 &&
                                        screenSize.width < 550)
                                    ? 125
                                    : (screenSize.width) > 500
                                        ? 130
                                        : (screenSize.width > 400 &&
                                                screenSize.width < 450)
                                            ? 80
                                            : (screenSize.width >= 291 &&
                                                    screenSize.width < 330)
                                                ? 30
                                                : (screenSize.width) > 290
                                                    ? 50
                                                    : 0,
                // width: (screenSize.width) >= 690 ? 250 : 100,
              ),
              SizedBox(
                  height: (screenSize.width > 690)
                      ? 2
                      : (screenSize.width > 600)
                          ? 22
                          : (screenSize.width > 330 && screenSize.width > 291)
                              ? 0
                              : (screenSize.width > 290)
                                  ? 20
                                  : 30),
              Text(
                itemName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              MaterialButton(
                  // minWidth: 10,
                  onPressed: onPressed,
                  color: color,
                  child: Text(
                    'Rs. ' + itemPrice,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ))
            ],
          )),
    );
  }
}
