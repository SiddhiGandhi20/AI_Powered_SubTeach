import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final bool isSchool;

  const SignUpScreen({super.key, required this.isSchool});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isSchool ? 'School Sign Up' : 'Teacher Sign Up'),
      ),
      body: Center(
        child: Text('Sign up as ${isSchool ? "School" : "Teacher"}'),
      ),
    );
  }
} 