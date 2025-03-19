import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/ai_matches_Teacher.dart';
import 'package:flutter_application_1/screens/payment_overview.dart';
import 'package:flutter_application_1/screens/teacher_profile.dart';
import 'package:flutter_application_1/screens/teacher_Notification%20.dart';
// import 'package:flutter_application_1/screens/teacher_schools_messages.dart';
import 'login_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Teacher Name"),
            accountEmail: const Text("teacher@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.blue),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Payment"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PaymentOverviewScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.android), // AI or robot icon
            title: const Text("AI Matchers"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AiMatchesScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Notifications"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TeacherNotificationsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TeacherProfileScreen()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const LoginScreen()), // Navigate to the login page
              );
            },
          ),
        ],
      ),
    );
  }
}
