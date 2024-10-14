import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:stashwise/models/stashwise.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper =
      DatabaseHelper._createInstance();
  static Database? _database;

  final String personalDetails = 'personal_details';
  final String colName = 'name';
  final String colDateOfBirth = 'date_of_birth';
  final String colEmail = 'email';
  final String colPin = 'pin';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/stashwise.db';

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $personalDetails($colName TEXT PRIMARY KEY, $colDateOfBirth TEXT, $colEmail TEXT, $colPin TEXT)',
    );
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await database;

    return await db.rawQuery('SELECT * FROM $personalDetails');
  }

  Future<int> insertDetails(Stashwise stashwise) async {
    Database db = await database;

    bool exists = await doesNameExist(stashwise.name);
    if (exists) {
      return -1;
    }

    return await db.insert(personalDetails, stashwise.toMap());
  }

  Future<bool> doesNameExist(String name) async {
    Database db = await database;
    var result = await db.query(
      personalDetails,
      where: 'name = ?',
      whereArgs: [name],
    );
    return result.isNotEmpty;
  }

  Future<bool> doesUserExist() async {
    Database db = await database;
    var result = await db.query(personalDetails); // Query the table
    return result.isNotEmpty; // Returns true if at least one user exists
  }

  Future<Stashwise?> getUserByName(String name) async {
    Database db = await database;
    var result = await db.query(
      personalDetails,
      where: 'name = ?',
      whereArgs: [name],
    );
    if (result.isNotEmpty) {
      return Stashwise.fromMapObject(result.first);
    }
    return null;
  }
}
