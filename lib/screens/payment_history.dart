import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_application_1/screens/job_dashboard.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  String selectedPeriod = 'Week';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const JobDashboard()),
            );
          },
        ),
        title: const Text('Payment History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEarningsSection(),
              const SizedBox(height: 24),
              _buildBarChart(),
              const SizedBox(height: 24),
              _buildMetrics(),
              const SizedBox(height: 24),
              _buildRecentPayments(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEarningsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Total Earnings',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        const Text(
          '\$2,458.50',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildPeriodButton('Week'),
            _buildPeriodButton('Month'),
            _buildPeriodButton('Year'),
          ],
        ),
      ],
    );
  }

  Widget _buildPeriodButton(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedPeriod = text;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedPeriod == text ? Colors.blue : Colors.grey[200],
          foregroundColor: selectedPeriod == text ? Colors.white : Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildBarChart() {
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          barGroups: [
            _buildBarGroup(0, 40),
            _buildBarGroup(1, 60),
            _buildBarGroup(2, 30),
            _buildBarGroup(3, 80),
            _buildBarGroup(4, 50),
            _buildBarGroup(5, 35),
            _buildBarGroup(6, 45),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double height) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: height,
          color: Colors.blue,
          width: 20,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildMetrics() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildMetricItem(Icons.check_circle_outline, '24', 'Completed'),
        _buildMetricItem(Icons.star_outline, '4.9', 'Avg Rating'),
        _buildMetricItem(Icons.trending_up, '98%', 'Success Rate'),
      ],
    );
  }

  Widget _buildMetricItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentPayments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Payments',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildPaymentItem(
          'Alex Thompson',
          'Mathematics',
          '85.00',
          'Today, 2:30 PM',
        ),
        _buildPaymentItem(
          'Sarah Wilson',
          'Physics',
          '95.00',
          'Yesterday, 4:15 PM',
        ),
        _buildPaymentItem(
          'Michael Chen',
          'Chemistry',
          '75.00',
          'Jan 15, 2024',
        ),
      ],
    );
  }

  Widget _buildPaymentItem(
    String name,
    String subject,
    String amount,
    String time,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.blue[200],
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  subject,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$$amount',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Text(
                'Completed',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
