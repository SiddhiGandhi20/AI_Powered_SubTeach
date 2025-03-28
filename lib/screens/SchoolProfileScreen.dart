import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/SchoolProfileEditScreen.dart';
import 'package:http/http.dart' as http;

class SchoolProfileScreen extends StatefulWidget {
  const SchoolProfileScreen({super.key});

  @override
  State<SchoolProfileScreen> createState() => _SchoolProfileScreenState();
}

class _SchoolProfileScreenState extends State<SchoolProfileScreen> {
  String schoolName = 'Riverside Academy';
  String schoolEmail = 'info@riverside.edu';
  String schoolPhone = '(555) 123-4567';
  String schoolAddress = '123 Education Lane';
  String schoolWebsite = 'www.riverside.edu';

  @override
  void initState() {
    super.initState();
    fetchSchoolInfo(); // Fetch updated data when screen loads
  }

  Future<void> fetchSchoolInfo() async {
    final url = Uri.parse('http://192.168.29.176:5000/api/school'); // Use your actual API URL

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      setState(() {
        schoolName = data['schoolName'] ?? 'Unknown School';
        schoolEmail = data['schoolEmail'] ?? 'N/A';
        schoolPhone = data['schoolPhone'] ?? 'N/A';
        schoolAddress = data['schoolAddress'] ?? 'N/A';
        schoolWebsite = data['schoolWebsite'] ?? 'N/A';
      });
    } else {
      print("Failed to fetch school info: ${response.body}");
    }
  }

  Future<void> updateSchoolInfo(Map<String, String> data) async {
    final url = Uri.parse('http://localhost:5000/api/school'); // Change to your actual API URL

    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print("School updated successfully");

      // Fetch updated data and refresh UI immediately
      fetchSchoolInfo();
    } else {
      print("Failed to update school: ${response.body}");
    }
  }

  void _navigateToEditScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SchoolProfileEditScreen(
          schoolName: schoolName,
          schoolEmail: schoolEmail,
          schoolPhone: schoolPhone,
          schoolAddress: schoolAddress,
          schoolWebsite: schoolWebsite,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        schoolName = result['schoolName'];
        schoolEmail = result['schoolEmail'];
        schoolPhone = result['schoolPhone'];
        schoolAddress = result['schoolAddress'];
        schoolWebsite = result['schoolWebsite'];
      });

      // Update the school info on the server
      updateSchoolInfo(result);
    }
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
                style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
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
                onPressed: _navigateToEditScreen,
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                            child: const Icon(Icons.school, color: Colors.white, size: 40),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(schoolName, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.grey[800])),
                              const SizedBox(height: 4),
                              Text('Educational Institution', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildContactInfo(Icons.location_on_outlined, schoolAddress),
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
            child: Text(text, style: TextStyle(color: Colors.grey[700], fontSize: 16)),
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
