import 'package:flutter/material.dart';
import 'chat_detail_screen.dart';

class TeacherSchoolsMessages extends StatelessWidget {
  const TeacherSchoolsMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('School Messages',
            style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.blueGrey.shade800,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        itemCount: 5,
        separatorBuilder: (context, index) => const Divider(height: 16),
        itemBuilder: (context, index) {
          if (index == 0) return _buildChatbotItem(context);
          return _buildChatItem(context, index - 1);
        },
      ),
    );
  }

  Widget _buildChatbotItem(BuildContext context) {
    return _ChatTile(
      title: 'Assistant Bot',
      subtitle: 'Ask me anything about school matters',
      icon: Icons.memory,
      color: Colors.blue.shade600,
      isOnline: true,
      onTap: () => _navigateToChat(context, true, 0),
    );
  }

  Widget _buildChatItem(BuildContext context, int index) {
    final messages = [
      {'school': 'Riverside High', 'message': 'Meeting tomorrow at 10 AM'},
      {
        'school': 'Oak Valley Elementary',
        'message': 'Confirm student reports?'
      },
      {'school': 'Metropolitan Academy', 'message': 'New schedules available'},
      {'school': 'Greenwood Middle', 'message': 'Holiday next week!'},
    ];

    final colors = [
      Colors.green.shade600,
      Colors.orange.shade600,
      Colors.purple.shade600,
      Colors.teal.shade600,
    ];

    return _ChatTile(
      title: messages[index]['school']!,
      subtitle: messages[index]['message']!,
      icon: Icons.school_rounded,
      color: colors[index],
      isOnline: index.isEven,
      onTap: () => _navigateToChat(context, false, index + 1),
    );
  }

  void _navigateToChat(BuildContext context, bool isChatbot, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatDetailScreen(
          chatIndex: index,
          isChatbot: isChatbot,
        ),
      ),
    );
  }
}

class _ChatTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool isOnline;
  final VoidCallback onTap;

  const _ChatTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.isOnline,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: color, size: 26),
                  ),
                  if (isOnline)
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.green.shade400,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey.shade800,
                            )),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.blueGrey.shade600,
                            )),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded,
                  color: Colors.grey.shade400, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}
