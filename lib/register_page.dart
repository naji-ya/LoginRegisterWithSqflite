import 'package:flutter/material.dart';


import 'database.dart';
import 'loginPage.dart';

void main(){
  runApp(MaterialApp(
    home: RegisterPage(),
  ));
}

class RegisterPage extends StatefulWidget {

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  var formkey= GlobalKey<FormState>();
  var name = TextEditingController();
  var email =TextEditingController();
  var password = TextEditingController();
  var ConfrmPassword =TextEditingController();
  @override
  Widget build(BuildContext context) {
    void Adduser(String name,String email,String password)async{
      var id=await Sqfldatabase.AddNewUser(name, email, password);
      if(id !=null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login_Page()));
      }
    }

    return Scaffold(
      backgroundColor: Colors.yellow,

      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.only(top: 190,left: 30,right: 30),
            child: Column(
              children: [
                Icon(Icons.lock_outline,size: 80,),
                SizedBox(height: 50,),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: "name",
                    border: OutlineInputBorder(

                    ),
                  ),
                  validator: (name){
                    if(name !.isEmpty)
                      return "Please enter a name";
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: "email",
                    border: OutlineInputBorder(

                    ),
                  ),
                 validator: (email){
                    if(email!.isEmpty && email.contains("@") && email.contains("."))
                      return "invalid";
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
                    if(password!.isEmpty || password.length<7)
                      return "Incorrect Password";
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: ConfrmPassword,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    border: OutlineInputBorder(

                    ),
                  ),
                  validator: (conpassword){
                    if(conpassword!.isEmpty || conpassword.length<7 && password.text==ConfrmPassword.text)
                      return "Incorrect Password";
                  },
                ),

                SizedBox(height: 50,),

                ElevatedButton(onPressed: ()async {
                  final valid1=formkey.currentState!.validate();

                  if(valid1){
                    String Email1=email.text;
                    var data= await Sqfldatabase.checkUser(Email1);


                    if(data.isNotEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(" User Already Exist!!")));
                    }
                    else{
                      Adduser(name.text, email.text, password.text);
                    }
                  }
                }, child: Text("Register",
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
                      Text("Already have an account? ",style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),) ,TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login_Page()));
                      },
                          child: Text("Login",style: TextStyle(
fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black
                          ),))
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


