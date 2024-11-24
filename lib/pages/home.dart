import 'package:flutter/material.dart';
import 'package:stashwise/pages/categories.dart';
import 'package:stashwise/pages/new_category.dart';
import 'package:stashwise/pages/new_transaction.dart';
import 'package:stashwise/pages/transaction_history.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:stashwise/pages/dues.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name = 'User';
  String greeting = 'Hello';

  double cashBalance = 0.0;
  double bankBalance = 0.0;

  final TextEditingController _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
    _updateGreeting();
    _fetchBalances();
  }

  Future<void> _fetchUserDetails() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'fund_management.db'),
    );

    final db = await database;
    final List<Map<String, dynamic>> personalDetails =
        await db.query('personal_details');

    if (personalDetails.isNotEmpty) {
      setState(() {
        name = personalDetails[0]['name'];
      });
    }
  }

  void _updateGreeting() {
    final hour = DateTime.now().hour;

    setState(() {
      if (hour < 12) {
        greeting = 'Good Morning';
      } else if (hour < 4) {
        greeting = 'Good Afternoon';
      } else {
        greeting = 'Good Evening';
      }
    });
  }

  /*void _showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Categories'),
          content: TextField(
            controller: _categoryController,
            decoration: const InputDecoration(hintText: 'Enter category name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final category = _categoryController.text.trim();

                if (category.isNotEmpty) {
                  await _addCategoryToDatabase(category);
                  setState(() {
                    _categoryController.clear();
                  });
                }

                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addCategoryToDatabase(String category) async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'fund_management.db'),
    );

    final db = await database;
    await db.insert(
      'Categories',
      {'category_name': category},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  } */

  Future<void> _fetchBalances() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'fund_management.db'),
    );

    // Query for the latest cash and bank balances
    final List<Map<String, dynamic>> balanceQuery = await db.query(
      'transactions',
      columns: ['cash_balance', 'bank_balance'],
      orderBy: 'transaction_id DESC', // Fetch the latest transaction
      limit: 1,
    );

    setState(() {
      // If a transaction is found, update the balances
      if (balanceQuery.isNotEmpty) {
        cashBalance = balanceQuery.first['cash_balance'] ?? 0.0;
        bankBalance = balanceQuery.first['bank_balance'] ?? 0.0;
      } else {
        // Set to 0.0 if no transactions exist yet
        cashBalance = 0.0;
        bankBalance = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              child: Text(
                '$greeting, $name',
                style: const TextStyle(
                  fontFamily: 'Open Sans',
                  color: Color(0xFF080708),
                  fontSize: 40.0,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.symmetric(vertical: 42),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1F62FF), Colors.cyan],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, bottom: 12.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\u20B9$cashBalance',
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                color: Color(0xFFE6E8E6),
                                fontWeight: FontWeight.w800,
                                fontSize: 32.0, // Larger amount font size
                              ),
                            ),
                            Text(
                              'Cash',
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                color: Color(0xFFE6E8E6),
                                fontSize: 20.0, // Smaller label font size
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.symmetric(vertical: 42),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.cyan, Color(0xFF1F62FF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, bottom: 12.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\u20B9$bankBalance',
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                color: Color(0xFFE6E8E6),
                                fontWeight: FontWeight.w800,
                                fontSize: 32.0, // Larger amount font size
                              ),
                            ),
                            Text(
                              'Bank',
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                color: Color(0xFFE6E8E6),
                                fontSize: 20.0, // Smaller label font size
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                children: [
                  ListTile(
                    title: const Text(
                      'Transaction History',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 27.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF080708),
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Color(0xFF1F62FF)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TransactionHistoryPage()));
                    },
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    title: const Text(
                      'Dues',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 27.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF080708),
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Color(0xFF1F62FF)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DuesPage()));
                    },
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    title: const Text(
                      'Categories',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 27.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF080708),
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Color(0xFF1F62FF)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoriesPage()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Adding the Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to NewTransactionPage and wait for a result
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewTransactionPage()),
          );

          // Refresh balances if a new transaction was added
          if (result == true) {
            _fetchBalances();
          }
        },

        backgroundColor: const Color(0xFF1F62FF), // Matching theme color
        child: const Icon(
          Icons.add,
          size: 36.0, // Slightly larger icon size for prominence
          color: Colors.white, // White color for contrast
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat, // Center FAB at bottom
    );
  }
}
