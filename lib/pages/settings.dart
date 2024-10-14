import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white, // White background
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0), // Padding around the title
                child: Text(
                  'Settings', // Title styled similarly to other pages
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 48.0, // Large font size for the heading
                    fontWeight: FontWeight.w800, // Bold text
                    color: Colors.black, // Dark color
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  children: [
                    ListTile(
                      title: const Text(
                        'Profile',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 27.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF080708),
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF1F62FF)),
                      onTap: () {
                        // Handle navigation
                      },
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      title: const Text(
                        'PIN',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 27.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF080708),
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF1F62FF)),
                      onTap: () {
                        // Handle navigation
                      },
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      title: const Text(
                        'Backup',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 27.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF080708),
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF1F62FF)),
                      onTap: () {
                        // Handle navigation
                      },
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      title: const Text(
                        'About',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 27.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF080708),
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF1F62FF)),
                      onTap: () {
                        // Handle navigation
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
