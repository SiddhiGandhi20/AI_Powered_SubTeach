import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<String> filters = ['Urgent', 'Nearby', 'Saved'];
  Set<String> selectedFilters = {'Urgent'};

  final List<Map<String, dynamic>> notifications = [
    {
      'school': 'Lincoln High School',
      'description': 'Urgent: Math substitute for Mathematics class needed.',
      'date': 'Mon, Jan 8',
      'time': '8:00 AM - 3:10 PM',
      'distance': '5.8 miles away',
      'isUrgent': true,
      'isSaved': false,
    },
    {
      'school': 'Washington Elementary',
      'description': 'Emergency substitute needed for 3rd Grade class',
      'date': 'Today',
      'time': '11:30 AM - 3:00 PM',
      'distance': '2.3 miles away',
      'isUrgent': false,
      'isSaved': true,
    },
    {
      'school': 'Roosevelt Middle School',
      'description': 'Science teacher substitute needed for next week',
      'date': 'Mon, Fri',
      'time': '8:00 AM - 2:30 PM',
      'distance': '3.1 miles away',
      'isUrgent': false,
      'isSaved': false,
    },
    {
      'school': 'Jefferson Academy',
      'description': 'Looking for English Literature substitute',
      'date': 'Tomorrow, Fri',
      'time': '9:00 AM - 2:15 PM',
      'distance': '1.5 miles away',
      'isUrgent': false,
      'isSaved': false,
    },
    {
      'school': 'Madison High School',
      'description': 'Physical Education substitute position available',
      'date': 'Next Week',
      'time': '8:00 AM - 3:30 PM',
      'distance': '4.2 miles away',
      'isUrgent': false,
      'isSaved': true,
    },
  ];

  // Filter notifications based on selected filters
  // Filter notifications based on selected filters
  List<Map<String, dynamic>> getFilteredNotifications() {
    return notifications.where((notification) {
      // Apply filters only if selected
      bool matchesUrgent =
          selectedFilters.contains('Urgent') ? notification['isUrgent'] : true;
      bool matchesSaved =
          selectedFilters.contains('Saved') ? notification['isSaved'] : true;

      // Check for Nearby with distance less than 4 miles
      bool matchesNearby = selectedFilters.contains('Nearby')
          ? double.tryParse(notification['distance'].split(' ')[0])! < 4.0
          : true;

      // Default: show all notifications unless a filter is applied
      return matchesUrgent && matchesSaved && matchesNearby;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Aplication Notifications',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: ListView.builder(
              itemCount: getFilteredNotifications().length,
              itemBuilder: (context, index) {
                return _buildNotificationCard(
                    getFilteredNotifications()[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilters.contains(filter);
          return Padding(
            padding: EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Text(filter),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedFilters.add(filter);
                  } else {
                    selectedFilters.remove(filter);
                  }
                });
              },
              selectedColor: Colors.blue[100],
              checkmarkColor: Colors.blue,
              backgroundColor: Colors.white,
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Text(
                    notification['school'][0],
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification['school'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if (notification['isUrgent'])
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Urgent',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              notification['description'],
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text(
                  notification['date'],
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(width: 16),
                Icon(Icons.access_time, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text(
                  notification['time'],
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text(
                  notification['distance'],
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text('Accept'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text('Decline'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Dialog to show filter options
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Filters'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: filters.map((filter) {
              return CheckboxListTile(
                title: Text(filter),
                value: selectedFilters.contains(filter),
                onChanged: (bool? selected) {
                  setState(() {
                    if (selected!) {
                      selectedFilters.add(filter);
                    } else {
                      selectedFilters.remove(filter);
                    }
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
