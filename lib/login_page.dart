import 'package:flutter/material.dart';
import 'package:grocery_app/home_page.dart';
import 'package:grocery_app/main_page.dart';
import 'package:grocery_app/models/cart_model.dart';
import 'package:grocery_app/myShop.dart';
import 'package:grocery_app/services/api.dart';
import 'package:grocery_app/signup_page.dart';
import 'package:grocery_app/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:login_page_day_23/animation/FadeAnimation.dart';
final _formKey = GlobalKey<FormState>();

class LoginPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool checkLogin = false;
  var id;
  // LoginPage(String text, {super.key});

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? password) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (password == '') {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(password!)) {
        return ("Please enter correct password");
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        // brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Login to your account",
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          makeInput("Email", false, validateEmail,
                              _emailController, 'Enter your email', context),
                          makeInput(
                              "Password",
                              true,
                              validatePassword,
                              _passwordController,
                              'Enter your password',
                              context),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        padding: EdgeInsets.only(top: 3, left: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.black),
                        ),
                        child: MaterialButton(
                          minWidth: (screenSize.width > 1100)
                              ? screenSize.width * .35
                              : (screenSize.width > 950)
                                  ? screenSize.width * .5
                                  : (screenSize.width > 850)
                                      ? screenSize.width * .75
                                      : double.infinity,
                          height: 60,
                          onPressed: () async {
                            _formKey.currentState!.validate();
                            var sp = await SharedPreferences.getInstance();
                            sp.setBool('login', true);
                            if (_formKey.currentState!.validate()) {
                              var response = await Api.getcredentials(
                                  _emailController.text, checkLogin);
                              bool checkLogins = response['checkLogins'];
                              String id = response['ids'];
                              Provider.of<CartModel>(context, listen: false)
                                  .updateCount(id);
                              if (checkLogins) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        // builder: (context) => MyShop(id:id)));
                                        builder: (context) => MyShop()));
                              } else {
                                final snackBar = SnackBar(
                                  content: Text('Please do SignUp first!'),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackBar); // Show the SnackBar
                              }
                            }
                          },
                          color: Colors.greenAccent,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    screenSize.width > 300
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Don't have an account?"),
                              InkWell(
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpPage()))
                                },
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Text("Don't have an account?"),
                              InkWell(
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()))
                                },
                                child: Text(
                                  " Sign up",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover)),
            )
          ],
        ),
      ),
    );
  }

  Widget makeInput(
      label, obscureText, validate, controller, hintText, context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: (screenSize.width > 1100)
              ? screenSize.width * .35
              : (screenSize.width > 950)
                  ? screenSize.width * .5
                  : (screenSize.width > 850)
                      ? screenSize.width * .75
                      : double.infinity,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              hintText: hintText,
            ),
            validator: validate,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
