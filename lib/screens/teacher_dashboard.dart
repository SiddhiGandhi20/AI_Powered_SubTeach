import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/job_details.dart';
import 'package:flutter_application_1/screens/teacher_Notification%20.dart';
import 'package:flutter_application_1/screens/teacher_SavedJobsScreen.dart';
import 'package:flutter_application_1/screens/teacher_profile.dart';
import 'package:flutter_application_1/screens/teacher_schools_messages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _selectedSubject = 'All Subjects';
  late List<Widget> _screens;
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

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeContent(
        jobPositions: jobPositions,
        saveJob: _saveJob,
        savedJobs: savedJobs,
      ),
      const TeacherSchoolsMessages(),
      SavedJobsScreen(savedJobs: savedJobs),
      const TeacherProfileScreen(),
    ];
  }

  void _saveJob(Map<String, String> job) {
    setState(() {
      if (!savedJobs.contains(job)) {
        savedJobs.add(job);
        _screens = [
          HomeContent(
            jobPositions: jobPositions,
            saveJob: _saveJob,
            savedJobs: savedJobs,
          ),
          const TeacherSchoolsMessages(),
          SavedJobsScreen(savedJobs: savedJobs),
          const TeacherProfileScreen(),
        ];
      }
    });
  }

  // Add this method to handle back button
  DateTime? _lastPressedAt;

  Future<bool> _onWillPop() async {
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return false;
    }

    final now = DateTime.now();
    if (_lastPressedAt == null ||
        now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
      _lastPressedAt = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Press back again to exit')),
      );
      return false;
    }
    return true;
  }

  // Navigate to the JobDetailsScreen
  void _navigateToJobDetails(Map<String, String> job) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JobDetailsScreen(job: job),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Map<String, String>> getFilteredJobPositions() {
    if (_selectedSubject == 'All Subjects') {
      return jobPositions;
    } else {
      return jobPositions
          .where((job) => job['subject'] == _selectedSubject)
          .toList();
    }
  }

  IconButton _buildBookmarkButton(Map<String, String> job) {
    bool isSaved = savedJobs.contains(job);
    return IconButton(
      icon: Icon(
        isSaved ? Icons.bookmark : Icons.bookmark_border,
        color: isSaved ? Colors.blue : Colors.grey,
      ),
      onPressed: () => _saveJob(job),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _screens[_selectedIndex], // Display the selected screen
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.message), label: 'Messages'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border), label: 'Saved'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

// Extracted HomeContent widget to maintain the home screen UI
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

  List<Map<String, String>> getFilteredJobPositions() {
    if (_selectedSubject == 'All Subjects') {
      return widget.jobPositions;
    } else {
      return widget.jobPositions
          .where((job) => job['subject'] == _selectedSubject)
          .toList();
    }
  }

  void _navigateToJobDetails(Map<String, String> job) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JobDetailsScreen(job: job),
      ),
    );
  }

  Widget _buildSubjectChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        label: Text(label),
        onSelected: (bool selected) {
          setState(() {
            _selectedSubject = selected ? label : 'All Subjects';
          });
        },
        backgroundColor: isSelected ? Colors.blue : Colors.grey.shade100,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(Icons.school, color: Colors.blue, size: 24),
                const SizedBox(width: 8),
                const Text(
                  'SubTeach',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Stack(
                    children: [
                      const Icon(Icons.notifications_outlined, size: 24),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 8,
                            minHeight: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TeacherNotificationsPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TeacherProfileScreen(),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.grey.shade200,
                    child: const Icon(Icons.person, size: 20),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for teaching opportunities...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.tune),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _buildSubjectChip(
                    'All Subjects', _selectedSubject == 'All Subjects'),
                _buildSubjectChip(
                    'Mathematics', _selectedSubject == 'Mathematics'),
                _buildSubjectChip('Science', _selectedSubject == 'Science'),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Available Positions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                                Text(
                                  job['subject']!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  job['school']!,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 16,
                                      color: Colors.grey.shade600,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      job['location']!,
                                      style: TextStyle(
                                          color: Colors.grey.shade600),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      job['salary']!,
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Posted ${job['postedTime']}',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.bookmark,
                              color: Colors.blue,
                            ),
                            onPressed: () => widget.saveJob(job),
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
      ),
    );
  }
}
