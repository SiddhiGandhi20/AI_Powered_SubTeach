import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TeacherProfileEditScreen extends StatefulWidget {
  final String name;
  final String jobTitle;
  final String about;
  final List<String> skills;
  final List<Map<String, String>> certifications;
  final List<Map<String, String>> experiences;
  final Map<String, String> availability;
  final List<Map<String, dynamic>> reviews;
  final File? image;

  TeacherProfileEditScreen({
    required this.name,
    required this.jobTitle,
    required this.about,
    required this.skills,
    required this.certifications,
    required this.experiences,
    required this.availability,
    required this.reviews,
    this.image,
  });

  @override
  _TeacherProfileEditScreenState createState() => _TeacherProfileEditScreenState();
}

class _TeacherProfileEditScreenState extends State<TeacherProfileEditScreen> {
  late String name;
  late String jobTitle;
  late String about;
  late List<String> skills;
  late List<Map<String, String>> certifications;
  late List<Map<String, String>> experiences;
  late Map<String, String> availability;
  late List<Map<String, dynamic>> reviews;
  File? _image;

  final TextEditingController _newSkillController = TextEditingController();
  final TextEditingController _newCertTitleController = TextEditingController();
  final TextEditingController _newCertSubtitleController = TextEditingController();
  final TextEditingController _newExpTitleController = TextEditingController();
  final TextEditingController _newExpSubtitleController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    name = widget.name;
    jobTitle = widget.jobTitle;
    about = widget.about;
    skills = List.from(widget.skills);
    certifications = List.from(widget.certifications);
    experiences = List.from(widget.experiences);
    availability = Map.from(widget.availability);
    reviews = List.from(widget.reviews);
    _image = widget.image;
  }

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
          'Edit Teacher Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.black),
            onPressed: () {
              // Save logic here
              Navigator.pop(context, {
                'name': name,
                'jobTitle': jobTitle,
                'about': about,
                'skills': skills,
                'certifications': certifications,
                'experiences': experiences,
                'availability': availability,
                'reviews': reviews,
                'image': _image,
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
                ? AssetImage('assets/images/placeholder.jpg')
                : FileImage(_image!) as ImageProvider,
            child: Icon(Icons.camera_alt, size: 30, color: Colors.white),
          ),
        ),
        SizedBox(height: 12),
        TextFormField(
          initialValue: name,
          onChanged: (value) => name = value,
          decoration: InputDecoration(labelText: 'Name'),
        ),
        TextFormField(
          initialValue: jobTitle,
          onChanged: (value) => jobTitle = value,
          decoration: InputDecoration(labelText: 'Job Title'),
        ),
        SizedBox(height: 12),
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
    return TextFormField(
      initialValue: about,
      onChanged: (value) => about = value,
      decoration: InputDecoration(labelText: 'About'),
      maxLines: 3,
    );
  }

  Widget _buildSkillsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              .map((skill) => Chip(
                    label: Text(skill),
                    onDeleted: () {
                      setState(() {
                        skills.remove(skill);
                      });
                    },
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildCertificationsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              .map((cert) => ListTile(
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
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildExperienceContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              .map((exp) => ListTile(
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
                  ))
              .toList(),
        ),
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
                    SizedBox(width: 50, child: Text(entry.key, style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(
                      child: TextFormField(
                        initialValue: entry.value,
                        onChanged: (value) => availability[entry.key] = value,
                        decoration: InputDecoration(labelText: 'Time'),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildReviewsContent() {
    return Column(
      children: reviews
          .map((review) => ListTile(
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
                        (index) => Icon(Icons.star, size: 16, color: index < review['rating'] ? Colors.amber : Colors.grey[300]),
                      ),
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
              ))
          .toList(),
    );
  }
}
