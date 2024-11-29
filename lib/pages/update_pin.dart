import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:stashwise/utils/database_helper.dart';

class ChangePinPage extends StatefulWidget {
  const ChangePinPage({super.key});

  @override
  State<ChangePinPage> createState() => _ChangePinPageState();
}

class _ChangePinPageState extends State<ChangePinPage> {
  final TextEditingController _currentPinController = TextEditingController();
  final TextEditingController _newPinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper();

  void _updatePin() async {
    String currentPin = _currentPinController.text.trim();
    String newPin = _newPinController.text.trim();
    String confirmPin = _confirmPinController.text.trim();

    if (currentPin.isEmpty || newPin.isEmpty || confirmPin.isEmpty) {
      _showMessage('All fields are required!');
      return;
    }

    List<Map<String, dynamic>> userDetailsList =
        await _dbHelper.getPersonalDetails();
    Map<String, dynamic>? userDetails =
        userDetailsList.isNotEmpty ? userDetailsList.first : null;
    if (userDetails == null || userDetails['pin'] != currentPin) {
      _showMessage('Current PIN is incorrect!');
      return;
    }

    if (newPin != confirmPin) {
      _showMessage('New PIN and Confirm PIN do not match!');
      return;
    }

    try {
      await _dbHelper.updatePin(userDetails['user_id'], newPin);
      _showMessage('PIN updated successfully!', success: true);
    } catch (e) {
      _showMessage('Failed to update PIN. Please try again.');
    }
  }

  void _showMessage(String message, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
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
                // Header
                const Text(
                  'Change\nYour PIN',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 48.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 60),

                // Current PIN Input Field
                TextField(
                  controller: _currentPinController,
                  decoration: InputDecoration(
                    labelText: 'Current PIN',
                    labelStyle: const TextStyle(fontFamily: 'Open Sans'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: Color(0xFF1F62FF), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: Color(0xFF1F62FF), width: 1),
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
                  obscureText: true,
                  maxLength: 4,
                ),
                const SizedBox(height: 20),

                // New PIN Input Field
                TextField(
                  controller: _newPinController,
                  decoration: InputDecoration(
                    labelText: 'New PIN',
                    labelStyle: const TextStyle(fontFamily: 'Open Sans'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: Color(0xFF1F62FF), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: Color(0xFF1F62FF), width: 1),
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
                  obscureText: true,
                  maxLength: 4,
                ),
                const SizedBox(height: 20),

                // Confirm New PIN Input Field
                TextField(
                  controller: _confirmPinController,
                  decoration: InputDecoration(
                    labelText: 'Confirm New PIN',
                    labelStyle: const TextStyle(fontFamily: 'Open Sans'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: Color(0xFF1F62FF), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: Color(0xFF1F62FF), width: 1),
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
                  obscureText: true,
                  maxLength: 4,
                ),
                const SizedBox(height: 250),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _updatePin,
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
                  'Update PIN',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'Open Sans',
                  ),
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
