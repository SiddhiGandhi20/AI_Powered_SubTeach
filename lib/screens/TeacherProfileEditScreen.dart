import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class TeacherProfileEditScreen extends StatefulWidget {
  final String teacherId;
  final String name;
  final String email;
  final String subject;
  final String qualification;
  final String experience;
  final bool availability;
  final String profilePhoto;

  TeacherProfileEditScreen({
    required this.teacherId,
    required this.name,
    required this.email,
    required this.subject,
    required this.qualification,
    required this.experience,
    required this.availability,
    required this.profilePhoto,
  });

  @override
  _TeacherProfileEditScreenState createState() => _TeacherProfileEditScreenState();
}

class _TeacherProfileEditScreenState extends State<TeacherProfileEditScreen> {
  late String name;
  late String email;
  late String subject;
  late String qualification;
  late String experience;
  late bool availability;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    name = widget.name;
    email = widget.email;
    subject = widget.subject;
    qualification = widget.qualification;
    experience = widget.experience;
    availability = widget.availability;
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateTeacherProfile() async {
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse('http://192.168.29.33:5000/teacher/${widget.teacherId}'),
    );

    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['subject'] = subject;
    request.fields['experience'] = experience;
    request.fields['qualification'] = qualification;
    request.fields['availability'] = availability.toString();

    if (_image != null) {
      request.files.add(await http.MultipartFile.fromPath('profile_photo', _image!.path));
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      debugPrint('✅ Profile updated successfully');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully!')),
      );
    } else {
      debugPrint('❌ Failed to update profile: ${response.reasonPhrase}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Teacher Profile'),
        actions: [IconButton(icon: Icon(Icons.save), onPressed: _updateTeacherProfile)],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _image == null
                    ? (widget.profilePhoto.isNotEmpty
                        ? NetworkImage(widget.profilePhoto)
                        : AssetImage('assets/images/placeholder.jpg'))
                    : FileImage(_image!),
                child: Icon(Icons.camera_alt, size: 30, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
