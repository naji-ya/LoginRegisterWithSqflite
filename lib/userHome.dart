import 'package:flutter/material.dart';





class UserHome extends StatelessWidget {
  final data;
  const UserHome({super.key, required  this.data});

  @override
  Widget build(BuildContext context) {
    var name=data[0]['name'];
    var email=data[0]['email'];
    return Scaffold(
      backgroundColor: Colors.yellow,
      
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text("Welcome $name"),
      ),
      
      body: Center(
        child: Text("Email:\t    $email",style: TextStyle(
          color: Colors.blue,
          fontSize: 24,
        ),),
      ),
    );
  }
}
