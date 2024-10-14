import 'package:flutter/material.dart';
import 'package:stashwise/pages/home.dart';
import 'package:stashwise/pages/register.dart';
import 'package:stashwise/utils/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper db = DatabaseHelper();

  bool userExists = await db.doesUserExist();

  runApp(MyApp(userExists: userExists));
}

class MyApp extends StatelessWidget {
  final bool userExists;

  const MyApp({super.key, required this.userExists});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StashWise',
      home: userExists ? HomePage() : Register(),
    );
  }
}
