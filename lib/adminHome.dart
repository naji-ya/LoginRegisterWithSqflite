import 'package:flutter/material.dart';
import 'package:login_register_sqflite/database.dart';




class Adminuser extends StatefulWidget {
  const Adminuser({super.key});

  @override
  State<Adminuser> createState() => _AdminuserState();
}

class _AdminuserState extends State<Adminuser> {
  var data;
  void delete(int id )async{
    await Sqfldatabase.deleteUser(id);
    Refresh();

  }
  @override
  void initState() {
  Refresh();
    super.initState();
  }

  void Refresh()async {
    var mydata=await Sqfldatabase.getAll();
    setState(() {
      data=mydata;
    });
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(backgroundColor: Colors.black54,
      title:Text(" Admin Panel"),),
      body: ListView.builder(itemCount: data.length,itemBuilder: (context,int index){
        return Card(
          child: ListTile(
            title: Text('${data[index]['name']}'),
            trailing: IconButton(onPressed: (){
delete(data[index]['id']);
            }, icon: Icon(Icons.delete)),
          ),

        );
      }),
    );
  }
}

