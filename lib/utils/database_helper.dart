import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stashwise/models/stashwise.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._createInstance();
  static Database? _database;

  final String personalDetails = 'personal_details';
  final String categoriesTable = 'Categories';
  final String duesTable = 'Dues';
  final String transaction_details = 'transactions';

  final String colUserId = 'user_id';
  final String colName = 'name';
  final String colDateOfBirth = 'date_of_birth';
  final String colEmail = 'email';
  final String colPin = 'pin';

  final String colTransactionName = 'transaction_name';
  final String colCategoryId = 'category_id';
  final String colDescription = 'description';
  final String colAmount = 'amount';
  final String colTransactionDate = 'transaction_date';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/fund_management.db';

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE $personalDetails (
        $colUserId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colName TEXT,
        $colDateOfBirth TEXT,
        $colEmail TEXT,
        $colPin TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $transaction_details(
        transaction_id INTEGER PRIMARY KEY AUTOINCREMENT,
        $colTransactionName TEXT,
        $colCategoryId INTEGER,
        $colDescription TEXT,
        $colAmount REAL,
        $colTransactionDate TEXT,
        transaction_type INTEGER,
        cash_balance REAL,
        bank_balance REAL,
        FOREIGN KEY ($colCategoryId) REFERENCES $categoriesTable(category_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE $categoriesTable (
        category_id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_name TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $duesTable (
        due_id INTEGER PRIMARY KEY AUTOINCREMENT,
        due_name TEXT,
        $colAmount REAL,
        $colDescription TEXT,
        due_date TEXT
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getPersonalDetails() async {
    Database db = await database;
    return await db.query(personalDetails);
  }

  Future<int> insertUser(Stashwise stashwise) async {
    final db = await database;

    return await db.insert(personalDetails, {
      colName: stashwise.name,
      colDateOfBirth: stashwise.dateOfBirth,
      colEmail: stashwise.email,
      colPin: "", // Empty PIN for now
    });
  }

  Future<bool> doesUserExist() async {
    Database db = await database;
    var result = await db.query(personalDetails);
    return result.isNotEmpty; // Returns true if any user exists
  }

  Future<Map<String, dynamic>?> getUserByName(String name) async {
    Database db = await database;
    var result = await db.query(
      personalDetails,
      where: '$colName = ?',
      whereArgs: [name],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  // Methods for other tables
  Future<void> insertTransaction(Map<String, dynamic> transaction) async {
    final db = await database;
    await db.insert(transaction_details, transaction);
  }

  Future<void> insertCategory(Map<String, dynamic> category) async {
    final db = await database;
    await db.insert(categoriesTable, category);
  }

  Future<void> insertDue(Map<String, dynamic> due) async {
    final db = await database;
    await db.insert(duesTable, due);
  }

  Future<void> insertPin(String pin) async {
    final db = await database;

    int result = await db.update(
      personalDetails,
      {colPin: pin},
    );

    if (result == 0) {
      throw Exception('Failed to set PIN. No rows affected.');
    }
  }

  Future<void> updatePin(int userId, String pin) async {
    final db = await database;

    // Update the pin for the specific user
    int result = await db.update(
      personalDetails,
      {colPin: pin},
      where: '$colUserId = ?',
      whereArgs: [userId],
    );

    if (result == 0) {
      throw Exception('Failed to set PIN. No matching user found.');
    }
  }

  insertDetails(Map<String, dynamic> map) {}
}
