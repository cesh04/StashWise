import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:stashwise/pages/new_transaction.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TransactionHistoryPage extends StatefulWidget {
  final String selectedCategory;

  const TransactionHistoryPage({super.key, required this.selectedCategory});

  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  String? selectedType = null;
  String? selectedCategory = null;

  List<Map<String, dynamic>> transactions = [];
  List<Map<String, dynamic>> filteredTransactions = [];
  List<String> categories = [];
  Map<String, String> categoryNames = {};

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _loadTransactions();
  }

  Future<void> _loadCategories() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'fund_management.db'),
    );

    final List<Map<String, dynamic>> categoryList =
        await db.query('categories');

    setState(() {
      categories = ['All'] +
          categoryList
              .map((category) => category['category_id'].toString())
              .toList();
      categoryNames = {
        for (var category in categoryList)
          category['category_id'].toString(): category['category_name']
      };
    });
  }

  Future<void> _loadTransactions() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'fund_management.db'),
    );

    String query = '''
      SELECT t.*, c.category_name 
      FROM transactions t
      LEFT JOIN categories c ON t.category_id = c.category_id
    ''';

    List<String> conditions = [];
    List<dynamic> arguments = [];

    if (selectedCategory != null && selectedCategory != 'All') {
      conditions.add('t.category_id = ?');
      arguments.add(selectedCategory);
    }

    if (selectedType != null) {
      int typeValue = selectedType == 'Cash' ? 0 : 1;
      conditions.add('t.transaction_type = ?');
      arguments.add(typeValue);
    }

    if (conditions.isNotEmpty) {
      query += ' WHERE ' + conditions.join(' AND ');
    }

    query += ' ORDER BY t.transaction_date DESC';

    final List<Map<String, dynamic>> transactionList =
        await db.rawQuery(query, arguments);

    setState(() {
      transactions = transactionList;
      filteredTransactions = transactionList;
    });
  }

  Future<void> _addNewTransaction() async {
    final newTransactionAdded = await Navigator.push(
      context as BuildContext,
      MaterialPageRoute(builder: (context) => const NewTransactionPage()),
    );

    if (newTransactionAdded == true) {
      _loadTransactions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // SliverAppBar with title that can scroll away
            SliverAppBar(
              expandedHeight: 150.0,
              floating: false,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'Transaction\nHistory',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 25.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                background: Container(color: Colors.white),
              ),
            ),
            // Filter section: Type and Category dropdowns
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Type Filter Dropdown
                    DropdownButton<String>(
                      value: selectedType,
                      icon: const Icon(CupertinoIcons.chevron_down,
                          color: Color(0xFF1F62FF)),
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
                      hint: const Text("Select Type",
                          style: TextStyle(color: Colors.grey)),
                      onChanged: (value) {
                        setState(() {
                          selectedType = value == 'All' ? null : value;
                        });
                        _loadTransactions();
                      },
                    ),
                    // Category Filter Dropdown
                    categories.isEmpty
                        ? const CircularProgressIndicator()
                        : DropdownButton<String>(
                            value: selectedCategory,
                            icon: const Icon(CupertinoIcons.chevron_down,
                                color: Color(0xFF1F62FF)),
                            underline: Container(),
                            style: const TextStyle(
                              fontFamily: 'Open Sans',
                              color: Color(0xFF080708),
                              fontSize: 16,
                            ),
                            hint: const Text(
                              "Select Category", // Default hint text
                              style: TextStyle(color: Colors.grey),
                            ),
                            items: [
                              const DropdownMenuItem<String>(
                                value: null,
                                enabled: false,
                                child: Text(
                                  "Select Category", // Hint text
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              ...categories.map((String category) {
                                return DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(category == 'All'
                                      ? category
                                      : categoryNames[category] ?? category),
                                );
                              }).toList(),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedCategory =
                                    value == 'All' ? null : value;
                              });
                              _loadTransactions();
                            },
                          ),
                  ],
                ),
              ),
            ),
            // SliverList for the transaction items
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final transaction = filteredTransactions[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8.0),
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(
                            color: Color(0xFF1F62FF), width: 1),
                      ),
                      title: Text(
                        transaction['transaction_name'],
                        style: const TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF080708),
                        ),
                      ),
                      subtitle: Text(
                        '${transaction['transaction_type'] == 0 ? 'Cash' : 'Bank'} | ${transaction['category_name']}',
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
                          color: transaction['amount'] > 0
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ),
                  );
                },
                childCount: filteredTransactions.length,
              ),
            ),
          ],
        ),
      ),
      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTransaction,
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
