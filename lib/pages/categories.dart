import 'package:flutter/material.dart';
import 'package:stashwise/pages/new_category.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

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
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  // Mock Category Tile 1
                  Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[400]!, // Subtle grey boundary
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Groceries',
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF080708),
                              ),
                            ),
                            Text(
                              '15 transactions',
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
                        const Text(
                          'Category for all food and household items.',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Mock Category Tile 2
                  Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[400]!, // Subtle grey boundary
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Entertainment',
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF080708),
                              ),
                            ),
                            Text(
                              '8 transactions',
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
                        const Text(
                          'Category for movies, games, and subscriptions.',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewCategoryPage()),
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
