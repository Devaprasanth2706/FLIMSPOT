import 'dart:math';

import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget{
  
  TextEditingController email = TextEditingController();
  TextEditingController password =TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:
      AppBar(title:Text("Login Page"),titleTextStyle: TextStyle(color: Colors.white),backgroundColor: const Color.fromARGB(255, 254, 17, 0),),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child:Column(crossAxisAlignment: CrossAxisAlignment.stretch,
        children:[
          TextField(
            controller :email,
            decoration: InputDecoration(
              labelText: 'Email',
            ),
            obscureText: false,
          ),
          SizedBox(height: 10),
          TextField(
            controller :password,
            decoration: InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
          ),
          
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 241, 50, 37),
            ),
            child: Text("Login",style: TextStyle(color: Colors.white),),
            onPressed: (){
              if(email.text.trim().isNotEmpty && password.text.isNotEmpty)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              else if(email.text.trim().isEmpty &&
                      password.text.isEmpty )
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content:Text("Please enter email and password"))
                );
              else if(email.text.trim().isEmpty )
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content:Text("Please enter email"))
                );  
              else
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content:Text("Please enter password"))
                );
              
            },
          )  
        ]
        )
      )
      );
}}