import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Importing CupertinoIcons for iOS-style icons
import 'package:stashwise/navbar.dart';

class CurrencySelectionPage extends StatefulWidget {
  const CurrencySelectionPage({super.key});

  @override
  _CurrencySelectionPageState createState() => _CurrencySelectionPageState();
}

class _CurrencySelectionPageState extends State<CurrencySelectionPage> {
  // Initial currency value
  String? selectedCurrency = '₹ INR Indian Rupee'; // Default selected value

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
                // Massive Heading broken into 2 lines
                const Text(
                  'Select\nYour\nCurrency',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 48.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 110),

                // Currency Selection Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Currency',
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
                  value: selectedCurrency, // Initial value
                  icon: const Icon(CupertinoIcons.chevron_down, color: Color(0xFF1F62FF)), // Dropdown arrow styled like iOS
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'Open Sans', fontSize: 16),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCurrency = newValue;
                    });
                  },
                  items: <String>['₹ INR Indian Rupee', '\$ USD United States Dollar',]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 250), // Leave some space below
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
              // Handle confirmation or next step
              Navigator.push(context, MaterialPageRoute(builder: (context) => NavBar()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1F62FF), // Blue button
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Continue',
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
