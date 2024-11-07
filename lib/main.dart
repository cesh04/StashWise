import 'package:flutter/material.dart';
import 'package:stashwise/navbar.dart';
import 'package:stashwise/pages/register.dart';
import 'package:stashwise/utils/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper db = DatabaseHelper();

  bool userExists = await db.doesUserExist();

  runApp(StashWise(userExists: userExists));
}

class StashWise extends StatelessWidget {
  final bool userExists;

  const StashWise({super.key, required this.userExists});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StashWise',
      home: userExists ? NavBar() : Register(),
    );
  }
}
