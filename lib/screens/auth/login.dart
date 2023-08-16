import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:notesapp/screens/homescreens/notesscreen/homescreen.dart';
import 'package:notesapp/screens/auth/createaccount.dart';
import 'package:notesapp/screens/auth/forgotpassword.dart';
import 'package:notesapp/services/auth/authservices.dart';
import 'package:notesapp/widgeets/custombutton.dart';
import 'package:notesapp/widgeets/customnavbar.dart';
import 'package:notesapp/widgeets/customtextformfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  var auth = AuthServices();
  bool loading = false;
  bool _obscuretext1 = true;
  Widget icons1 = Icon(
    Icons.visibility_outlined,
    size: 35,
  );

  void showPass1() {
    setState(() {
      _obscuretext1 = !_obscuretext1;
      if (_obscuretext1) {
        icons1 = Icon(
          Icons.visibility_outlined,
          size: 35,
        );
      } else {
        icons1 = Icon(
          Icons.visibility_off_outlined,
          size: 35,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 229, 229),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 229, 229, 229),
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Log In",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Welcome back !",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Please login with your credentials",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  Form(
                      child: Column(
                    children: [
                      SizedBox(
                        height: 140,
                      ),
                      CustomTextFormField(
                        controller: emailcontroller,
                        hinttext: "yourmail@gmail.com",
                        labeltext: "Email Address",
                        icon: Icons.email_outlined,
                        obscure: false,
                        validate: (value) {
                          return value!.contains('@')
                              ? "Do not use special characters"
                              : null;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomTextFormField(
                        controller: passcontroller,
                        hinttext: "**********",
                        labeltext: "Password",
                        suffixicon: Padding(
                          padding: const EdgeInsets.only(right: 13.0),
                          child: IconButton(
                            icon: icons1,
                            onPressed: () {
                              showPass1();
                            },
                          ),
                        ),
                        icon: Icons.lock_outlined,
                        obscure: _obscuretext1,
                        validate: (value) {
                          return value!.length < 8
                              ? "Password should be atleast 8 digits"
                              : null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgotPass(),
                                  ),
                                );
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 50),
                        child: Row(
                          children: [
                            Text("Don’t have an account yet ?"),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            child: Text(
                              "Create an account here",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  color: Color(0xffFFB347)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateAccount(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 130,
                      ),
                      CustomButton(
                        onpressed: () async {
                          setState(() {
                            loading = true;
                          });
                          try {
                            showDialog(
                              context: context,
                              builder: (context) => Center(
                                child: SpinKitCubeGrid(
                            size: 50,
                            color: Colors.orange,
                          ),
                              ),
                            );
                            await auth
                                .handleLogin(
                                    emailcontroller.text, passcontroller.text)
                                .then((User user) => setState(() {
                                      loading = false;
                                    }));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Color(0xffFFB347),
                                content: Text(
                                  "Login Successful",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            );

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomNavBar(),
                                ),
                                (route) => false);
                          } catch (e) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Color(0xffFFB347),
                                content: Text(
                                  "${e}",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        buttoncolor: Color(0xffFFB347),
                        textcolor: Colors.white,
                        title: "LOGIN",
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
