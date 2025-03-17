import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/chatbot_service.dart';

class ChatDetailScreen extends StatefulWidget {
  final int chatIndex;
  final bool isChatbot;

  const ChatDetailScreen({super.key, required this.chatIndex, this.isChatbot = false});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isTyping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isChatbot ? 'Chatbot' : 'Chat ${widget.chatIndex + 1}',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) => _buildChatMessage(_messages[index]),
            ),
          ),
          if (_isTyping) _buildTypingIndicator(),
          _buildMessageInputField(),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 10),
      child: Row(
        children: [
          const CircleAvatar(radius: 14, child: Icon(Icons.android, size: 16, color: Colors.deepPurple)),
          const SizedBox(width: 8),
          const Text("Typing...", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildMessageInputField() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                fillColor: Colors.grey.shade100,
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _sendMessage,
            child: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              radius: 24,
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    if (_controller.text.trim().isNotEmpty) {
      final text = _controller.text.trim();
      final timestamp = DateTime.now().toIso8601String();

      setState(() {
        _messages.add({'sender': 'user', 'text': text, 'time': timestamp});
        _controller.clear();
      });

      if (widget.isChatbot) {
        setState(() => _isTyping = true);

        // Simulate chatbot response delay
        await Future.delayed(const Duration(seconds: 1));

        final response = await ChatbotService.sendMessage(text);
        setState(() {
          _messages.add({'sender': 'bot', 'text': response, 'time': DateTime.now().toIso8601String()});
          _isTyping = false;
        });
      }
    }
  }

  Widget _buildChatMessage(Map<String, String> message) {
    final isMe = message['sender'] == 'user';
    final messageTime = DateFormat('hh:mm a').format(DateTime.parse(message['time']!));

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Colors.deepPurple.shade50 : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isMe ? const Radius.circular(12) : const Radius.circular(0),
            bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(12),
          ),
          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message['text']!,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              messageTime,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
