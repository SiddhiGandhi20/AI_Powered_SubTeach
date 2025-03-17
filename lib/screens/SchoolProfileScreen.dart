import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(), // Ensure HomeScreen is the initial route
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SchoolProfileScreen()),
            );
          },
          child: const Text('Go to School Profile'),
        ),
      ),
    );
  }
}

class SchoolProfileScreen extends StatefulWidget {
  const SchoolProfileScreen({super.key});

  @override
  State<SchoolProfileScreen> createState() => _SchoolProfileScreenState();
}

class _SchoolProfileScreenState extends State<SchoolProfileScreen> {
  String schoolName = 'Riverside Acadeee';
  String schoolEmail = 'info@riverside.edu';
  String schoolPhone = '(555) 123-4567';
  String schoolAddress = '123 Education Lane';
  String schoolWebsite = 'www.riverside.edu';

  void _editSchoolInfo() {
    TextEditingController nameController =
        TextEditingController(text: schoolName);
    TextEditingController emailController =
        TextEditingController(text: schoolEmail);
    TextEditingController phoneController =
        TextEditingController(text: schoolPhone);
    TextEditingController addressController =
        TextEditingController(text: schoolAddress);
    TextEditingController websiteController =
        TextEditingController(text: schoolWebsite);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text('Edit School Information',
              style: TextStyle(fontWeight: FontWeight.w500)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'School Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )),
                const SizedBox(height: 8),
                TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )),
                const SizedBox(height: 8),
                TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )),
                const SizedBox(height: 8),
                TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )),
                const SizedBox(height: 8),
                TextField(
                    controller: websiteController,
                    decoration: InputDecoration(
                      labelText: 'Website',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  schoolName = nameController.text;
                  schoolEmail = emailController.text;
                  schoolPhone = phoneController.text;
                  schoolAddress = addressController.text;
                  schoolWebsite = websiteController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 70,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'School Profile',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue[900]!, Colors.blue[500]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: _editSchoolInfo,
              ),
            ],
            pinned: true,
            elevation: 4,
            shadowColor: Colors.blue,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                shadowColor: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.blue[800],
                            child: const Icon(Icons.school,
                                color: Colors.white, size: 40),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(schoolName,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey[800])),
                              const SizedBox(height: 4),
                              Text('Educational Institution',
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildContactInfo(
                          Icons.location_on_outlined, schoolAddress),
                      _buildContactInfo(Icons.phone_outlined, schoolPhone),
                      _buildContactInfo(Icons.email_outlined, schoolEmail),
                      _buildContactInfo(Icons.language_outlined, schoolWebsite),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Text('Posted Jobs',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[800])),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildJobItem(context, index),
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.blue[800]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text,
                style: TextStyle(color: Colors.grey[700], fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildJobItem(BuildContext context, int index) {
    final jobs = [
      {
        'title': 'Mathematics Teacher',
        'dept': 'Mathematics',
        'date': 'Jan 15, 2024',
        'open': true,
      },
      {
        'title': 'Science Lab Assistant',
        'dept': 'Science',
        'date': 'Jan 12, 2024',
        'open': true,
      },
      {
        'title': 'PE Instructor',
        'dept': 'Athletics',
        'date': 'Jan 10, 2024',
        'open': false,
      },
      {
        'title': 'Library Assistant',
        'dept': 'Library',
        'date': 'Jan 8, 2024',
        'open': true,
      },
      {
        'title': 'Art Teacher',
        'dept': 'Fine Arts',
        'date': 'Jan 5, 2024',
        'open': false,
      },
    ];

    final job = jobs[index];
    final isOpen = job['open'] as bool;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(Icons.work_outline, color: Colors.blue[800], size: 30),
        title: Text(
          job['title'] as String,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          job['dept'] as String,
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: Text(
          isOpen ? 'Open' : 'Closed',
          style: TextStyle(color: isOpen ? Colors.green : Colors.red),
        ),
      ),
    );
  }
}

