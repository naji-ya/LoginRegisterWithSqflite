import 'package:flutter/material.dart';
import 'package:login_register_sqflite/adminHome.dart';
import 'package:login_register_sqflite/database.dart';
import 'package:login_register_sqflite/register_page.dart';
import 'package:login_register_sqflite/userHome.dart';



class Login_Page extends StatefulWidget {

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {

  var formkey1 =GlobalKey<FormState>();
  var email =TextEditingController();
  var password = TextEditingController();


  void logincheck(String email, String password) async {


    if (email == 'admin@gmail.com' && password == '123456') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Adminuser()));
    }

    else {
      var data = await Sqfldatabase.checkLogin(email, password);
      if (data.isNotEmpty) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => UserHome(data: data,)));
        print('Login Success');
      }
      else if (data.isEmpty) {

        print('Login faild');
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,

      body: SingleChildScrollView(
        child: Form(
          key: formkey1,
          child: Padding(
            padding: const EdgeInsets.only(top: 190,left: 30,right: 30),
            child: Column(
              children: [
                Icon(Icons.lock_outline,size: 80,),
                SizedBox(height: 50,),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: "email",
                    border: OutlineInputBorder(

                    ),
                  ),
                  validator: (email){
                    if( email !.isEmpty && email.contains("@") && email.contains("."))
                      return "Invalid email";
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(

                    ),
                  ),
                  validator: (password){
                    if(password !.isEmpty || password.length<6)
                      return "invalid password";
                  },
                ),
                SizedBox(height: 50,),

                ElevatedButton(onPressed: (){
                  final valid1=formkey1.currentState!.validate();
                  if(valid1){

                    logincheck(email.text,password.text);
                  }


                }, child: Text("Login",
                  style: TextStyle(
                  fontSize: 20,fontWeight: FontWeight.bold
                ),),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black54,
                    minimumSize: Size(350, 50)),),

                Padding(
                  padding: const EdgeInsets.only(top: 80,
                  right: 20,left:20),
                  child: Row(
                    children: [
                      Text("create an account? ",style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),) ,TextButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                      },
                          child: TextButton(

                          onPressed: () {  }, child: Text("Register",style: TextStyle(

                            fontSize: 18,),)),),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),

    );
  }


}
