import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:notesapp/screens/auth/login.dart';
import 'package:notesapp/screens/homescreens/notesscreen/homescreen.dart';
import 'package:notesapp/services/auth/authservices.dart';
import 'package:notesapp/widgeets/custombutton.dart';
import 'package:notesapp/widgeets/customnavbar.dart';
import 'package:notesapp/widgeets/customtextformfield.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool _obscuretext = true;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var auth = AuthServices();
  bool loading = false;
  String? _password;
  String? _confirmpass;
  Widget icons = Icon(
    Icons.visibility_outlined,
    size: 35,
  );
  void showPass() {
    setState(() {
      _obscuretext = !_obscuretext;
      if (_obscuretext) {
        icons = Icon(
          Icons.visibility_outlined,
          size: 35,
        );
      } else {
        icons = Icon(
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
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xffFFB347),
            size: 30,
          ),
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 229, 229, 229),
        title: Text(
          "Create Account",
          style: TextStyle(color: Colors.black, fontSize: 18),
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
                        "Let’s get to know you !",
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
                        "Enter your details to continue",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: namecontroller,
                          hinttext: "John Doe",
                          labeltext: "Display Name",
                          icon: Icons.person_outline,
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
                          onchange: (value) {
                            _password = value;
                          },
                          controller: passcontroller,
                          hinttext: "**********",
                          labeltext: "Password",
                          suffixicon: Padding(
                            padding: const EdgeInsets.only(right: 13.0),
                            child: IconButton(
                              icon: icons,
                              onPressed: () {
                                showPass();
                              },
                            ),
                          ),
                          icon: Icons.lock_outlined,
                          obscure: _obscuretext,
                          validate: (value) {
                            return value!.length < 8
                                ? "Password should be atleast 8 digits"
                                : null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CustomTextFormField(
                          onchange: (value) {
                            _confirmpass = value;
                          },
                          hinttext: "**********",
                          labeltext: "Confirm Password",
                          obscure: true,
                          validate: (value) {
                            return value!.length < 8
                                ? "Password should be atleast 8 digits"
                                : null;
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 40),
                    child: Row(
                      children: [
                        Text("Already have an account?"),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        child: Text(
                          "Login Here",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: Color(0xffFFB347)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 30),
                    child: Wrap(
                      children: [
                        RichText(
                          text: TextSpan(
                              text:
                                  "By clicking the “CREATE ACCOUNT” button, you agree to ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                              children: [
                                TextSpan(
                                  text: "Terms of Use ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: "and ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                TextSpan(
                                  text: "Privacy Policy ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    onpressed: () async {
                      setState(() {
                        loading = true;
                      });
                      if (_password != _confirmpass) {
                        setState(() {
                          loading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Color(0xffFFB347),
                            content: Text(
                              "Password and Confirm Password not matching",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      } else {
                        try {
                          showDialog(
                            context: context,
                            builder: (context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                          await auth
                              .handleCreateAccount(
                                  emailcontroller.text, passcontroller.text)
                              .then((User user) => setState(() {
                                    loading = false;
                                  }));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color(0xffFFB347),
                              content: Text(
                                "Account Created Successfully",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                          final User? user =
                              await FirebaseAuth.instance.currentUser;
                          final uid = user!.uid;
                          await firestore
                              .collection("notes-$uid")
                              .doc(uid)
                              .collection("userinfo")
                              .add({
                            "name": namecontroller.text,
                            "email": emailcontroller.text
                          });
                          print("the uid is ${uid}");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomNavBar()),
                            //(route) => false
                          );
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
                      }
                    },
                    buttoncolor: Color(0xffFFB347),
                    textcolor: Colors.white,
                    title: "CREATE ACCOUNT",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
