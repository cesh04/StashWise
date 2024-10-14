import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Importing CupertinoIcons for iOS-style icons

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                // StashWise Logo with Lobster Two Font
                const Center(
                  child: Text(
                    'StashWise',
                    style: TextStyle(
                      fontFamily: 'Lobster Two',
                      fontSize: 32.0, // Smaller logo size
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 50), // Space between logo and PIN field

                // Heading "Enter Your PIN" broken into 2 lines
                const Text(
                  'Enter\nYour\nPIN',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 48.0, // Same font size as in previous pages
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 80),

                // PIN Input Field (Large and focused)
                SizedBox(
                   // Adjust width for a larger touch area
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'PIN',
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
                    keyboardType: TextInputType.number,
                    obscureText: true, // Hide the PIN input
                    maxLength: 4, // Limit to 4 digits
                    autofocus: true, // Auto-focus for easier PIN entry
                    onChanged: (value) {
                      if (value.length == 4) {
                        // Auto-submit once 4 digits are entered
                        
                      }
                    },
                  ),
                ),
                const SizedBox(height: 250), // Adjust spacing to keep it centered
              ],
            ),
          ),
        ),
      ),
      // Login Button at the bottom (optional)
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity, // Full width
          child: ElevatedButton(
            onPressed: () {
              // Handle login logic here
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
                  'Login',
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
