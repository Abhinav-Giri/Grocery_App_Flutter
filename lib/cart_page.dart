import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/cart_model.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: FadeInLeft(
            child: Text(
              'My Cart',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.blueGrey,
              ),
            ),
          ),
        ),
      ),
      body: Consumer<CartModel>(
        builder: (context, value, index) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: value.cartItems.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ZoomIn(
                        duration: Duration(milliseconds: 1500),
                        child: Container(
                          color: Colors.amber,
                          child: Dismissible(
                            key: Key(value.cartItems[index]
                                [0]), // Unique key for each item
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 16),
                              child: Icon(Icons.cancel, color: Colors.white),
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              // Remove the item from the cart and rebuild the list
                              Provider.of<CartModel>(context, listen: false)
                                  .removeItemFromCart(index);
                            },
                            child: ListTile(
                                leading: Image.asset(value.cartItems[index][2]),
                                title: Text(value.cartItems[index][0]),
                                subtitle:
                                    Text('Rs.' + value.cartItems[index][1]),
                                trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () => {
                                          Provider.of<CartModel>(context,
                                                  listen: false)
                                              .removeItemFromCart(index),
                                        })),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              BounceInDown(
                delay: Duration(milliseconds: 1000),
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 22, 230, 29),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(14),
                      child: Column(
                        children: [
                          Text("Total Price",
                              style: TextStyle(
                                  color: Colors.black26,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                          Text('Rs.' +
                              Provider.of<CartModel>(context, listen: false)
                                  .calculateTotal()),
                        ],
                      )),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
