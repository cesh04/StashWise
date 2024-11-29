import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Importing CupertinoIcons for iOS-style icons
import 'package:stashwise/models/stashwise.dart';
import 'package:stashwise/pages/set_currency.dart';
import 'package:stashwise/utils/database_helper.dart';

class SetPinPage extends StatefulWidget {
  final int userId; // Accept user ID from Register page

  const SetPinPage(
      {super.key, required this.userId, required Stashwise stashwise});

  @override
  _SetPinPageState createState() => _SetPinPageState();
}

class _SetPinPageState extends State<SetPinPage> {
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  void _setPin() async {
    String pin = _pinController.text;
    String confirmPin = _confirmPinController.text;

    if (pin.length != 4 || confirmPin.length != 4) {
      _showSnackbar("PIN must be 4 digits.");
      return;
    }

    if (pin != confirmPin) {
      _showSnackbar("PINs do not match.");
      return;
    }

    try {
      await _databaseHelper.updatePin(widget.userId, pin);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CurrencySelectionPage()),
      );
    } catch (e) {
      _showSnackbar("Failed to set PIN. Please try again.");
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

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
                  'Set\nYour\nPIN Code',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 48.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 110),

                // PIN Input Field
                TextField(
                  controller: _pinController,
                  decoration: InputDecoration(
                    labelText: 'Enter 4-digit PIN',
                    labelStyle: const TextStyle(fontFamily: 'Open Sans'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: Color(0xFF1F62FF), width: 1),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.number,
                  obscureText: true, // Hide the PIN input
                  maxLength: 4, // Limit to 4 digits
                ),
                const SizedBox(height: 20),

                // Confirm PIN Input Field
                TextField(
                  controller: _confirmPinController,
                  decoration: InputDecoration(
                    labelText: 'Confirm 4-digit PIN',
                    labelStyle: const TextStyle(fontFamily: 'Open Sans'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: Color(0xFF1F62FF), width: 1),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.number,
                  obscureText: true, // Hide the confirmation PIN input
                  maxLength: 4, // Limit to 4 digits
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
            onPressed: _setPin,
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
                  'Set PIN',
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
