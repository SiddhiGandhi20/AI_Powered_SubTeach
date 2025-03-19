import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/job_details.dart';
import 'package:flutter_application_1/screens/teacher_profile.dart';
import 'package:flutter_application_1/screens/teacher_schools_messages.dart';

void main() {
  runApp(const TeachSpotApp());
}

class TeachSpotApp extends StatelessWidget {
  const TeachSpotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final String _selectedSubject = 'All Subjects';

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

  // Lifted state for saved jobs
  List<Map<String, String>> savedJobs = [];

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

  // Save job method
  void _saveJob(Map<String, String> job) {
    setState(() {
      if (!savedJobs.contains(job)) {
        savedJobs.add(job);
      }
    });
  }

  // List of screens for bottom navigation
  List<Widget> get _screens => [
        HomeContent(
          jobPositions: jobPositions, // ✅ Now it works
          saveJob: _saveJob, // ✅ Now it works
          savedJobs: savedJobs, // ✅ Now it works
        ),
        const TeacherSchoolsMessages(),
        SavedJobsScreen(savedJobs: savedJobs), // ✅ Now it works
       TeacherProfileScreen(),
      ];

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
  final List<Map<String, String>> jobPositions;
  final Function(Map<String, String>) saveJob;
  final List<Map<String, String>> savedJobs;

  const HomeContent({
    super.key,
    required this.jobPositions,
    required this.saveJob,
    required this.savedJobs,
  });

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

  IconButton _buildBookmarkButton(Map<String, String> job) {
    bool isSaved = widget.savedJobs.contains(job);
    return IconButton(
      icon: Icon(
        isSaved ? Icons.bookmark : Icons.bookmark_border,
        color: isSaved ? Colors.blue : Colors.grey,
      ),
      onPressed: () => widget.saveJob(job),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // ... (rest of the HomeContent UI remains the same)
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
                          // ... (rest of the job card UI)
                          _buildBookmarkButton(job),
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

class SavedJobsScreen extends StatelessWidget {
  final List<Map<String, String>> savedJobs;

  const SavedJobsScreen({super.key, required this.savedJobs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save Job'),
      ),
      body: ListView.builder(
        itemCount: savedJobs.length,
        itemBuilder: (context, index) {
          final job = savedJobs[index];
          return ListTile(
            title: Text(job['subject'] ?? ''),
            subtitle: Text(job['school'] ?? ''),
            trailing: Text(job['salary'] ?? ''),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JobDetailsScreen(job: job),
              ),
            ),
          );
        },
      ),
    );
  }
}
