import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:grocery_app/cart_page.dart';
import 'package:grocery_app/home_page.dart';
import 'package:grocery_app/login_page.dart';
import 'package:grocery_app/main_page.dart';
import 'package:grocery_app/models/cart_model.dart';
import 'package:grocery_app/myShop.dart';
import 'package:grocery_app/signup_page.dart';
import 'package:grocery_app/welcome_page.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51OAVAkSCtO1xrkIub59EnlV4DF9JMgkhwVyldBEBRpzeYHJl8Tm1TMB3k3Jau77ikiH9SNLLofHywKImibzqNATp00hnZixFd7";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartModel>(
      create: (context) => CartModel(),
      child: MaterialApp(
        title: 'Grocery App',
        debugShowCheckedModeBanner: false,
        home: MyShop(),
      ),
    );
  }
}
