import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var name = 'Swapnil'; // Your name

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
                'Good Morning, $name',
                style: const TextStyle(
                  fontFamily: 'Open Sans',
                  color: Color(0xFF080708),
                  fontSize: 50.0,
                  fontWeight: FontWeight.w800,
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
                          children: const [
                            Text(
                              '\$350',
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
                          children: const [
                            Text(
                              '\$7500',
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
                    trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF1F62FF)),
                    onTap: () {},
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
                    trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF1F62FF)),
                    onTap: () {},
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
                    trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF1F62FF)),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Adding the Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add action for the FAB here
        },
        backgroundColor: const Color(0xFF1F62FF), // Matching theme color
        child: const Icon(
          Icons.add,
          size: 36.0, // Slightly larger icon size for prominence
          color: Colors.white, // White color for contrast
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Center FAB at bottom
    );
  }
}
