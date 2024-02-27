import 'package:sqflite/sqflite.dart';

class MyDatabase{

  static late Database database;

  static Future<void> initliazeDatabase()async{

    String path = await getDatabasesPath();
    path += 'databasee.db';

   database = await openDatabase(
       path,
       version: 1,
     onCreate: (database,version){
         print('Create Database');
         database.execute('CREATE TABLE NOTE (id INTEGER PRIMARY KEY, title TEXT, description TEXT,date TEXT,time TEXT,finish BOOLEAN)').then((value){
           print('CREATE TABLE NOTE');
         }).catchError((error){
           print(error.toString());
         });
     },
     onOpen: (database){
         print('open Database');
     }
   );

  }

  static Future<int> insertRow({required title, required description, required date, required time,})async {
   int number = 0;
   await database.insert(
      'NOTE',
      {
        'title': title,
        'description': description,
        'date': date,
        'time': time,
        'finish': 0,
      },
    ).then((value) {
      number = value;
      print('${value} is inserted successfully');
    }).catchError((error) {
      print(error.toString());
    });

    return number;
  }

  static Future<List<Map<String,dynamic>>> getAllData()async{
    List<Map<String,dynamic>> data =[];
    await database.rawQuery('SELECT * FROM NOTE').then((value){

     data = value;

    }).catchError((error){
      print(error.toString());
    });

    return data;
  }

  static Future<void> updateFinish({required finish,required id})async{
    database.update(
        'NOTE',
      {
        'finish' : finish,
      },
      where: 'id = ?',
      whereArgs: [id]

    ).then((value){
      print('Updated successfully');
    }).catchError((error){
      print(error.toString());
    });
  }

  static Future<void> updateAllRow({required title, required description, required date,required id})async{
    database.update(
        'NOTE',
        {
           'title' : title,
           'description' : description,
            'date' : date
        },
        where: 'id = ?',
        whereArgs: [id]

    ).then((value){
      print('Updated successfully');
    }).catchError((error){
      print(error.toString());
    });
  }

  static Future<int> deleteRow({required id})async{
    int result = -1;
     await database.delete(
          'NOTE',
           where: 'id = ?',
           whereArgs: [id]
      ).then((value){
        result = value;
        print('$value is deleted successfully');
      }).catchError((error){
        print(error.toString());
      });

      return result;

  }

}


