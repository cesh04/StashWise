import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stashwise/utils/database_helper.dart';

class Stashwise {
  late String _name;
  late String _dateOf_Birth;
  late String _email;
  late String _pin;

  Stashwise(this._name, this._dateOf_Birth, this._email, this._pin);

  // Getters
  String get name => _name;
  String get dateOfBirth => _dateOf_Birth;
  String get email => _email;
  String get pin => _pin;

  // Setters
  set name(String newName) {
    if (newName.length <= 255) {
      _name = newName;
    }
  }

  set pin(String newPin) {
    _pin = newPin;
  }

  void setDateOfBirth(String newDateOfBirth, BuildContext context) {
    DateFormat format = DateFormat('dd/MM/yyyy');
    DateTime dob = format.parse(newDateOfBirth);
    DateTime now = DateTime.now();

    if (dob.isBefore(now)) {
      _dateOf_Birth = newDateOfBirth;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid Date Of Birth! It cannot be in the future."),
        ),
      );
    }
  }

  set email(String newEmail) {
    _email = newEmail;
  }

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'date_of_birth': _dateOf_Birth,
      'email': _email,
      'pin': _pin,
    };
  }

  // Construct from Map
  Stashwise.fromMapObject(Map<String, dynamic> map) {
    _name = map['name'];
    _dateOf_Birth = map['date_of_birth'];
    _email = map['email'];
    _pin = map['pin'];
  }

  // Database Operations

  // Save user to database
  Future<int> saveToDatabase() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    return await dbHelper.insertDetails(toMap());
  }

  // Update PIN in database
  Future<void> updatePin(String newPin) async {
    DatabaseHelper dbHelper = DatabaseHelper();
    _pin = newPin;
    await dbHelper.insertPin(newPin);
  }

  // Fetch user by name from the database
  static Future<Stashwise?> fetchUserByName(String name) async {
    DatabaseHelper dbHelper = DatabaseHelper();
    var userMap = await dbHelper.getUserByName(name);

    if (userMap != null) {
      return Stashwise.fromMapObject(userMap);
    }
    return null;
  }
}
