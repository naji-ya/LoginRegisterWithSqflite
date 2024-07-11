import 'package:sqflite/sqflite.dart' as sqfl ;

class Sqfldatabase{
  // create database

  static Future<sqfl.Database> openDb()async{
    return sqfl.openDatabase('datauser.db',version: 1,
    onCreate: (sqfl.Database db ,int version)async {
      await createTable(db);
    }
    );
  }
// CREATE TABLE
  static Future<void>createTable(sqfl.Database db) async{
    await db.execute("""CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name TEXT,
    email TEXT,
    password TEXT
    )""");


  }

  //create new user
static Future<int > AddNewUser(String name,String email,String password) async{
    final db=await Sqfldatabase.openDb();
    final data={'name':name,'email':email,'password':password};
    final id =db.insert('user', data);
    return id;
}

static Future<List<Map>> checkUser (String Email1) async{
    final db=await Sqfldatabase.openDb();
    final data=await db.rawQuery("SELECT * FROM user WHERE email ='$Email1'");
    if(data.isNotEmpty){
      return data;

    }
    return data;
}

static Future<List<Map>>checkLogin(String email ,String password) async{
    final db=await Sqfldatabase.openDb();
    final data=await db.rawQuery("SELECT * FROM user WHERE email ='$email' AND password ='$password'");
    if(data.isNotEmpty){
      return data;
    }
    return data;
}

static Future<List<Map>> getAll()async{
    final db=await Sqfldatabase.openDb();
    final data=db.rawQuery("SELECT * FROM user");
    return data;
}

static Future<void> deleteUser(int id)async {
    final db=await Sqfldatabase.openDb();
    db.delete('user',where: 'id=?',whereArgs: [id]);
}

}