import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:stashwise/pages/new_due.dart';

class DuesPage extends StatefulWidget {
  const DuesPage({super.key});

  @override
  _DuesPageState createState() => _DuesPageState();
}

class _DuesPageState extends State<DuesPage> {
  List<Map<String, dynamic>> dues = [];

  @override
  void initState() {
    super.initState();
    _fetchDuesFromDatabase();
  }

  Future<void> _fetchDuesFromDatabase() async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'fund_management.db'),
    );

    final List<Map<String, dynamic>> fetchedDues = await database.query(
      'Dues',
      orderBy: 'due_date DESC',
    );

    setState(() {
      dues = fetchedDues.map((due) {
        return {
          'title': due['due_name'],
          'toFrom': due['due_payee_name'],
          'amount': due['amount'],
          'dueDate': due['due_date'],
          'category': due['category'],
          'dueType': due['due_type'] == 1 ? 'To' : 'From',
        };
      }).toList();
    });
  }

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
              // Header
              const Text(
                'Dues',
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 48.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // List of Dues
              Expanded(
                child: dues.isEmpty
                    ? const Center(
                        child: Text(
                          'No dues yet!',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: dues.length,
                        itemBuilder: (context, index) {
                          final due = dues[index];
                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: due['dueType'] == 'To'
                                    ? Colors.green
                                    : Colors.red,
                                child: Icon(
                                  due['dueType'] == 'To'
                                      ? CupertinoIcons.arrow_down_circle
                                      : CupertinoIcons.arrow_up_circle,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                due['title'],
                                style: const TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${due['dueType']}: ${due['toFrom']}',
                                    style: const TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Due Date: ${due['dueDate']}',
                                    style: const TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Text(
                                '\u20B9 ${due['amount'].toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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

      // Floating Action Button to Add a New Due
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push<bool>(
            context,
            MaterialPageRoute(builder: (context) => const NewDuePage()),
          );

          if (result == true) {
            _fetchDuesFromDatabase();
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
