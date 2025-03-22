import 'package:flutter/material.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms of Service', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms of Service',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue[800]),
            ),
            SizedBox(height: 8),
            Text(
              'Last Updated: March 19, 2025',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            _buildTermsSection(
              title: '1. Acceptance of Terms',
              content: 'By accessing or using the Substitute Teacher Application (the "App"), you agree to comply with and be bound by these Terms and Conditions. If you do not agree to these terms, please do not use the App.',
            ),
            _buildTermsSection(
              title: '2. Use of the Application',
              content: 'You may use the App only for lawful purposes and in accordance with these Terms and Conditions. You agree not to use the App:\n'
                  '- For any unlawful purpose.\n'
                  '- To send, knowingly receive, upload, download, use, or re-use any material which does not comply with our content standards.\n'
                  '- To transmit, or procure the sending of, any advertising or promotional material without our prior written consent.',
            ),
            _buildTermsSection(
              title: '3. AI-Powered Match System',
              content: 'The App uses AI to match schools with suitable substitute teachers based on skills, experience, and proximity. While we strive for accuracy, we do not guarantee the availability or suitability of matches.',
            ),
            _buildTermsSection(
              title: '4. Smart Scheduling',
              content: 'The App may use AI to predict teacher absences and suggest substitutes in advance. These predictions are estimates and not guarantees of actual events.',
            ),
            _buildTermsSection(
              title: '5. Automated Verification System',
              content: 'The App uses AI to verify teachers\' qualifications, background checks, and certifications. You consent to the use of your personal information for this purpose.',
            ),
            _buildTermsSection(
              title: '6. Payment Integration',
              content: 'The App includes a payment system for automatic payments to teachers. You authorize us to process payments on your behalf. We are not responsible for any errors or delays in payments.',
            ),
            _buildTermsSection(
              title: '7. Feedback and Rating System',
              content: 'You may rate and review schools and teachers through the App. We use this feedback to improve our matching algorithms. All reviews must be honest and respectful.',
            ),
            _buildTermsSection(
              title: '8. Data Analytics',
              content: 'The App provides schools with insights into teacher attendance trends, substitute demand, and costs. This data is used to improve the efficiency and effectiveness of the App.',
            ),
            _buildTermsSection(
              title: '9. Limitation of Liability',
              content: 'To the extent permitted by law, we exclude all conditions, warranties, representations, or other terms which may apply to the App or any content on it, whether express or implied.',
            ),
            _buildTermsSection(
              title: '10. Governing Law',
              content: 'These Terms and Conditions shall be governed and construed in accordance with the laws of [Your Country], without regard to its conflict of law provisions.',
            ),
            _buildTermsSection(
              title: '11. Contact Information',
              content: 'If you have any questions about these Terms and Conditions, please contact us at [Your Contact Information].',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsSection({required String title, required String content}) {
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
