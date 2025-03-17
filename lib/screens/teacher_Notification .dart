import 'package:flutter/material.dart';

class TeacherNotificationsPage extends StatelessWidget {
  const TeacherNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample notifications
    final List<Map<String, String>> notifications = [
      {
        'title': 'Meeting Reminder',
        'message': 'Staff meeting scheduled at 10 AM tomorrow.',
        'time': '2h ago',
        'icon': 'notifications'
      },
      {
        'title': 'New Student Report',
        'message': 'New attendance reports are available for review.',
        'time': '5h ago',
        'icon': 'description'
      },
      {
        'title': 'Holiday Announcement',
        'message': 'School will be closed next Monday.',
        'time': 'Yesterday',
        'icon': 'event'
      },
      {
        'title': 'Schedule Update',
        'message': 'Updated teaching schedule for next semester is out.',
        'time': '2 days ago',
        'icon': 'schedule'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(
                _getNotificationIcon(notification['icon']!),
                color: Colors.blue,
                size: 30,
              ),
              title: Text(
                notification['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(notification['message']!),
              trailing: Text(
                notification['time']!,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              onTap: () {
                // Handle tap if needed (e.g., navigate to details)
              },
            ),
          );
        },
      ),
    );
  }

  // Function to get appropriate icon for each notification type
  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'notifications':
        return Icons.notifications;
      case 'description':
        return Icons.description;
      case 'event':
        return Icons.event;
      case 'schedule':
        return Icons.schedule;
      default:
        return Icons.notifications_none;
    }
  }
}
