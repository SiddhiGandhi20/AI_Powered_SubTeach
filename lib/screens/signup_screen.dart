import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  final String? role;
  const SignUpScreen({super.key, this.role});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isSchool = true;
  bool isPasswordVisible = false;
  bool isLoading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isSchool = widget.role == 'school';
  }

  Future<void> _handleCreateAccount() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      _showMessage("Please fill all fields.");
      return;
    }

    setState(() => isLoading = true);
    final url = Uri.parse("http://192.168.164.152:5000/api/auth/signup");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "role": isSchool ? "school" : "teacher",
      }),
    );

    setState(() => isLoading = false);
    final responseData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      _showSuccessDialog();
    } else {
      _showMessage(responseData['message'] ?? "Signup failed.");
    }
  }

  void _showMessage(String message, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            "Success!",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, size: 64, color: Colors.green),
              const SizedBox(height: 16),
              const Text(
                "Your account has been created successfully!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()), // Navigate to LoginScreen
              );
            },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Continue", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              _buildIcon(),
              const SizedBox(height: 24),
              const Text('Create Account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Join our education platform today', style: TextStyle(color: Colors.grey, fontSize: 16)),
              const SizedBox(height: 24),
              _buildToggleSwitch(),
              const SizedBox(height: 24),
              _buildTextField(nameController, 'Full Name', 'Enter your full name'),
              const SizedBox(height: 16),
              _buildTextField(emailController, 'Email Address', 'Enter your email'),
              const SizedBox(height: 16),
              _buildPasswordField(),
              const SizedBox(height: 24),
              isLoading
                  ? const CircularProgressIndicator()
                  : _buildSignupButton(),
              const SizedBox(height: 16),
              _buildLoginText(),
              const SizedBox(height: 16),
              _buildTermsText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: const Icon(Icons.school, color: Colors.white, size: 32),
    );
  }

  Widget _buildToggleSwitch() {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          _buildToggleOption('School', Icons.school_outlined, true),
          _buildToggleOption('Teacher', Icons.person_outline, false),
        ],
      ),
    );
  }

  Widget _buildToggleOption(String text, IconData icon, bool value) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => isSchool = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSchool == value ? Colors.blue.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, color: isSchool == value ? Colors.blue : Colors.grey),
            const SizedBox(width: 8),
            Text(text, style: TextStyle(color: isSchool == value ? Colors.blue : Colors.grey, fontWeight: isSchool == value ? FontWeight.bold : FontWeight.normal)),
          ]),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: passwordController,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Create a password',
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        suffixIcon: IconButton(
          icon: Icon(isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey),
          onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
        ),
      ),
    );
  }

  Widget _buildSignupButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _handleCreateAccount,
        child: const Text('Create Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildLoginText() => GestureDetector(
    onTap: () => Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    ),
    child: const Text(
      'Already have an account? Log in',
      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
    ),
  );

  Widget _buildTermsText() => const Text('By signing up, you agree to our Terms and Privacy Policy', style: TextStyle(color: Colors.grey, fontSize: 12));
}
