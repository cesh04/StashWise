import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NewDuePage extends StatefulWidget {
  const NewDuePage({super.key});

  @override
  _NewDuePageState createState() => _NewDuePageState();
}

class _NewDuePageState extends State<NewDuePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _toFromController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  List<String> categories = [];
  String selectedCategory = 'Select Category';
  String _toFromType = 'To';

  Future<void> _addDueToDatabase(
      String title, String toFrom, double amount, String dueDate) async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'fund_management.db'),
    );

    int dueType = (toFrom == 'To') ? 1 : 0;

    await database.insert(
      'Dues',
      {
        'due_name': title,
        'due_payee_name': toFrom,
        'amount': amount,
        'due_type': dueType,
        'due_date': dueDate,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> _loadCategories() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'fund_management.db'),
    );

    final List<Map<String, dynamic>> categoryList =
        await db.query('Categories');

    setState(() {
      categories = ['Select Category']
          .followedBy(categoryList
              .map((category) => category['category_name'] as String))
          .toList();

      selectedCategory = 'Select Category';
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
                  'New\nDue',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 48.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 40),

                // Title Input
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title of Due',
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

                // To/From Dropdown + Input
                Row(
                  children: [
                    // Dropdown for To/From
                    Expanded(
                      flex: 1,
                      child: DropdownButtonFormField<String>(
                        value: _toFromType,
                        items: ['To', 'From'].map((type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Type',
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
                        onChanged: (value) {
                          setState(() {
                            _toFromType = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Input for To/From Value
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _toFromController,
                        decoration: InputDecoration(
                          labelText:
                              'Enter ${_toFromType == "To" ? "Recipient" : "Payer"}',
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
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Amount Input
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount (\u20B9)',
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

                // Due Date Input
                TextField(
                  controller: _dueDateController,
                  decoration: InputDecoration(
                    labelText: 'Due Date (DD/MM/YYYY)',
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
                  keyboardType: TextInputType.datetime,
                ),
                const SizedBox(height: 20),

                // Category Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Category (Optional)',
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
                const SizedBox(height: 30),

                // Add Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_titleController.text.isEmpty ||
                          _toFromController.text.isEmpty ||
                          _amountController.text.isEmpty ||
                          _dueDateController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill in all fields.'),
                          ),
                        );
                        return;
                      }
                      await _addDueToDatabase(
                        _titleController.text,
                        _toFromType,
                        double.parse(_amountController.text),
                        _dueDateController.text,
                        //_category,
                      );
                      Navigator.pop(context, true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F62FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(16.0),
                    ),
                    child: const Text(
                      'Add Due',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
