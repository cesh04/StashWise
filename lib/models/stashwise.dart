import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Stashwise {
  late String _name;
  late String _dateOfBirth;
  late String _email;
  late String _pin;

  Stashwise(this._name, this._dateOfBirth, this._email, this._pin);

  String get name => _name;
  String get dateOfBirth => _dateOfBirth;
  String get email => _email;
  String get pin => _pin;

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
      _dateOfBirth = newDateOfBirth;
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

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': _name,
      'date_of_birth': _dateOfBirth,
      'email': _email,
      'pin': _pin,
    };
    return map;
  }

  Stashwise.fromMapObject(Map<String, dynamic> map) {
    _name = map['name'];
    _dateOfBirth = map['date_of_birth'];
    _email = map['email'];
    _pin = map['pin'];
  }
}
