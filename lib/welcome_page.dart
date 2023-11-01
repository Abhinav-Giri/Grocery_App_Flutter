import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery_app/login_page.dart';
import 'package:grocery_app/models/cart_model.dart';
import 'package:grocery_app/myShop.dart';
import 'package:grocery_app/services/api.dart';
import 'package:grocery_app/services/quantity.dart';
import 'package:grocery_app/signup_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: WelcomePage(),
//   ));
// }

class WelcomePage extends StatelessWidget {
  // checkLogin() async {
  //   var sp = await SharedPreferences.getInstance();
  //   isLoggedIn = sp.getBool('keylogin')!;

  //   Timer(Duration(seconds: 2), () {
  //     if (isLoggedIn != null) {
  //       if (isLoggedIn) {
  //         Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: (context) => MyShop()));
  //         return;
  //       } else {
  //         Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: (context) => LoginPage()));
  //         return;
  //       }
  //     } else {
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => LoginPage()));
  //       return;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Welcome",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Automatic identity verification which enables you to verify your identity",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[700], fontSize: 15),
                    )
                  ],
                ),
                // Container(
                //   height: MediaQuery.of(context).size.height / 3,
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                Image.asset(
                  'assets/images/illustrations.jpg',
                  height: (screenSize.height < 490)
                      ? 0
                      : (screenSize.height < 654)
                          ? MediaQuery.of(context).size.height / 3
                          : MediaQuery.of(context).size.height / 2,
                ),
                // ),
                Column(
                  children: <Widget>[
                    MaterialButton(
                      minWidth: (screenSize.width > 1100)
                          ? screenSize.width * .35
                          : (screenSize.width > 950)
                              ? screenSize.width * .5
                              : (screenSize.width > 850)
                                  ? screenSize.width * .75
                                  : double.infinity,
                      height: 60,
                      onPressed: () async {
                        var sp = await SharedPreferences.getInstance();
                        var check = await sp.getBool('login');
                        final String outCount =
                            await sp.getInt('updatedCount').toString();
                        final String userId =
                            await sp.getString('userIds').toString();

                        // }

                        if (check == true) {
                          String storedJson =
                              await sp.getString('myCartList').toString();
                          // if (storedJson != null) {
                          List<dynamic>? newList = await jsonDecode(storedJson);
                          if (newList != null) {
                            await Quantity.postCount(outCount, userId, newList);
                            var directLoginEmail =
                                await sp.getString('userEmail').toString();
                            debugPrint('emailllllll${directLoginEmail}');
                            debugPrint('emailllllll${newList}');
                            var response = await Api.getcredentials(
                                directLoginEmail, true);
                            int count = response['count'];
                            var shopItems = response['shopItems'];
                            debugPrint('sssssssssssssss${shopItems}');
                            String id = response['ids'].toString();
                            Provider.of<CartModel>(context, listen: false)
                                .updateCount(id, count, shopItems);
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyShop()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        }
                        // setState(() {});
                      },
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                          )),
                      child: MaterialButton(
                        // minWidth: double.infinity,
                        minWidth: (screenSize.width > 1100)
                            ? screenSize.width * .35
                            : (screenSize.width > 950)
                                ? screenSize.width * .5
                                : (screenSize.width > 850)
                                    ? screenSize.width * .75
                                    : double.infinity,
                        height: 60,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
                        },
                        color: Colors.yellow,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

var isLoggedIn = true;
