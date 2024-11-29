import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:stashwise/utils/database_helper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  late TextEditingController _nameController;
  late TextEditingController _dobController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _dobController = TextEditingController();
    _emailController = TextEditingController();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    List<Map<String, dynamic>> personalDetails =
        await _dbHelper.getPersonalDetails();

    if (personalDetails.isNotEmpty) {
      Map<String, dynamic> user = personalDetails.first;
      setState(() {
        _nameController.text = user['name'] ?? '';
        _dobController.text = user['date_of_birth'] ?? '';
        _emailController.text = user['email'] ?? '';
      });
    }
  }

  Future<void> _updateUserProfile() async {
    String name = _nameController.text;
    String dob = _dobController.text;
    String email = _emailController.text;

    await _dbHelper.updateUserProfile(name, dob, email);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully!')),
    );
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
                  'Edit\nProfile',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 48.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 60),

                // Name Input Field
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
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

                // Date of Birth Input Field
                TextField(
                  controller: _dobController,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
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

                // Email Input Field
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
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
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 250), // Spacer before the button
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity, // Full width
          child: ElevatedButton(
            onPressed: _updateUserProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1F62FF), // Blue button
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Update Profile',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'Open Sans',
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
      ),
    );
  }
}
