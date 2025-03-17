import 'package:flutter/material.dart';

class AiMatchesScreen extends StatefulWidget {
  const AiMatchesScreen({super.key});

  @override
  State<AiMatchesScreen> createState() => _AiMatchesScreenState();
}

class _AiMatchesScreenState extends State<AiMatchesScreen> {
  String selectedSubject = 'All';

  final List<String> subjects = ['All', 'Math', 'Science', 'English', 'Arts'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSubjectFilters(),
            Expanded(
              child: _buildMatchesList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'AI Matches',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '12 matches found',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectFilters() {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final subject = subjects[index];
          final isSelected = subject == selectedSubject;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Text(subject),
              onSelected: (selected) {
                setState(() {
                  selectedSubject = subject;
                });
              },
              backgroundColor: Colors.grey[200],
              selectedColor: Colors.blue.withOpacity(0.2),
              labelStyle: TextStyle(
                color: isSelected ? Colors.blue : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: isSelected
                    ? const BorderSide(color: Colors.blue)
                    : BorderSide.none,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMatchesList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        _buildMatchCard(
          'Sarah Anderson',
          4.8,
          ['Mathematics', 'Physics'],
          95,
          'Available',
          'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/Screenshot%202025-02-18%20124951-HrHQIWaVbbGvfbTv8NSvaFpWQ2PVWY.png',
        ),
        _buildMatchCard(
          'Michael Chen',
          4.9,
          ['Chemistry', 'Biology'],
          92,
          'Available',
          'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/Screenshot%202025-02-18%20124951-HrHQIWaVbbGvfbTv8NSvaFpWQ2PVWY.png',
        ),
        _buildMatchCard(
          'Emily Rodriguez',
          4.7,
          ['English', 'Literature', 'Writing'],
          88,
          'Busy',
          'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/Screenshot%202025-02-18%20124951-HrHQIWaVbbGvfbTv8NSvaFpWQ2PVWY.png',
        ),
        _buildMatchCard(
          'David Wilson',
          4.8,
          ['Art History', 'Drawing', 'Painting'],
          89,
          'Available',
          'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/Screenshot%202025-02-18%20124951-HrHQIWaVbbGvfbTv8NSvaFpWQ2PVWY.png',
        ),
      ],
    );
  }

  Widget _buildMatchCard(
    String name,
    double rating,
    List<String> subjects,
    int matchScore,
    String availability,
    String imageUrl,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: availability == 'Available'
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              availability,
                              style: TextStyle(
                                color: availability == 'Available'
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          ...List.generate(
                            5,
                            (index) => Icon(
                              index < rating.floor()
                                  ? Icons.star
                                  : index < rating
                                      ? Icons.star_half
                                      : Icons.star_outline,
                              size: 16,
                              color: Colors.amber,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            rating.toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: subjects.map((subject) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    subject,
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text(
                  'AI Match Score',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 45,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$matchScore%',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue),
                    ),
                    child: const Text('View Profile'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Hire'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
