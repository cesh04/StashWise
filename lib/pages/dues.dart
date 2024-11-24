import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:stashwise/pages/new_due.dart';

class DuesPage extends StatelessWidget {
  const DuesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dues = [
      {
        'title': 'Rent',
        'toFrom': 'To: Landlord',
        'amount': 12000.0,
        'dueDate': '15th Oct 2024',
        'category': 'Housing',
        'isCollectible': false, // Indicates dues to be paid
      },
      {
        'title': 'Electricity Bill',
        'toFrom': 'To: Power Company',
        'amount': 1500.0,
        'dueDate': '20th Oct 2024',
        'category': null,
        'isCollectible': false, // Indicates dues to be paid
      },
      {
        'title': 'Freelance Payment',
        'toFrom': 'From: Client',
        'amount': 5000.0,
        'dueDate': '25th Oct 2024',
        'category': 'Income',
        'isCollectible': true, // Indicates dues to be collected
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dues',
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 48.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),

              // List of Dues
              Expanded(
                child: ListView.builder(
                  itemCount: dues.length,
                  itemBuilder: (context, index) {
                    final due = dues[index];
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
                          due['title'],
                          style: const TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF080708),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              due['toFrom'],
                              style: const TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              'Due Date: ${due['dueDate']}',
                              style: const TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                            if (due['category'] != null)
                              Text(
                                'Category: ${due['category']}',
                                style: const TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                          ],
                        ),
                        trailing: Text(
                          '\u20B9 ${due['amount']}',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: due['isCollectible'] ? Colors.green : Colors.red,
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
            MaterialPageRoute(builder: (context) => NewDuePage()),
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
