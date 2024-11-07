import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NewTransactionPage extends StatefulWidget {
  const NewTransactionPage({super.key});

  @override
  _NewTransactionPageState createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends State<NewTransactionPage> {
  String selectedAccount = 'Cash';
  bool isCredit = true;
  String selectedCategory = 'Select Category';
  double cashBalance = 350.0;
  double bankBalance = 7500.0;

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
                  'New\nTransaction',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 48.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 50),

                // Account Toggle (Cash/Bank)
                ToggleButtons(
                  isSelected: [selectedAccount == 'Cash', selectedAccount == 'Bank'],
                  onPressed: (index) {
                    setState(() {
                      selectedAccount = index == 0 ? 'Cash' : 'Bank';
                    });
                  },
                  borderRadius: BorderRadius.circular(15),
                  selectedColor: Colors.white,
                  fillColor: const Color(0xFF1F62FF),
                  textStyle: const TextStyle(fontFamily: 'Open Sans', fontSize: 18),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      child: Text('Cash (\u20B9$cashBalance)'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      child: Text('Bank (\u20B9$bankBalance)'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Transaction Title Field
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Transaction Title',
                    labelStyle: const TextStyle(fontFamily: 'Open Sans'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFF1F62FF), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFF1F62FF), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFF1F62FF), width: 1.5),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                // Amount Field with Credit/Debit Toggle and Tooltips
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          prefixText: '\u20B9 ', // Rupee sign
                          labelStyle: const TextStyle(fontFamily: 'Open Sans'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFF1F62FF), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFF1F62FF), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFF1F62FF), width: 1.5),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 12),
                    ToggleButtons(
                      isSelected: [isCredit, !isCredit],
                      onPressed: (index) {
                        setState(() {
                          isCredit = index == 0;
                        });
                      },
                      borderRadius: BorderRadius.circular(15),
                      selectedColor: Colors.white,
                      fillColor: const Color(0xFF1F62FF),
                      textStyle: const TextStyle(fontFamily: 'Open Sans', fontSize: 18),
                      children: [
                        Tooltip(
                          message: 'Credited',
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: const Text('+'), // Credit
                          ),
                        ),
                        Tooltip(
                          message: 'Debited',
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: const Text('-'), // Debit
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Category Dropdown with Light Text Style
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Category',
                    labelStyle: const TextStyle(fontFamily: 'Open Sans', color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFF1F62FF), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFF1F62FF), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFF1F62FF), width: 1.5),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  value: selectedCategory,
                  icon: const Icon(CupertinoIcons.chevron_down, color: Color(0xFF1F62FF)),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                  style: const TextStyle(
                    fontFamily: 'Open Sans',
                    color: Colors.grey, // Match dropdown text color with the design
                    fontSize: 18,
                  ),
                  items: <String>[
                    'Select Category',
                    'Food',
                    'Entertainment',
                    'Utilities',
                    'Shopping',
                    'Travel'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                // Description Field
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: const TextStyle(fontFamily: 'Open Sans'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFF1F62FF), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFF1F62FF), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFF1F62FF), width: 1.5),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  maxLines: 3, // Multi-line description
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add transaction action
        },
        backgroundColor: const Color(0xFF1F62FF),
        child: const Icon(
          Icons.check,
          size: 36.0,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Align FAB to bottom right
    );
  }
}
