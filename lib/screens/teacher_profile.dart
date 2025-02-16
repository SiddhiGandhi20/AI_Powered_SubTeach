import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/teacher_schools_messages.dart';

class TeacherProfileScreen extends StatelessWidget {
  const TeacherProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Teacher Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSection('About', _buildAboutContent()),
            _buildSection('Skills & Expertise', _buildSkillsContent()),
            _buildSection('Certifications', _buildCertificationsContent()),
            _buildSection('Experience', _buildExperienceContent()),
            _buildSection('Availability', _buildAvailabilityContent()),
            _buildSection('Student Reviews', _buildReviewsContent()),
            SizedBox(height: 20),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage('assets/images/image.jpg'),
        ),
        SizedBox(height: 12),
        Text(
          'Sarah Wilson',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          'Mathematics & Physics Teacher',
          style: TextStyle(color: Colors.grey[600], fontSize: 15),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStat('4.9', '★'),
            SizedBox(width: 20),
            _buildStat('234', 'Students'),
            SizedBox(width: 20),
            _buildStat('7+', 'Years'),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
      ],
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          content,
        ],
      ),
    );
  }

  Widget _buildAboutContent() {
    return Text(
      'Dedicated educator with over 5 years of experience in Mathematics and Physics. Specializes in engaging students and creating enriched learning opportunities.',
      style: TextStyle(color: Colors.grey[700], fontSize: 14),
    );
  }

  Widget _buildSkillsContent() {
    return Wrap(
      spacing: 6,
      children: ['SAT Prep', 'AP Physics', 'Online Teaching']
          .map((skill) => Chip(
                label: Text(skill),
                backgroundColor: Colors.blue[50],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ))
          .toList(),
    );
  }

  Widget _buildCertificationsContent() {
    return Column(
      children: [
        _buildListTile(Icons.verified, 'Masters in Education', 'University of Education, 2018-2020'),
        _buildListTile(Icons.verified, 'Teaching License', 'State Board of Education, 2020'),
      ],
    );
  }

  Widget _buildExperienceContent() {
    return Column(
      children: [
        _buildListTile(Icons.work_outline, 'Senior Mathematics Teacher', 'High School | 2020 - Present'),
        _buildListTile(Icons.work_outline, 'Physics Instructor', 'Science Academy | 2018 - 2020'),
      ],
    );
  }

  Widget _buildAvailabilityContent() {
    return Column(
      children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri']
          .map((day) => Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    SizedBox(width: 50, child: Text(day, style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(child: Text('9:00 AM - 5:00 PM', style: TextStyle(color: Colors.grey[700]))),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildReviewsContent() {
    return Column(
      children: [
        _buildReviewItem('Sarah Johnson', 5, '2 weeks ago', 'Excellent teacher!'),
        _buildReviewItem('Michael Chen', 5, '1 month ago', 'Very helpful and engaging.'),
      ],
    );
  }

  Widget _buildReviewItem(String name, int rating, String time, String comment) {
    return ListTile(
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
                5,
                (index) => Icon(Icons.star,
                    size: 16,
                    color: index < rating ? Colors.amber : Colors.grey[300])),
          ),
          SizedBox(height: 4),
          Text(comment, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
      trailing: Text(time, style: TextStyle(color: Colors.grey, fontSize: 12)),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherSchoolsMessages()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade600,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.symmetric(vertical: 14),
          ),
          child: Center(
            child: Text(
              'Book a Class',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: 12),
        OutlinedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherSchoolsMessages()));
          },
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            side: BorderSide(color: Colors.blue.shade600),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Message Teacher',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue.shade600),
              ),
              SizedBox(width: 8),
              Icon(Icons.chat_bubble_outline, color: Colors.blue.shade600, size: 18),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[700])),
    );
  }
}
