import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: SchoolProfileScreen(),
  ));
}

class SchoolProfileScreen extends StatelessWidget {
  const SchoolProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'School Profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Color(0xFF246BFD),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            // School Profile Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Color(0xFF246BFD),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.school,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Riverside Academy',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Educational Institution',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildContactInfo(Icons.location_on, '123 Education Lane, Academic District'),
                    _buildContactInfo(Icons.phone, '(555) 123-4567'),
                    _buildContactInfo(Icons.email, 'info@riversideacademy.edu'),
                    _buildContactInfo(Icons.language, 'www.riversideacademy.edu'),
                  ],
                ),
              ),
            ),
            // Posted Jobs Header
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Posted Jobs',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Job Listings
            SliverList(
              delegate: SliverChildListDelegate([
                _buildJobItem(
                  'Mathematics Teacher',
                  'Mathematics Department',
                  'Posted Jan 15, 2024',
                  true,
                ),
                _buildJobItem(
                  'Science Lab Assistant',
                  'Science Department',
                  'Posted Jan 12, 2024',
                  true,
                ),
                _buildJobItem(
                  'Physical Education Instructor',
                  'Athletics Department',
                  'Posted Jan 10, 2024',
                  false,
                ),
                _buildJobItem(
                  'Library Assistant',
                  'Library Services',
                  'Posted Jan 8, 2024',
                  true,
                ),
                _buildJobItem(
                  'Art Teacher',
                  'Fine Arts Department',
                  'Posted Jan 5, 2024',
                  false,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.grey,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobItem(String title, String department, String date, bool isOpen) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isOpen
                      ? const Color(0xFFE8F5E9)
                      : const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  isOpen ? 'Open' : 'Closed',
                  style: TextStyle(
                    color: isOpen
                        ? const Color(0xFF2E7D32)
                        : const Color(0xFFD32F2F),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.business,
                size: 16,
                color: Colors.grey,
              ),
              const SizedBox(width: 8),
              Text(
                department,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.access_time,
                size: 16,
                color: Colors.grey,
              ),
              const SizedBox(width: 8),
              Text(
                date,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}