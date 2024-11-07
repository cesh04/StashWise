import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:stashwise/pages/new_transaction.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  String? selectedType = null;
  String? selectedCategory = null;

  final List<Map<String, dynamic>> transactions = [
    {
      'title': 'Grocery Shopping',
      'amount': 250.0,
      'type': 'Cash',
      'category': 'Food',
      'isCredit': false,
    },
    {
      'title': 'Salary',
      'amount': 5000.0,
      'type': 'Bank',
      'category': 'Income',
      'isCredit': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Transaction\nHistory',
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 48.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Type Filter Dropdown
                  DropdownButton<String>(
                    value: selectedType,
                    icon: const Icon(CupertinoIcons.chevron_down, color: Color(0xFF1F62FF)),
                    underline: Container(),
                    style: const TextStyle(
                      fontFamily: 'Open Sans',
                      color: Color(0xFF080708),
                      fontSize: 16,
                    ),
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        enabled: false,
                        child: Text(
                          "Select Type",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      ...['All', 'Cash', 'Bank'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ],
                    hint: const Text("Select Type", style: TextStyle(color: Colors.grey)),
                    onChanged: (value) {
                      setState(() {
                        selectedType = value == 'All' ? null : value;
                      });
                    },
                  ),

                  // Category Filter Dropdown
                  DropdownButton<String>(
                    value: selectedCategory,
                    icon: const Icon(CupertinoIcons.chevron_down, color: Color(0xFF1F62FF)),
                    underline: Container(),
                    style: const TextStyle(
                      fontFamily: 'Open Sans',
                      color: Color(0xFF080708),
                      fontSize: 16,
                    ),
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        enabled: false,
                        child: Text(
                          "Select Category",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      ...['All', 'Food', 'Income'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ],
                    hint: const Text("Select Category", style: TextStyle(color: Colors.grey)),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value == 'All' ? null : value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Transaction List
              Expanded(
                child: ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8.0),
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(color: Color(0xFF1F62FF), width: 1),
                        ),
                        title: Text(
                          transaction['title'],
                          style: const TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF080708),
                          ),
                        ),
                        subtitle: Text(
                          '${transaction['type']} | ${transaction['category']}',
                          style: const TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: Text(
                          '\u20B9 ${transaction['amount']}',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: transaction['isCredit'] ? Colors.green : Colors.red,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewTransactionPage())
          );
        },
        backgroundColor: const Color(0xFF1F62FF),
        child: const Icon(
          Icons.add,
          size: 36.0,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
