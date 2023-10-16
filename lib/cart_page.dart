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
          // Create a set to keep track of unique products in the cart
          // final item = value.cartItems;
          // final productKey = item[0];
          // Set uniqueList = Set.from(item);
          // List uniquelistOfArrays = uniqueList.toList();

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  // itemCount: Set.from(value.cartItems).length,
                  itemCount: value.cartItems.length,
                  itemBuilder: (context, index) {
                    // final item = value.cartItems[index];
                    // final productKey = item[0];
                    // Set<List<String>> setOfArrays = Set<List<String>>.fromitem.contains
                    // Set<List<String>> setOfArrays =
                    //     Set<List<String>>.from(value.cartItems);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ZoomIn(
                        duration: Duration(milliseconds: 1500),
                        child: Container(
                          child: Dismissible(
                            key: Key((value.cartItems)[index]
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
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        value.cartItems[index][2],
                                        height: 50,
                                        width: 50,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Text(value.cartItems[index][0]),
                                            Text('Rs.' +
                                                value.cartItems[index][1] +
                                                '/piece'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('Quantity: ' +
                                            value.cartItems[index][4]
                                                .toString()),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.center,
                                        //   children: [
                                        //     IconButton(
                                        //       icon: Icon(Icons
                                        //           .remove_circle_outline_outlined),
                                        //       onPressed: () => {
                                        //         Provider.of<CartModel>(
                                        //                 context,
                                        //                 listen: false)
                                        //             .removeItemFromCart(
                                        //                 index),
                                        //       },
                                        //     ),
                                        //     Container(
                                        //       height:
                                        //           20, // Adjust the height as needed
                                        //       width:
                                        //           1, // Width of the separator line
                                        //       color: Colors
                                        //           .black, // Color of the separator line
                                        //     ),
                                        //     IconButton(
                                        //       icon: Icon(Icons
                                        //           .add_circle_outline_rounded),
                                        //       onPressed: () => {
                                        //         Provider.of<CartModel>(
                                        //                 context,
                                        //                 listen: false)
                                        //             .addItemToCart(index),
                                        //       },
                                        //     )
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () => {
                                                    Provider.of<CartModel>(
                                                            context,
                                                            listen: false)
                                                        .removeItemFromCart(
                                                            index),
                                                  }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
