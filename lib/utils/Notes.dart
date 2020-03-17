import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class NoteDBManager {
  Database _database; //Singleton object

  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(join(await getDatabasesPath(), "note.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE notetbl(id INTEGER PRIMARY KEY autoincrement, message TEXT)",
        );
      });
    }
  }

  Future<int> insertStudent(NotePojo note) async {
    await openDb();
    return await _database.insert('notetbl', note.toMap());
  }
  Future<List<NotePojo>> getnoteList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('notetbl'); ///Select * from notetbl;
    return List.generate(maps.length, (i) {
      return NotePojo(id: maps[i]['id'], message: maps[i]['message']);
    });
  }

  Future<int> updateStudent(NotePojo notePojo) async {
    await openDb();
    return await _database.update('notetbl', notePojo.toMap(),
        where: "id = ?", whereArgs: [notePojo.id]);
  }
  Future<void> deleteStudent(int id) async {
    await openDb();
    await _database.delete('notetbl', where: "id = ?", whereArgs: [id]);
  }
}

class NotePojo {
  int id;
  String message;
  NotePojo({
    @required this.id,
    @required this.message,
  });
  Map<String, dynamic> toMap() {
    return {'id': id, 'message': message};
  }
}
