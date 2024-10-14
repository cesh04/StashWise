import 'package:flutter/material.dart';
import 'package:stashwise/pages/first.dart';

void main(){
  runApp(const StashWise());
}

class StashWise extends StatelessWidget {
  const StashWise({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StashWise',
      home: FirstPage(),
    );
  }
}