import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stashwise/navbar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Future<String?> _fetchStoredPIN() async {
    try {
      final database = await openDatabase(
        join(await getDatabasesPath(), 'fund_management.db'),
      );

      final List<Map<String, dynamic>> result =
          await database.query('personal_details', limit: 1);

      if (result.isNotEmpty) {
        return result.first['pin'] as String?;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> _validatePIN(BuildContext context, String enteredPIN) async {
    final storedPIN = await _fetchStoredPIN();

    if (storedPIN == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('No PIN found. Please set up your account.')),
      );
      return;
    }

    if (enteredPIN == storedPIN) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavBar()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Wrong PIN, Please try again')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _pinController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // StashWise Logo
                const Center(
                  child: Text(
                    'StashWise',
                    style: TextStyle(
                      fontFamily: 'Lobster Two',
                      fontSize: 32.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // Heading
                const Text(
                  'Enter\nYour\nPIN',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 48.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 80),

                // PIN Input Field
                SizedBox(
                  child: TextField(
                    controller: _pinController,
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
                  ),
                ),
                const SizedBox(height: 250),
              ],
            ),
          ),
        ),
      ),

      // Login Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              final enteredPIN = _pinController.text.trim();
              if (enteredPIN.length == 4) {
                // Validate the entered PIN
                await _validatePIN(context, enteredPIN);
              } else {
                // Show error if the PIN is not 4 digits long
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a 4-digit PIN')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1F62FF),
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
                  CupertinoIcons.chevron_forward,
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
