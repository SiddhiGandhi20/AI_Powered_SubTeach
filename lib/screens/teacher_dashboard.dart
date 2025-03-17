import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/custom_drawer.dart';
import 'package:flutter_application_1/screens/job_details.dart';
import 'package:flutter_application_1/screens/teacher_Notification%20.dart';
import 'package:flutter_application_1/screens/teacher_SavedJobsScreen.dart';
// import 'package:flutter_application_1/screens/teacher_notifications.dart';
// import 'package:flutter_application_1/screens/teacher_saved_jobs_screen.dart';
import 'package:flutter_application_1/screens/teacher_profile.dart';
import 'package:flutter_application_1/screens/teacher_schools_messages.dart';
import 'package:flutter_application_1/widgets/floating_chatbot_button.dart'; // Import the DraggableFloatingChatbotButton

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, String>> jobPositions = [
    {
      'subject': 'Mathematics',
      'school': 'Riverside High School',
      'location': 'Brooklyn, NY',
      'salary': '\$45-55/hr',
      'postedTime': '2 hours ago'
    },
    {
      'subject': 'Science',
      'school': 'Oak Valley Elementary',
      'location': 'Queens, NY',
      'salary': '\$40-50/hr',
      'postedTime': '6 hours ago'
    },
  ];
  final List<Map<String, String>> savedJobs = [];

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeContent(
          jobPositions: jobPositions, saveJob: _saveJob, savedJobs: savedJobs),
      const TeacherSchoolsMessages(),
      SavedJobsScreen(savedJobs: savedJobs),
      const TeacherProfileScreen(),
    ];
  }

  void _saveJob(Map<String, String> job) {
    setState(() {
      if (!savedJobs.contains(job)) {
        savedJobs.add(job);
        _screens[2] = SavedJobsScreen(savedJobs: savedJobs);
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('SubTeach',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, size: 24),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TeacherNotificationsPage()));
            },
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TeacherProfileScreen()));
            },
            child: const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 20, color: Colors.white),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          _screens[_selectedIndex],
          // Draggable floating chatbot button
          DraggableFloatingChatbotButton(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border), label: 'Saved'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent(
      {super.key,
      required this.jobPositions,
      required this.saveJob,
      required this.savedJobs});

  final List<Map<String, String>> jobPositions;
  final Function(Map<String, String>) saveJob;
  final List<Map<String, String>> savedJobs;

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String _selectedSubject = 'All Subjects';
  String _searchQuery = '';

  List<Map<String, String>> getFilteredJobPositions() {
    return widget.jobPositions.where((job) {
      final matchesSubject = _selectedSubject == 'All Subjects' ||
          job['subject'] == _selectedSubject;
      final matchesSearch = job['school']!
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          job['location']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          job['subject']!.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesSubject && matchesSearch;
    }).toList();
  }

  void _navigateToJobDetails(Map<String, String> job) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => JobDetailsScreen(job: job)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for job opportunities...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              DropdownButton<String>(
                value: _selectedSubject,
                items:
                    ['All Subjects', 'Mathematics', 'Science'].map((subject) {
                  return DropdownMenuItem(
                    value: subject,
                    child: Text(subject, style: const TextStyle(fontSize: 16)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSubject = value!;
                  });
                },
                underline: Container(
                  height: 2,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: getFilteredJobPositions().map((job) {
              return GestureDetector(
                onTap: () {
                  _navigateToJobDetails(job);
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.school_outlined),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(job['subject']!,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(job['school']!,
                                  style: const TextStyle(color: Colors.grey)),
                              const SizedBox(height: 4),
                              Text('Salary: ${job['salary']}',
                                  style: const TextStyle(color: Colors.grey)),
                              const SizedBox(height: 4),
                              Text('Posted ${job['postedTime']}',
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12)),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.bookmark,
                                  color: Colors.blue),
                              onPressed: () => widget.saveJob(job),
                            ),
                            const SizedBox(
                                height: 8), // Add spacing between buttons
                            ElevatedButton(
                              onPressed: () {
                                // Add your apply logic here
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2), // Reduced padding for a smaller button
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JobDetailsScreen(job: job),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Apply Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
