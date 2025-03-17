import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/SchoolProfileScreen.dart';
import 'package:flutter_application_1/screens/job_posting.dart';
import 'package:flutter_application_1/screens/notification_screen.dart';
import 'package:flutter_application_1/screens/Sidebar.dart';
import 'package:flutter_application_1/screens/school_schedule.dart';
import 'package:flutter_application_1/screens/chat_list_screen.dart'; // Import the ChatListScreen
import 'package:flutter_application_1/widgets/floating_chatbot_button.dart'; // Import the DraggableFloatingChatbotButton

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const JobDashboard(),
    );
  }
}

class JobDashboard extends StatefulWidget {
  const JobDashboard({super.key});

  @override
  State<JobDashboard> createState() => _JobDashboardState();
}

class _JobDashboardState extends State<JobDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0; // Track the selected tab index

  final List<Map<String, String>> _jobs = [
    {'title': 'Mathematics Teacher', 'status': 'Active'},
    {'title': 'Science Lab Assistant', 'status': 'Active'},
    {'title': 'Physical Education Coach', 'status': 'Pending'},
    {'title': 'Art Teacher', 'status': 'Active'},
    {'title': 'History Teacher', 'status': 'Pending'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SchoolProfileScreen()),
            );
          },
          child: const Text(
            'Brighton Academy',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationsScreen()),
              );
            },
          ),
        ],
      ),
      drawer: const Sidebar(),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Job Statistics Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatCard(
                          'All', _jobs.length.toString(), Colors.grey.shade200),
                      _buildStatCard(
                          'Active',
                          _jobs
                              .where((job) => job['status'] == 'Active')
                              .length
                              .toString(),
                          Colors.green.shade100),
                      _buildStatCard(
                          'Pending',
                          _jobs
                              .where((job) => job['status'] == 'Pending')
                              .length
                              .toString(),
                          Colors.orange.shade100),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Post New Job Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PostTeachingPosition()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('+ Post a New Job'),
                  ),
                  const SizedBox(height: 16),

                  // Job Listings Title
                  const Text(
                    'Active Job Postings',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // Job Listings
                  Expanded(
                    child: ListView.builder(
                      itemCount: _jobs.length,
                      itemBuilder: (context, index) {
                        final job = _jobs[index];
                        return _buildJobCard(job['title']!, job['status']!);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Draggable floating chatbot button
          DraggableFloatingChatbotButton(),
        ],
      ),

      // Enhanced Bottom Navigation Bar
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex, // Track selected index
          onTap: (index) {
            setState(() {
              _selectedIndex = index; // Update selected index when a tab is tapped
            });

            // Add navigation for the Profile tab
            if (index == 4) {
              // Profile is the 5th item (index 4)
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SchoolProfileScreen()),
              );
            }
            if (index == 3) {
              // Profile is the 5th item (index 4)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScheduleScreen()),
              );
            }
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsScreen()), // Navigate to Chat List
              );
            }

            // Navigate to the Chat List screen when Messages tab is clicked
            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatListScreen()), // Navigate to Chat List
              );
            }
          },
          backgroundColor: Colors.blue.shade800, // Set the background color here
          selectedItemColor: const Color.fromARGB(255, 66, 64, 64), // Color for the selected item
          unselectedItemColor: const Color.fromARGB(255, 21, 21, 21), // Color for unselected items
          selectedFontSize: 14, // Font size for selected items
          unselectedFontSize: 12, // Font size for unselected items
          elevation: 10, // Shadow effect
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work),
              label: 'Applications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Job Listings
  Widget _buildJobCard(String title, String status) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: const Icon(Icons.work_outline, color: Colors.blue),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(
          status,
          style: TextStyle(
            color: status == 'Active' ? Colors.green : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Widget for Statistics Cards
  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
