import 'package:flutter/material.dart';

class GroceryItemTile extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String imagePath;
  final String quantity;
  void Function()? onPressedAdd;
  void Function()? onPressedRemove;
  final color;

  GroceryItemTile(
      {Key? key,
      required this.itemName,
      required this.itemPrice,
      required this.imagePath,
      required this.color,
      required this.onPressedAdd,
      required this.onPressedRemove,
      required this.quantity})
      : super(key: key);

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
                        : (screenSize.width < 800)
                            ? 200
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
                                                : (screenSize.width >= 230)
                                                    ? 25
                                                    : 0,
              ),
              Text(
                itemName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Container(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(12)),
                child: Text(
                  'Rs. ' + itemPrice,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline_outlined),
                        onPressed: onPressedRemove,
                      ),
                      Container(
                        height: 20, // Adjust the height as needed
                        width: 1, // Width of the separator line
                        color: Colors.black, // Color of the separator line
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline_rounded),
                        onPressed: onPressedAdd,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('Quantity: ${quantity}'),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
