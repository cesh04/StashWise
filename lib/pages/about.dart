import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
                // Heading for the About page
                const Text(
                  'About',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 48.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 60),

                // About paragraph content
                const Text(
                  'Personal Expense Management is an intuitive application designed for students and individuals looking to track and manage their finances. The app allows users to log their transactions with neat categorization and keep track of dues. With features like expense logging, categorization, and tracking due payments, users can gain valuable insights into their spending habits and manage their finances effectively. Basic analytics provide a deeper look into spending patterns, helping users make informed financial decisions.',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF080708),
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 250), // Spacer for the page
              ],
            ),
          ),
        ),
      ),
    );
  }
}
