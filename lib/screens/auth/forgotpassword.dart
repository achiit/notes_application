import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:notesapp/services/auth/authservices.dart';
import 'package:notesapp/widgeets/custombutton.dart';
import 'package:notesapp/widgeets/customtextformfield.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  var auth = AuthServices();
  final TextEditingController _emailcontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 229, 229),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
          "Forgot Password",
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
                Wrap(
                  children: [
                    Text(
                        "Please enter your account’s email address and we will send you a link to reset your password.")
                  ],
                ),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 140,
                        ),
                        CustomTextFormField(
                          controller: _emailcontroller,
                          hinttext: "yourmail@gmail.com",
                          labeltext: "Email Address",
                          icon: Icons.email_outlined,
                          obscure: false,
                          validate: (value) {
                            return value!.isEmpty
                                ? "The field cannot be empty"
                                : null;
                          },
                        ),
                        SizedBox(
                          height: 130,
                        ),
                        CustomButton(
                          onpressed: () {
                            if (_formkey.currentState!.validate()) {
                              var message =
                                  auth.resetPassword(_emailcontroller.text);
                              print(message);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "The link has been sent to your email",
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            }
                          },
                          buttoncolor: Color(0xffFFB347),
                          textcolor: Colors.white,
                          title: "SUBMIT",
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      )),
      //body: ,
    );
  }
}
