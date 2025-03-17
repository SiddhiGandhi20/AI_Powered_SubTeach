import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/widgets/floating_chatbot_button.dart'; // Import the DraggableFloatingChatbotButton

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
  final TextEditingController _emergencyContactController = TextEditingController();
  bool isEmergencyPosting = false; // Switch state

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
      body: Stack(
        children: [
          SingleChildScrollView(
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

                    // Emergency Job Switch
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Emergency Job Posting',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              Switch(
                                value: isEmergencyPosting,
                                onChanged: (value) {
                                  setState(() {
                                    isEmergencyPosting = value;
                                  });
                                },
                                activeColor: Colors.red,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'When you turn this on, this ad will only be shown to teachers within 5 kilometers or teachers who can join within 5 to 24 hours',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isEmergencyPosting) ...[
                      _buildFormLabel('Emergency Contact Information *'),
                      TextFormField(
                        controller: _emergencyContactController,
                        decoration: _inputDecoration('Phone number or email')
                            .copyWith(
                                prefixIcon: const Icon(Icons.emergency_outlined)),
                        validator: (value) {
                          if (isEmergencyPosting &&
                              (value == null || value.isEmpty)) {
                            return 'Please provide emergency contact information';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                    ],

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
                      validator: (value) =>
                          value == null ? 'Please select a subject' : null,
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
                      validator: (value) =>
                          value == null ? 'Please select a grade level' : null,
                    ),
                    const SizedBox(height: 16),

                    // Date & Time Pickers
                    Row(
                      children: [
                        Expanded(
                          child: _buildDateField(),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTimeField(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    _buildFormLabel('Location *'),
                    TextFormField(
                      controller: _locationController,
                      decoration: _inputDecoration('School Name and Address')
                          .copyWith(
                              prefixIcon: const Icon(Icons.location_on_outlined)),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter a location'
                          : null,
                    ),
                    const SizedBox(height: 16),

                    _buildFormLabel('Pay Rate *'),
                    TextFormField(
                      controller: _payRateController,
                      decoration: _inputDecoration('e.g., ₹1000-1500/hour')
                          .copyWith(prefixIcon: const Icon(Icons.currency_rupee)),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter a pay rate'
                          : null,
                    ),
                    const SizedBox(height: 16),

                    _buildFormLabel('Description *'),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: _inputDecoration(
                          'Describe the position requirements and responsibilities'),
                      maxLines: 4,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please provide a description'
                          : null,
                    ),
                    const SizedBox(height: 24),

                    // Post Job Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Add form validation for date and time
                            if (selectedDate == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please select a date')),
                              );
                              return;
                            }
                            if (selectedTime == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please select a time')),
                              );
                              return;
                            }

                            // If all validations pass
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Job posted successfully!')),
                            );
                            // Here you would typically send data to your backend
                            Navigator.pop(context); // Close the screen after posting
                          }
                        },
                        icon: const Icon(Icons.post_add),
                        label: const Text(
                          'Post Job',
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          // Draggable floating chatbot button
          DraggableFloatingChatbotButton(),
        ],
      ),
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFormLabel('Date *'),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: InputDecorator(
            decoration: _inputDecoration('Select Date'),
            child: Text(
              selectedDate != null
                  ? DateFormat.yMMMMd().format(selectedDate!)
                  : 'Select Date',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  Widget _buildTimeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFormLabel('Time *'),
        GestureDetector(
          onTap: () => _selectTime(context),
          child: InputDecorator(
            decoration: _inputDecoration('hh:mm AM/PM'),
            child: Text(
              selectedTime != null
                  ? selectedTime!.format(context)
                  : 'Select time',
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Widget _buildFormLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }
}
