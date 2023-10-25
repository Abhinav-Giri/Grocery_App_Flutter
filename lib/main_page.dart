import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/Beverages/beverages.dart';
import 'package:grocery_app/Homegoods/homegoods.dart';
import 'package:grocery_app/cart_page.dart';
import 'package:grocery_app/components/grid_item.dart';
import 'package:grocery_app/fruits/fruits.dart';
import 'package:grocery_app/login_page.dart';
import 'package:grocery_app/models/cart_model.dart';
import 'package:grocery_app/services/quantity.dart';
import 'package:grocery_app/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatelessWidget {
  var id;
  MainPage({super.key});

  // var count;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            ListTile(
              title: const Text('Home Goods'),
              // selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                // _onItemTapped(0);
                // Then close the drawer
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeGoods()));
              },
            ),
            ListTile(
              title: const Text('Beverages'),
              // selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                // _onItemTapped(1);
                // Then close the drawer
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Beverages()));
              },
            ),
            ListTile(
              title: const Text('Fruits'),
              // selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                // _onItemTapped(2);
                // Then close the drawer
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Fruits()));
              },
            ),
            ListTile(
              title: const Text('Sign Out'),
              // selected: _selectedIndex == 0,
              onTap: () async {
                var sp = await SharedPreferences.getInstance();
                sp.setBool('login', false);
                // var dataId = returnId()
                String id = Provider.of<CartModel>(context, listen: false)
                    .dataId
                    .toString();
                String outCount = Provider.of<CartModel>(context, listen: false)
                    .count
                    .toString();
                var arr = await Provider.of<CartModel>(context, listen: false)
                    .cartItems;
                List<dynamic> newList = await arr.map((item) {
                  return [item[0], item[item.length - 1]];
                }).toList();
                await Quantity.postCount(outCount, id, newList);

                // await Quantity.postCartItems(id, newList);

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
                // Update the state of the app
                // _onItemTapped(0);
                // Then close the drawer
                // Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
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
                    onPressed: () async {
                      var sp_count = await SharedPreferences.getInstance();
                      sp_count.setInt(
                          'count', Provider.of<CartModel>(context).count);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SplashScreen();
                          },
                        ),
                      );
                    },
                    backgroundColor: Colors.brown,
                    // child: Icon(Icons.shopping_bag),
                    child: Stack(
                      children: [
                        // Display the image
                        Icon(Icons.shopping_cart, size: 40),

                        // Overlay the text on top of the image
                        Positioned(
                          top: 8, // Adjust the top position as needed
                          left: 15, // Adjust the left position as needed
                          child: Text(
                            '${Provider.of<CartModel>(context).count} ',
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (screenSize.width > 1350)
                            ? 4
                            : (screenSize.width > 900)
                                ? 3
                                : (screenSize.width > 300)
                                    ? 2
                                    : 1,
                        childAspectRatio: screenSize.width > 950
                            ? 1 / 1.15
                            : (screenSize.width > 900)
                                ? 1 / 1.5
                                : (screenSize.width > 850)
                                    ? 1 / 1.1
                                    : (screenSize.width > 600)
                                        ? 1 / 1.2
                                        : (screenSize.width > 500)
                                            ? 1 / 1.5
                                            : (screenSize.width > 375)
                                                ? 1 / 2
                                                : (screenSize.width > 300)
                                                    ? 1 / 2.5
                                                    : 1 / 1.5,
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
                          // .addItemToCart(index, id),
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

String count_cart = '';
@override
void initState() {
  // super.initState();
  isCount();
}

void isCount() async {
  SharedPreferences sp_count1 = await SharedPreferences.getInstance();
  count_cart = sp_count1.getInt('sp_count').toString();
  // if (count_cart != null) {
  //   count_cart = Provider.of<CartModel>(context).count.toString();
  // }
}
