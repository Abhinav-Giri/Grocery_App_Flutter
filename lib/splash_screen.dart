import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/cart_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(children: [
        Expanded(
            child: Image.asset('assets/images/shopping_cart.png',
                width: 200, height: 200)),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Prepairing your cart..',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ]),
      splashIconSize: 200,
      splashTransition: SplashTransition.rotationTransition,
      backgroundColor: Colors.limeAccent,
      duration: 1000,
      nextScreen: CartPage(),
    );
  }
}
