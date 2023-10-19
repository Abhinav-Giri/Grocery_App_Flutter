import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_app/login_page.dart';
import 'package:grocery_app/services/api.dart';

import 'package:http/http.dart' as http;

final _formKey = GlobalKey<FormState>();

class SignUpPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
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
        // ("Password must contain atleast 8 charachters 1 Upper case,1 lowercase,1 Numeric Number,1 Special Character");
      } else {
        return null;
      }
    }
  }

  String? validateConfirmPassword(String? confirmPassword) {
    if (confirmPassword != _passwordController.text) {
      return 'Password and Confirm Password must be same';
    }
    return null;
  }

  // Future apiCall(data) async {
  //   try {
  //     final res = await http.post(Uri.parse('http://localhost:3001/api/signup'),
  //         body: data);
  //     if (res.statusCode == 200) {
  //       var data = jsonDecode(res.body.toString());
  //       debugPrint(data);
  //     } else {
  //       debugPrint('Not able to post');
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Sign up",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create an account, to manage your cart!",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    makeInput("Email", false, validateEmail, _emailController,
                        'Enter your email', context),
                    makeInput("Password", true, validatePassword,
                        _passwordController, 'Enter your password', context),
                    makeInput(
                        "Confirm Password",
                        true,
                        validateConfirmPassword,
                        _confirmPasswordController,
                        'Confirm your password',
                        context),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 3, left: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.black)),
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

                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                        var data = {
                          'email': _emailController.text,
                          'password': _passwordController.text
                        };
                        Api.apiCall(data);
                        // await http.post(
                        //     Uri.parse('http://localhost:3001/api/signup'),
                        //     body: data);
                        // final res = await http.post(
                        //     Uri.parse('http://localhost:3001/api/signup'),
                        //     body: data);
                        // if (res.statusCode == 200) {
                        //   var data = jsonDecode(res.body.toString());
                        // } else {
                        //   debugPrint('Not able to post');
                        // }

                        // apiCall(data);
                      }
                    },
                    color: Colors.greenAccent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      "Sign up",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                ),
                screenSize.width > 300
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Already have an account?"),
                          InkWell(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()))
                            },
                            child: Text(
                              " Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Text("Already have an account?"),
                          InkWell(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()))
                            },
                            child: Text(
                              " Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ],
                      )
              ],
            ),
          ),
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
              fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
