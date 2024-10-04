import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Wrap in Scaffold
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Massive Heading broken into 3 lines
              const Text(
                'Create\nYour\nProfile',
                style: TextStyle(
                  fontFamily: 'Open Sans', // Using Open Sans font
                  fontSize: 48.0, // Larger font size for heading
                  fontWeight: FontWeight.w700, // Bold for the heading
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 30), // Space between heading and fields
              
              // Name Input Field
              TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: const TextStyle(fontFamily: 'Open Sans'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFF1F62FF), width: 2), // Themed blue border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFF1F62FF), width: 2), // Blue border for enabled state
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFF1F62FF), width: 2), // Blue border when focused
                  ),
                  filled: true,
                  fillColor: Colors.grey[200], // Subtle background color
                ),
              ),
              const SizedBox(height: 20), // Space between fields

              // DOB Input Field
              TextField(
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  labelStyle: const TextStyle(fontFamily: 'Open Sans'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFF1F62FF), width: 2), // Themed blue border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFF1F62FF), width: 2), // Blue border for enabled state
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFF1F62FF), width: 2), // Blue border when focused
                  ),
                  filled: true,
                  fillColor: Colors.grey[200], // Subtle background color
                ),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 20), // Space between fields

              // Email Input Field
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(fontFamily: 'Open Sans'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFF1F62FF), width: 2), // Themed blue border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFF1F62FF), width: 2), // Blue border for enabled state
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFF1F62FF), width: 2), // Blue border when focused
                  ),
                  filled: true,
                  fillColor: Colors.grey[200], // Subtle background color
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              
              const SizedBox(height: 30), // Space before button

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle registration logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F62FF), // Blue button
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Open Sans'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
