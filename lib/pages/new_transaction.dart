import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NewTransactionPage extends StatefulWidget {
  const NewTransactionPage({super.key});

  @override
  _NewTransactionPageState createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends State<NewTransactionPage> {
  String selectedAccount = 'Cash';
  bool isCredit = true;
  String selectedCategory = 'Select Category';
  double cashBalance = 0.0;
  double bankBalance = 0.0;

  List<String> categories = [];

  final TextEditingController transactionTitleController =
      TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _loadBalances();
  }

  Future<void> _loadCategories() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'fund_management.db'),
    );

    final List<Map<String, dynamic>> categoryList =
        await db.query('Categories');

    setState(() {
      categories = categoryList
          .map((category) => category['category_name'] as String)
          .toList();
    });

    if (categories.isNotEmpty) {
      setState(() {
        selectedCategory = categories[0];
      });
    }
  }

  Future<void> _loadBalances() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'fund_management.db'),
    );

    // Compute cash balance
    final List<Map<String, dynamic>> cashQuery = await db.rawQuery(
        'SELECT SUM(amount) AS total_cash FROM transactions WHERE transaction_type = 0');

    // Compute bank balance
    final List<Map<String, dynamic>> bankQuery = await db.rawQuery(
        'SELECT SUM(amount) AS total_bank FROM transactions WHERE transaction_type = 1');

    setState(() {
      cashBalance =
          cashQuery.isNotEmpty && cashQuery.first['total_cash'] != null
              ? cashQuery.first['total_cash'] as double
              : 0.0;

      bankBalance =
          bankQuery.isNotEmpty && bankQuery.first['total_bank'] != null
              ? bankQuery.first['total_bank'] as double
              : 0.0;
    });
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
                  isSelected: [
                    selectedAccount == 'Cash',
                    selectedAccount == 'Bank'
                  ],
                  onPressed: (index) {
                    setState(() {
                      selectedAccount = index == 0 ? 'Cash' : 'Bank';
                    });
                  },
                  borderRadius: BorderRadius.circular(15),
                  selectedColor: Colors.white,
                  fillColor: const Color(0xFF1F62FF),
                  textStyle:
                      const TextStyle(fontFamily: 'Open Sans', fontSize: 18),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      child: Text('Cash (\u20B9$cashBalance)'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      child: Text('Bank (\u20B9$bankBalance)'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Transaction Title Field
                TextField(
                  controller: transactionTitleController,
                  decoration: InputDecoration(
                    labelText: 'Transaction Title',
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
                ),
                const SizedBox(height: 20),

                // Amount Field with Credit/Debit Toggle and Tooltips
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: amountController,
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          prefixText: '\u20B9 ', // Rupee sign
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
                      textStyle: const TextStyle(
                          fontFamily: 'Open Sans', fontSize: 18),
                      children: [
                        Tooltip(
                          message: 'Credited',
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: const Text('+'), // Credit
                          ),
                        ),
                        Tooltip(
                          message: 'Debited',
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
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
                    labelStyle: const TextStyle(
                        fontFamily: 'Open Sans', color: Colors.grey),
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
                  value: selectedCategory,
                  icon: const Icon(CupertinoIcons.chevron_down,
                      color: Color(0xFF1F62FF)),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                  style: const TextStyle(
                    fontFamily: 'Open Sans',
                    color: Colors
                        .grey, // Match dropdown text color with the design
                    fontSize: 18,
                  ),
                  items:
                      categories.map<DropdownMenuItem<String>>((String value) {
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
        onPressed: () async {
          // Validate fields (example: ensuring no fields are left blank)
          if (transactionTitleController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("Please enter a transaction title.")),
            );
            return;
          }

          if (amountController.text.isEmpty ||
              double.tryParse(amountController.text) == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please enter a valid amount.")),
            );
            return;
          }

          if (selectedCategory == 'Select Category' ||
              selectedCategory.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please select a valid category.")),
            );
            return;
          }

          // Parse the entered amount
          double? amount = double.tryParse(amountController.text);

          if (amount == null || amount <= 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Enter a valid amount.")),
            );
            return;
          }

          // Get transaction type: 1 for Bank, 0 for Cash
          int transactionType = selectedAccount == 'Bank' ? 1 : 0;

          // Get the current date as transaction date
          String transactionDate = DateTime.now().toIso8601String();

          // Open the database
          final db = await openDatabase(
            join(await getDatabasesPath(), 'fund_management.db'),
          );

          // Get category_id from the database using selectedCategory
          final List<Map<String, dynamic>> categoryQuery = await db.query(
            'Categories',
            columns: ['category_id'],
            where: 'category_name = ?',
            whereArgs: [selectedCategory],
          );

          if (categoryQuery.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Invalid category selected.")),
            );
            return;
          }
          int categoryId = categoryQuery.first['category_id'];

          // Retrieve current balance for the selected account
          final List<Map<String, dynamic>> balanceQuery = await db.query(
            'transactions',
            columns: [transactionType == 0 ? 'cash_balance' : 'bank_balance'],
            orderBy: 'transaction_id DESC', // Get the latest transaction
            limit: 1,
          );

          double currentBalance = balanceQuery.isNotEmpty
              ? balanceQuery.first[transactionType == 0
                  ? 'cash_balance'
                  : 'bank_balance'] as double
              : 0.0;

          // Calculate the new balance
          double newBalance = isCredit
              ? currentBalance + amount // Credit adds to balance
              : currentBalance - amount; // Debit subtracts from balance

          // Insert the transaction into the database
          await db.insert(
            'transactions',
            {
              'transaction_name': transactionTitleController.text,
              'category_id': categoryId,
              'description': descriptionController.text,
              'amount':
                  isCredit ? amount : -amount, // Debit amounts are negative
              'transaction_date': transactionDate,
              'transaction_type': transactionType,
              'cash_balance': transactionType == 0
                  ? newBalance
                  : currentBalance, // Update cash balance if Cash
              'bank_balance': transactionType == 1
                  ? newBalance
                  : currentBalance, // Update bank balance if Bank
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );

          await _loadBalances();

          // Show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Transaction added successfully!")),
          );

          // Optionally navigate back or clear the form
          Navigator.pop(context, true);
        },
        backgroundColor: const Color(0xFF1F62FF),
        child: const Icon(
          Icons.check,
          size: 36.0,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat, // Align FAB to bottom right
    );
  }

  @override
  void dispose() {
    transactionTitleController.dispose();
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
