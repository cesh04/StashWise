import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:stashwise/pages/register.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // StashWise logo taking up the first half of the screen
            const Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  'StashWise',
                  style: TextStyle(
                    fontFamily: 'Lobster Two',
                    fontSize: 48.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Button 1: Create New Account
                  SizedBox(
                    width: double.infinity, // Full-width button
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        backgroundColor:
                            const Color(0xFF1F62FF), // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Create New Account',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            CupertinoIcons.chevron_forward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 18), // Spacing between buttons

                  // Button 2: Restore from Backup File
                  SizedBox(
                    width: double.infinity, // Full-width button
                    child: ElevatedButton(
                      onPressed: () {
                        // Restore action goes here
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        backgroundColor:
                            const Color(0xFF1F62FF), // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Restore from Backup File',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 10), // Spacing between text and icon
                          Icon(
                            CupertinoIcons.chevron_forward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
