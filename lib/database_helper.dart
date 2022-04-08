import 'package:PrivateNotes/Models/notes.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT, createdtime TEXT,updatedtime TEXT )");
        await db.execute(
            "CREATE TABLE todo(id INTEGER PRIMARY KEY, taskId INTEGER, title TEXT, isDone INTEGER)");

        return db;
      },
      version: 1,
    );
  }

  Future<int> insertNote(Note note) async {
    int taskId = 0;
    Database _db = await database();
    await _db
        .insert('tasks', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      taskId = value;
    });
    return taskId;
  }

  Future<void> updateNoteTitle(int id, String title) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE tasks SET title = '$title' WHERE id = '$id'");
  }

  Future<void> updateNoteDescription(int id, String description) async {
    Database _db = await database();
    await _db.rawUpdate(
        "UPDATE tasks SET description = '$description' WHERE id = '$id'");
  }

  Future<void> updateNoteTimeCreate(int id, String createdtime) async {
    Database _db = await database();
    await _db.rawUpdate(
        "UPDATE tasks SET createdtime = '$createdtime' WHERE id = '$id'");
  }


  Future<void> updateNoteTimeUpdate(int id, String updatedtime) async {
    Database _db = await database();
    await _db.rawUpdate(
        "UPDATE tasks SET updatedtime = '$updatedtime' WHERE id = '$id'");
  }

  Future<List<Note>> getNotes() async {
    Database _db = await database();
    List<Map<String, dynamic>> noteMap = await _db.query('tasks');
    return List.generate(noteMap.length, (index) {
      return Note(
          id: noteMap[index]['id'],
          title: noteMap[index]['title'],
          description: noteMap[index]['description'],
          createdtime: noteMap[index]['createdtime'],
          updatedtime: noteMap[index]['updatedtime']);

    });
  }


  Future<List<Note>> getSearchNotes(String title) async {
    Database _db = await database();
    List<Map<String, dynamic>> noteMap = await _db.query(
        "SELECT * FROM sentences WHERE title LIKE '%${title}%' OR  body LIKE '%${title}%'");
    return List.generate(noteMap.length, (index) {
      return Note(
        id: noteMap[index]['id'],
      );
    });
  }

  Future<void> deleteNote(int id) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM tasks WHERE id = '$id'");
    await _db.rawDelete("DELETE FROM todo WHERE taskId = '$id'");
  }
}
