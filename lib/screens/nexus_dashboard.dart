import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexus OS Dashboard',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  double systemStatus = 85;
  double cpuUsage = 42;
  double memoryUsage = 68;
  double networkStatus = 92;
  double securityLevel = 75;

  @override
  void initState() {
    super.initState();
    // Simulate dynamic data updates
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        cpuUsage = 45;
        memoryUsage = 70;
        networkStatus = 95;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nexus OS Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSystemOverview(),
            const SizedBox(height: 16),
            _buildMetricsGrid(),
            const SizedBox(height: 16),
            _buildSecurityAndAlerts(),
            const SizedBox(height: 16),
            _buildCommunicationLog(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.security),
            label: 'Security',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
        ],
      ),
    );
  }

  Widget _buildSystemOverview() {
    return Card(
      elevation: 4,
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'System Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildMetricCard('CPU Usage', '$cpuUsage%', Icons.memory, Colors.cyan),
                const SizedBox(width: 16),
                _buildMetricCard('Memory', '$memoryUsage%', Icons.storage, Colors.purple),
                const SizedBox(width: 16),
                _buildMetricCard('Network', '$networkStatus%', Icons.wifi, Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        color: Colors.grey[800],
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildProgressCard('System Status', systemStatus, Colors.cyan),
        _buildProgressCard('Security Level', securityLevel, Colors.green),
        _buildProgressCard('Network Status', networkStatus, Colors.blue),
        _buildProgressCard('Storage', 75, Colors.purple),
      ],
    );
  }

  Widget _buildProgressCard(String title, double value, Color color) {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: value / 100,
              backgroundColor: Colors.grey[800],
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              '${value.toStringAsFixed(0)}%',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityAndAlerts() {
    return Card(
      elevation: 4,
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Security & Alerts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildAlertItem('Security Scan Complete', 'No threats detected', Icons.check, Colors.green),
            _buildAlertItem('Bandwidth Spike', 'Unusual network activity', Icons.warning, Colors.amber),
            _buildAlertItem('System Update', 'Version 12.4.5 ready', Icons.update, Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertItem(String title, String description, IconData icon, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      subtitle: Text(description, style: const TextStyle(color: Colors.grey)),
    );
  }

  Widget _buildCommunicationLog() {
    return Card(
      elevation: 4,
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Communication Log',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildMessageItem('System Admin', 'Scheduled maintenance at 02:00'),
            _buildMessageItem('Security Module', 'Unusual login attempt blocked'),
            _buildMessageItem('Network Control', 'Bandwidth allocation adjusted'),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageItem(String sender, String message) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.cyan,
        child: Icon(Icons.person, color: Colors.white),
      ),
      title: Text(sender, style: const TextStyle(fontSize: 16)),
      subtitle: Text(message, style: const TextStyle(color: Colors.grey)),
    );
  }
}