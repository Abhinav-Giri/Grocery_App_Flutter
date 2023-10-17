import 'package:flutter/material.dart';

class Fruits extends StatelessWidget {
  const Fruits({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            alignment: screenSize.width > 920
                ? Alignment.centerLeft
                : Alignment.center,
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset('assets/images/fruits.jpg'),
                  SizedBox(height: 15),
                  Text('Home Goods',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
