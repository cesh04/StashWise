import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Importing CupertinoIcons for iOS-style icons
import 'package:stashwise/pages/set_pin_page.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Massive Heading broken into 3 lines
                const Text(
                  'Create\nYour\nProfile',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 48.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 110),

                // Name Input Field
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: const TextStyle(fontFamily: 'Open Sans'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color(0xFF1F62FF), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color(0xFF1F62FF), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color(0xFF1F62FF), width: 1.5),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                // DOB Input Field
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    labelStyle: const TextStyle(fontFamily: 'Open Sans'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color(0xFF1F62FF), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color(0xFF1F62FF), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color(0xFF1F62FF), width: 1.5),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.datetime,
                ),
                const SizedBox(height: 20),

                // Email Input Field
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(fontFamily: 'Open Sans'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color(0xFF1F62FF), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color(0xFF1F62FF), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color(0xFF1F62FF), width: 1.5),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 250),
              ],
            ),
          ),
        ),
      ),
      // Fixed Button at the bottom of the screen
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity, // Full width
          child: ElevatedButton(
            onPressed: () {
              // Handle registration logic here
              Navigator.push(context, MaterialPageRoute(builder: (context) => SetPinPage()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1F62FF), // Blue button
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Create Account',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Open Sans'),
                ),
                SizedBox(width: 10),
                Icon(
                  CupertinoIcons.chevron_forward, // iOS-style trailing icon
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
