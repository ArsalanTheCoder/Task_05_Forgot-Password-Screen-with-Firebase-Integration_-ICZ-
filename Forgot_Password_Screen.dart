import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();


  Future<void> ForgotPassword() async{

    String email = emailController.text.toString();
    if(email.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please enter your email!",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT
      );
      return;
    }

      try{
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
          Fluttertoast.showToast(
              msg: "Successfully Email Send.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );

      }on FirebaseAuthException catch(e) {
        Fluttertoast.showToast(
          msg: "error ${e.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password "),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          SizedBox(height: 150),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
             labelText: "Email",
             prefixIcon: Icon(Icons.email),
              filled: true,
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(onPressed: (){
           ForgotPassword();
          },
              child: Text("Forgot Password"))
        ],
      )
    );
  }
}
