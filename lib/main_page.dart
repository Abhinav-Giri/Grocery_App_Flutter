import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/cart_page.dart';
import 'package:grocery_app/components/grid_item.dart';
import 'package:grocery_app/models/cart_model.dart';
import 'package:grocery_app/splash_screen.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  // var count;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FadeInUpBig(
              delay: Duration(milliseconds: 1000),
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  "Let's order fresh vegetables for you..",
                  style: GoogleFonts.lato(
                      color: Colors.green,
                      fontWeight: FontWeight.w900,
                      fontSize: 35),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0, right: 20.0),
                child: FadeInLeftBig(
                  delay: Duration(milliseconds: 3000),
                  child: FloatingActionButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SplashScreen();
                        },
                      ),
                    ),
                    backgroundColor: Colors.brown,
                    // child: Icon(Icons.shopping_bag),
                    child: Stack(
                      children: [
                        // Display the image
                        Icon(Icons.shopping_cart, size: 40),
                        //   fit: BoxFit.cover, // Adjust the BoxFit as needed
                        //   width: double.infinity, // Set the width to fill the screen
                        //   height: double.infinity, // Set the height to fill the screen
                        // ),

                        // Overlay the text on top of the image
                        Positioned(
                          top: 8, // Adjust the top position as needed
                          left: 16, // Adjust the left position as needed
                          child: Text(
                            '${Provider.of<CartModel>(context).count}',
                            style: TextStyle(
                              color: Colors.brown, // Text color
                              fontSize: 12, // Text font size
                              fontWeight: FontWeight.bold, // Text font weight
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Divider(),
            Expanded(
              child: Consumer<CartModel>(
                builder: (context, value, child) {
                  return GridView.builder(
                    itemCount: value.shopItems.length,
                    // childAspectRatio: 20 / 50,
                    // controller: ScrollController(keepScrollOffset: false),
                    // shrinkWrap: true,
                    // scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (screenSize.width > 1350)
                            ? 4
                            : (screenSize.width > 900)
                                ? 3
                                : (screenSize.width > 300)
                                    ? 2
                                    : 1,
                        childAspectRatio: 1 / 1,
                        crossAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return FadeInDown(
                        child: GroceryItemTile(
                          itemName: value.shopItems[index][0],
                          itemPrice: value.shopItems[index][1],
                          imagePath: value.shopItems[index][2],
                          color: value.shopItems[index][3],
                          onPressedAdd: () =>
                              Provider.of<CartModel>(context, listen: false)
                                  .addItemToCart(index),
                          // value.shopItems[index][4] += 1,

                          onPressedRemove: () =>
                              Provider.of<CartModel>(context, listen: false)
                                  .deleteItemFromCart(index, context),
                          // value.shopItems[index][4] -= 1,

                          quantity: value.shopItems[index][4].toString(),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
