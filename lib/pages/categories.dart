import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stashwise/pages/new_category.dart';
import 'package:stashwise/pages/transaction_history.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<Map<String, dynamic>> _categories = [];

  Future<void> _fetchCategories() async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'fund_management.db'),
    );

    final categories = await database.query('Categories');
    setState(() {
      _categories = categories;
    });
  }

  Future<int> _countTransactions(int categoryId) async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'fund_management.db'),
    );

    final count = await database.rawQuery(
      'SELECT COUNT(*) FROM transactions WHERE category_id = ?',
      [categoryId],
    );

    return Sqflite.firstIntValue(count) ?? 0;
  }

  Future<void> _deleteCategory(int categoryId) async {
    try {
      final database = await openDatabase(
        join(await getDatabasesPath(), 'fund_management.db'),
      );
      await database.delete(
        'Categories',
        where: 'category_id = ?',
        whereArgs: [categoryId],
      );

      await _fetchCategories();

      if (mounted) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          const SnackBar(content: Text('Category deleted successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          const SnackBar(content: Text('Failed to delete category')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 48.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Categories List
            Expanded(
              child: _categories.isEmpty
                  ? const Center(
                      child: Text(
                        'No categories added yet.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];

                        return FutureBuilder<int>(
                          future: _countTransactions(category['category_id']),
                          builder: (context, snapshot) {
                            int transactionCount = snapshot.data ?? 0;
                            return Container(
                              margin: const EdgeInsets.only(bottom: 16.0),
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[400]!,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TransactionHistoryPage(
                                        selectedCategory:
                                            category['category_id'].toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    // Category Info
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                category['category_name'],
                                                style: const TextStyle(
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF080708),
                                                ),
                                              ),
                                              Text(
                                                '$transactionCount transactions',
                                                style: TextStyle(
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            category['description'] ??
                                                'No description',
                                            style: const TextStyle(
                                              fontFamily: 'Open Sans',
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Delete Button
                                    IconButton(
                                      onPressed: () async {
                                        // Show confirmation dialog
                                        final confirm = await showDialog<bool>(
                                          context: context,
                                          builder:
                                              (BuildContext dialogContext) =>
                                                  AlertDialog(
                                            title:
                                                const Text("Delete Category"),
                                            content: const Text(
                                                "Are you sure you want to delete this category?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    dialogContext,
                                                    false), // Close dialog
                                                child: const Text("Cancel"),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    dialogContext,
                                                    true), // Confirm
                                                child: const Text("Delete"),
                                              ),
                                            ],
                                          ),
                                        );

                                        if (confirm == true) {
                                          await _deleteCategory(
                                              category['category_id']);
                                        }
                                      },
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      tooltip: "Delete",
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }),
            ),
          ],
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewCategoryPage()),
          );

          if (result == true) {
            _fetchCategories();
          }
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
