import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_application_1/screens/teacher_schools_messages.dart';

class TeacherProfileScreen extends StatefulWidget {
  const TeacherProfileScreen({super.key});

  @override
  _TeacherProfileScreenState createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {
  bool _isEditing = false;
  File? _image;

  // Initialize with empty values
  String name = '';
  String jobTitle = '';
  String about = '';
  List<String> skills = [];
  List<Map<String, String>> certifications = [];
  List<Map<String, String>> experiences = [];
  Map<String, String> availability = {
    'Mon': '',
    'Tue': '',
    'Wed': '',
    'Thu': '',
    'Fri': '',
  };
  List<Map<String, dynamic>> reviews = [];

  // Controllers for new items
  final TextEditingController _newSkillController = TextEditingController();
  final TextEditingController _newCertTitleController = TextEditingController();
  final TextEditingController _newCertSubtitleController =
      TextEditingController();
  final TextEditingController _newExpTitleController = TextEditingController();
  final TextEditingController _newExpSubtitleController =
      TextEditingController();

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        debugPrint('Image picked: ${_image!.path}');
      } else {
        debugPrint('No image selected.');
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

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
        actions: [
          IconButton(
            icon: Icon(
              _isEditing ? Icons.save : Icons.edit,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
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
        GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 60,
            backgroundImage: _image == null
                ? AssetImage(
                    'assets/images/placeholder.jpg') // Placeholder image
                : FileImage(_image!) as ImageProvider,
            child: _isEditing
                ? Icon(Icons.camera_alt, size: 30, color: Colors.white)
                : null,
          ),
        ),
        SizedBox(height: 12),
        _isEditing
            ? TextFormField(
                initialValue: name,
                onChanged: (value) => name = value,
                decoration: InputDecoration(labelText: 'Name'),
              )
            : Text(
                name.isEmpty ? 'Enter Name' : name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
        _isEditing
            ? TextFormField(
                initialValue: jobTitle,
                onChanged: (value) => jobTitle = value,
                decoration: InputDecoration(labelText: 'Job Title'),
              )
            : Text(
                jobTitle.isEmpty ? 'Enter Job Title' : jobTitle,
                style: TextStyle(color: Colors.grey[600], fontSize: 15),
              ),
        SizedBox(height: 12),
        if (name.isNotEmpty)
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
        Text(value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
          Text(title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          content,
        ],
      ),
    );
  }

  Widget _buildAboutContent() {
    return _isEditing
        ? TextFormField(
            initialValue: about,
            onChanged: (value) => about = value,
            decoration: InputDecoration(labelText: 'About'),
            maxLines: 3,
          )
        : Text(
            about.isEmpty ? 'Enter About Information' : about,
            style: TextStyle(color: Colors.grey[700], fontSize: 14),
          );
  }

  Widget _buildSkillsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_isEditing)
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _newSkillController,
                  decoration: InputDecoration(labelText: 'New Skill'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  if (_newSkillController.text.isNotEmpty) {
                    setState(() {
                      skills.add(_newSkillController.text);
                      _newSkillController.clear();
                    });
                  }
                },
              ),
            ],
          ),
        Wrap(
          spacing: 6,
          children: skills
              .map((skill) => _isEditing
                  ? Chip(
                      label: Text(skill),
                      onDeleted: () {
                        setState(() {
                          skills.remove(skill);
                        });
                      },
                    )
                  : Chip(
                      label: Text(skill),
                      backgroundColor: Colors.blue[50],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ))
              .toList(),
        ),
        if (skills.isEmpty && !_isEditing) Text('No skills added'),
      ],
    );
  }

  Widget _buildCertificationsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_isEditing)
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _newCertTitleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: _newCertSubtitleController,
                  decoration: InputDecoration(labelText: 'Subtitle'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  if (_newCertTitleController.text.isNotEmpty &&
                      _newCertSubtitleController.text.isNotEmpty) {
                    setState(() {
                      certifications.add({
                        'title': _newCertTitleController.text,
                        'subtitle': _newCertSubtitleController.text,
                      });
                      _newCertTitleController.clear();
                      _newCertSubtitleController.clear();
                    });
                  }
                },
              ),
            ],
          ),
        Column(
          children: certifications
              .map((cert) => _isEditing
                  ? ListTile(
                      leading: Icon(Icons.verified, color: Colors.blue),
                      title: TextFormField(
                        initialValue: cert['title'],
                        onChanged: (value) => cert['title'] = value,
                        decoration: InputDecoration(labelText: 'Title'),
                      ),
                      subtitle: TextFormField(
                        initialValue: cert['subtitle'],
                        onChanged: (value) => cert['subtitle'] = value,
                        decoration: InputDecoration(labelText: 'Subtitle'),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            certifications.remove(cert);
                          });
                        },
                      ),
                    )
                  : _buildListTile(
                      Icons.verified, cert['title']!, cert['subtitle']!))
              .toList(),
        ),
        if (certifications.isEmpty && !_isEditing)
          Text('No certifications added'),
      ],
    );
  }

  Widget _buildExperienceContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_isEditing)
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _newExpTitleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: _newExpSubtitleController,
                  decoration: InputDecoration(labelText: 'Subtitle'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  if (_newExpTitleController.text.isNotEmpty &&
                      _newExpSubtitleController.text.isNotEmpty) {
                    setState(() {
                      experiences.add({
                        'title': _newExpTitleController.text,
                        'subtitle': _newExpSubtitleController.text,
                      });
                      _newExpTitleController.clear();
                      _newExpSubtitleController.clear();
                    });
                  }
                },
              ),
            ],
          ),
        Column(
          children: experiences
              .map((exp) => _isEditing
                  ? ListTile(
                      leading: Icon(Icons.work_outline, color: Colors.blue),
                      title: TextFormField(
                        initialValue: exp['title'],
                        onChanged: (value) => exp['title'] = value,
                        decoration: InputDecoration(labelText: 'Title'),
                      ),
                      subtitle: TextFormField(
                        initialValue: exp['subtitle'],
                        onChanged: (value) => exp['subtitle'] = value,
                        decoration: InputDecoration(labelText: 'Subtitle'),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            experiences.remove(exp);
                          });
                        },
                      ),
                    )
                  : _buildListTile(
                      Icons.work_outline, exp['title']!, exp['subtitle']!))
              .toList(),
        ),
        if (experiences.isEmpty && !_isEditing) Text('No experience added'),
      ],
    );
  }

  Widget _buildAvailabilityContent() {
    return Column(
      children: availability.entries
          .map((entry) => Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    SizedBox(
                        width: 50,
                        child: Text(entry.key,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(
                        child: _isEditing
                            ? TextFormField(
                                initialValue: entry.value,
                                onChanged: (value) =>
                                    availability[entry.key] = value,
                                decoration: InputDecoration(labelText: 'Time'),
                              )
                            : Text(
                                entry.value.isEmpty
                                    ? 'Enter Time'
                                    : entry.value,
                                style: TextStyle(color: Colors.grey[700]))),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildReviewsContent() {
    return Column(
      children: reviews.isEmpty
          ? [Text('No reviews added')]
          : reviews
              .map((review) => _isEditing
                  ? ListTile(
                      title: TextFormField(
                        initialValue: review['name'],
                        onChanged: (value) => review['name'] = value,
                        decoration: InputDecoration(labelText: 'Name'),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: List.generate(
                                5,
                                (index) => Icon(Icons.star,
                                    size: 16,
                                    color: index < review['rating']
                                        ? Colors.amber
                                        : Colors.grey[300])),
                          ),
                          SizedBox(height: 4),
                          TextFormField(
                            initialValue: review['comment'],
                            onChanged: (value) => review['comment'] = value,
                            decoration: InputDecoration(labelText: 'Comment'),
                          ),
                        ],
                      ),
                      trailing: TextFormField(
                        initialValue: review['time'],
                        onChanged: (value) => review['time'] = value,
                        decoration: InputDecoration(labelText: 'Time'),
                      ),
                    )
                  : _buildReviewItem(
                      review['name'],
                      review['rating'],
                      review['time'],
                      review['comment'],
                    ))
              .toList(),
    );
  }

  Widget _buildReviewItem(
      String name, int rating, String time, String comment) {
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TeacherSchoolsMessages()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade600,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.symmetric(vertical: 14),
          ),
          child: Center(
            child: Text(
              'Book a Class',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: 12),
        OutlinedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TeacherSchoolsMessages()));
          },
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            side: BorderSide(color: Colors.blue.shade600),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Message school',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade600),
              ),
              SizedBox(width: 8),
              Icon(Icons.chat_bubble_outline,
                  color: Colors.blue.shade600, size: 18),
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
