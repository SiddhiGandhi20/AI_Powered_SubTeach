import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue[800]),
            ),
            SizedBox(height: 8),
            Text(
              'Last Updated: March 19, 2025',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            _buildPolicySection(
              title: '1. Information We Collect',
              content: 'We collect information about you when you use the Substitute Teacher Application (the "App"). This includes:\n'
                  '- Information you provide directly to us, such as your name, email address, phone number, qualifications, and certifications.\n'
                  '- Information we collect automatically, such as your IP address, device information, location data, and usage data.',
            ),
            _buildPolicySection(
              title: '2. How We Use Your Information',
              content: 'We use the information we collect to:\n'
                  '- Provide and improve our services, including AI-powered matching, smart scheduling, and automated verification.\n'
                  '- Process payments and manage your account.\n'
                  '- Communicate with you about our services and promotions.\n'
                  '- Personalize your experience and provide insights and analytics to schools.\n'
                  '- Monitor and analyze trends and usage.',
            ),
            _buildPolicySection(
              title: '3. Information Sharing and Disclosure',
              content: 'We do not sell, trade, or otherwise transfer your personal information to outside parties without your consent, except:\n'
                  '- With trusted third parties who assist us in operating the App, conducting our business, or servicing you.\n'
                  '- When we believe release is appropriate to comply with the law, enforce our site policies, or protect ours or others’ rights, property, or safety.',
            ),
            _buildPolicySection(
              title: '4. Data Security',
              content: 'We implement a variety of security measures to maintain the safety of your personal information. However, no method of transmission over the internet or electronic storage is 100% secure.',
            ),
            _buildPolicySection(
              title: '5. AI and Automated Processing',
              content: 'The App uses AI for various functions, including matching, scheduling, and verification. We ensure that these processes are fair, transparent, and respect your rights.',
            ),
            _buildPolicySection(
              title: '6. Your Rights',
              content: 'You have the right to access, correct, or delete your personal information. You may also object to or restrict the processing of your data.',
            ),
            _buildPolicySection(
              title: '7. Changes to the Privacy Policy',
              content: 'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.',
            ),
            _buildPolicySection(
              title: '8. Contact Information',
              content: 'If you have any questions about this Privacy Policy, please contact us at [Your Contact Information].',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicySection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[800]),
        ),
        SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
