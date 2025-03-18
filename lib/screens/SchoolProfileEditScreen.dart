import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SchoolProfileEditScreen extends StatefulWidget {
  final String schoolName;
  final String schoolEmail;
  final String schoolPhone;
  final String schoolAddress;
  final String schoolWebsite;

  SchoolProfileEditScreen({
    required this.schoolName,
    required this.schoolEmail,
    required this.schoolPhone,
    required this.schoolAddress,
    required this.schoolWebsite,
  });

  @override
  _SchoolProfileEditScreenState createState() =>
      _SchoolProfileEditScreenState();
}

class _SchoolProfileEditScreenState extends State<SchoolProfileEditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _websiteController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.schoolName);
    _emailController = TextEditingController(text: widget.schoolEmail);
    _phoneController = TextEditingController(text: widget.schoolPhone);
    _addressController = TextEditingController(text: widget.schoolAddress);
    _websiteController = TextEditingController(text: widget.schoolWebsite);
  }

  double _calculateCompletionPercentage() {
    int filledFields = 0;
    int totalFields = 5;

    if (_nameController.text.isNotEmpty) filledFields++;
    if (_emailController.text.isNotEmpty) filledFields++;
    if (_phoneController.text.isNotEmpty) filledFields++;
    if (_addressController.text.isNotEmpty) filledFields++;
    if (_websiteController.text.isNotEmpty) filledFields++;

    return (filledFields / totalFields) * 100;
  }

  @override
  Widget build(BuildContext context) {
    double completionPercentage = _calculateCompletionPercentage();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit School Profile',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 20)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.check_circle, color: Colors.white, size: 28),
            onPressed: () {
              Navigator.pop(context, {
                'schoolName': _nameController.text,
                'schoolEmail': _emailController.text,
                'schoolPhone': _phoneController.text,
                'schoolAddress': _addressController.text,
                'schoolWebsite': _websiteController.text,
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCompletionIndicator(completionPercentage),
            SizedBox(height: 20),
            _buildTextField('School Name', _nameController, Icons.school),
            _buildTextField('Email', _emailController, Icons.email),
            _buildTextField('Phone', _phoneController, Icons.phone),
            _buildTextField('Address', _addressController, Icons.location_on),
            _buildTextField('Website', _websiteController, Icons.language),
            SizedBox(height: 30),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletionIndicator(double completionPercentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Profile Completion',
            style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent)),
        SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: completionPercentage / 100,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            minHeight: 8,
          ),
        ),
        SizedBox(height: 8),
        Text('${completionPercentage.toStringAsFixed(0)}% completed',
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700])),
      ],
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(color: Colors.blueAccent),
          filled: true,
          fillColor: Colors.grey[100],
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context, {
            'schoolName': _nameController.text,
            'schoolEmail': _emailController.text,
            'schoolPhone': _phoneController.text,
            'schoolAddress': _addressController.text,
            'schoolWebsite': _websiteController.text,
          });
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text('Save Changes',
            style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
    );
  }
}
