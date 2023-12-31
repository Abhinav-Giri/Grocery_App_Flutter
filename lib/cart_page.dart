import 'dart:convert';
// import 'dart:js';
import 'package:http/http.dart' as http;

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:grocery_app/models/cart_model.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<String, dynamic>? paymentIntent;
  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context);
    final screenSize = MediaQuery.of(context).size;
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
                            child: Align(
                              alignment: screenSize.width > 750
                                  ? Alignment.center
                                  : Alignment.centerLeft,
                              child: Container(
                                width: screenSize.width > 1300
                                    ? screenSize.width * .6
                                    : screenSize.width > 750
                                        ? screenSize.width * .75
                                        : double.infinity,
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
                      ),
                    );
                  },
                ),
              ),
              Column(
                children: [
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
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                    child: TextButton(
                      child: const Text('Make Payment'),
                      onPressed: () async {
                        print('Make payment button cliked');
                        await makePayment();
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('100', 'INR');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
                  googlePay: const PaymentSheetGooglePay(
                      testEnv: true,
                      currencyCode: "INR",
                      merchantCountryCode: "+92"),
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Rhizicube'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text("Payment Successfull"),
                        ],
                      ),
                    ],
                  ),
                ));
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

//  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      var secret_key =
          'sk_test_51OAVAkSCtO1xrkIusvNa4QzGZd36Evv5piDa97coLZJERZrHnGuWS7WiUPHEx3hFQw4GvZS3nTWN7JLxYVcG483b00vpvTQ6BN';
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secret_key',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }
}
