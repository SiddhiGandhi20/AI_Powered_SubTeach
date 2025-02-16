import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostTeachingPosition extends StatefulWidget {
  const PostTeachingPosition({super.key});

  @override
  State<PostTeachingPosition> createState() => _PostTeachingPositionState();
}

class _PostTeachingPositionState extends State<PostTeachingPosition> {
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedSubject;
  String? selectedGradeLevel;
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _payRateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool showPreview = false; // Initially hidden

  final List<String> subjects = ['Mathematics', 'English', 'Science'];
  final List<String> gradeLevels = [
    'Elementary',
    'Middle School',
    'High School'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Post Teaching Position'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Create a new job posting',
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 24),

                // Subject Dropdown
                _buildFormLabel('Subject *'),
                DropdownButtonFormField<String>(
                  value: selectedSubject,
                  decoration: _inputDecoration('Select subject'),
                  items: subjects.map((String subject) {
                    return DropdownMenuItem(
                      value: subject,
                      child: Text(subject),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedSubject = value;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Grade Level Dropdown
                _buildFormLabel('Grade Level *'),
                DropdownButtonFormField<String>(
                  value: selectedGradeLevel,
                  decoration: _inputDecoration('Select grade level'),
                  items: gradeLevels.map((String level) {
                    return DropdownMenuItem(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedGradeLevel = value;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Date & Time Pickers
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFormLabel('Date *'),
                          InkWell(
                            onTap: () => _selectDate(context),
                            child: InputDecorator(
                              decoration: _inputDecoration('mm/dd/yyyy'),
                              child: Text(
                                selectedDate != null
                                    ? DateFormat('MM/dd/yyyy')
                                        .format(selectedDate!)
                                    : 'Select date',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFormLabel('Time *'),
                          InkWell(
                            onTap: () => _selectTime(context),
                            child: InputDecorator(
                              decoration: _inputDecoration('--:--'),
                              child: Text(
                                selectedTime != null
                                    ? selectedTime!.format(context)
                                    : 'Select time',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Location
                _buildFormLabel('Location *'),
                TextFormField(
                  controller: _locationController,
                  decoration: _inputDecoration('School Name and Address')
                      .copyWith(
                          prefixIcon: const Icon(Icons.location_on_outlined)),
                ),
                const SizedBox(height: 16),

                // Pay Rate
                _buildFormLabel('Pay Rate *'),
                TextFormField(
                  controller: _payRateController,
                  decoration: _inputDecoration('e.g., \$25-30/hour')
                      .copyWith(prefixIcon: const Icon(Icons.attach_money)),
                ),
                const SizedBox(height: 16),

                // Description
                _buildFormLabel('Description *'),
                TextFormField(
                  controller: _descriptionController,
                  decoration: _inputDecoration(
                      'Describe the position requirements and responsibilities'),
                  maxLines: 4,
                ),
                const SizedBox(height: 24),

                // Preview Posting Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showPreview = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Preview Posting'),
                  ),
                ),

                // Preview Section (Visible only when preview button is clicked)
                if (showPreview) ...[
                  const SizedBox(height: 24),
                  _buildPreviewSection(),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement post job logic
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Post Job'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Widget _buildPreviewSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Preview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    showPreview = false;
                  });
                },
                child: const Text('Edit'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(selectedSubject ?? 'Subject'),
          Text(selectedGradeLevel ?? 'Grade Level'),
          Text(selectedDate != null
              ? DateFormat('MMM dd, yyyy').format(selectedDate!)
              : 'Date'),
          Text(selectedTime != null ? selectedTime!.format(context) : 'Time'),
          Text(_locationController.text),
          Text(_payRateController.text),
          const SizedBox(height: 8),
          Text(_descriptionController.text),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => selectedTime = picked);
  }
}
