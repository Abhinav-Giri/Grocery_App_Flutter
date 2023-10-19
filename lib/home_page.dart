import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/main_page.dart';
import 'package:grocery_app/models/cart_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          FadeInDown(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 80.0, right: 80, bottom: 1, top: 20),
              child: Image.asset('assets/images/img_1.png'),
            ),
          ),
          FadeInUp(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                'We deliver vegetables at your doorstep',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          FlipInX(
              delay: Duration(milliseconds: 1000),
              child: Text('Fresh vegetables everyday')),
          const Spacer(),
          InkWell(
            onTap: () async {
              // SharedPreferences sp = await SharedPreferences.getInstance();

              // Provider.of<CartModel>(context).count = sp.getInt('count') ?? 0;

              await Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return MainPage();
                }),
              );
            },
            child: BounceInUp(
              delay: Duration(milliseconds: 1800),
              child: Container(
                decoration: BoxDecoration(color: Colors.amber),
                padding: EdgeInsets.all(10.0),
                child: Text('Get Started'),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    ));
  }
}
