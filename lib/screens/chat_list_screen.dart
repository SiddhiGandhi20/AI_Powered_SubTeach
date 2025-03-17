import 'package:flutter/material.dart';
import 'chat_detail_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Chats',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.grey.shade700),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 11, // 10 user chats + 1 chatbot
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          if (index == 0) return _buildChatbotItem(context);
          return _buildChatItem(context, index - 1);
        },
      ),
    );
  }

  Widget _buildChatbotItem(BuildContext context) {
    return _chatTile(
      title: 'Chatbot By aniket',
      subtitle: 'try it its fully working',
      isOnline: true,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const ChatDetailScreen(chatIndex: 0, isChatbot: true),
          ),
        );
      },
    );
  }

  Widget _buildChatItem(BuildContext context, int index) {
    return _chatTile(
      title: 'Chat ${index + 1}',
      subtitle: 'Last message preview...',
      isOnline: index % 2 == 0,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailScreen(chatIndex: index),
          ),
        );
      },
    );
  }

  Widget _chatTile({
    required String title,
    required String subtitle,
    required bool isOnline,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.deepPurple.shade100,
              child: Icon(
                title == 'Chatbot' ? Icons.smart_toy : Icons.person,
                color: Colors.white,
                size: 30,
              ),
            ),
            if (isOnline)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
        title: Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
        onTap: onTap,
      ),
    );
  }
}
