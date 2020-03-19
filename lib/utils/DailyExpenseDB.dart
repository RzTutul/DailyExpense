import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DailyExpenseDB {
  Database _database;
  Future openDB() async{
    if(_database == null)
    {
      _database = await openDatabase(
    join(await getDatabasesPath(), "expenseDB.db"),
       version: 2,
       onCreate: (Database db,int version)async{
         await db.execute("CREATE TABLE dailyExptbl(e_id INTEGER PRIMARY KEY AUTOINCREMENT,e_name TEXT,e_amount INTEGER)");

      });
    }
  }
  Future<int> insertExpense(ExpensePojo expensePojo)async
  {
    await openDB();
    return await _database.insert('dailyExptbl', expensePojo.toMap());
  }

  Future<List<ExpensePojo>>getExpenseList() async{
    await openDB();
    final List<Map<String,dynamic>>maps = await _database.query('dailyExptbl');

    return List.generate(maps.length, (i){

      return ExpensePojo(id: maps[i]['e_id'],e_name: maps[i]['e_name'],e_amount: maps[i]['e_amount']);
    });
  }
    
  Future<int> updateExpense(ExpensePojo expensePojo) async {
    await openDB();
    return await _database.update('dailyExptbl', expensePojo.toMap(),
        where: "e_id = ?", whereArgs: [expensePojo.id]);
  }
  Future<void> deleteStudent(int id) async {
    await openDB();
    await _database.delete('dailyExptbl', where: "e_id = ?", whereArgs: [id]);
  }  

  }

class ExpensePojo {
  int id;
  String e_name;
  int e_amount;
  ExpensePojo({
    this.id,
    this.e_name,
    this.e_amount,
  });

  Map<String,dynamic> toMap(){

    return{
      'e_id':id,
      'e_name':e_name,
      'e_amount':e_amount
    };
  }

  
}
