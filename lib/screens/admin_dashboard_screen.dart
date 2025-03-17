import 'package:flutter/material.dart';
import 'admin_login_screen.dart'; // Import the AdminLoginScreen

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;

  List<String> teachers = [];
  List<String> students = [];
  List<String> jobs = [];

  bool _isLoading = false;

  // Simulated data fetching
  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      // Clear existing data
      if (_selectedIndex == 0) {
        teachers.clear();
      } else if (_selectedIndex == 1) {
        students.clear();
      } else if (_selectedIndex == 2) {
        jobs.clear();
      }
    });

    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Simulate fetched data
    List<String> fetchedData = [];
    switch (_selectedIndex) {
      case 0:
        fetchedData = ['Teacher 1', 'Teacher 2'];
        break;
      case 1:
        fetchedData = ['Student 1', 'Student 2'];
        break;
      case 2:
        fetchedData = ['Job 1', 'Job 2'];
        break;
      default:
        break;
    }

    setState(() {
      if (_selectedIndex == 0) {
        teachers = fetchedData;
      } else if (_selectedIndex == 1) {
        students = fetchedData;
      } else if (_selectedIndex == 2) {
        jobs = fetchedData;
      }
      _isLoading = false;
    });
  }

  void _showDeleteDialog(String item, List<String> items) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Confirmation', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('Are you sure you want to delete $item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  items.remove(item);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(String item, List<String> items) {
    final TextEditingController editController = TextEditingController(text: item);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Item', style: TextStyle(fontWeight: FontWeight.bold)),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(labelText: 'Item Name', border: OutlineInputBorder()),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  final index = items.indexOf(item);
                  if (index != -1) {
                    items[index] = editController.text;
                  }
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save', style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  void _showAddDialog(List<String> items) {
    final TextEditingController addController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Item', style: TextStyle(fontWeight: FontWeight.bold)),
          content: TextField(
            controller: addController,
            decoration: InputDecoration(
              labelText: 'Item Name',
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
              ),
              hintText: 'Enter item name',
              hintStyle: const TextStyle(color: Colors.grey),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                if (addController.text.isNotEmpty) {
                  setState(() {
                    items.add(addController.text);
                  });
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter an item name')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminLoginScreen()),
        );
        return false; // Prevent default back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Admin Dashboard',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blueAccent,
          elevation: 4,
        ),
        body: _buildBody(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Teachers'),
            BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Students'),
            BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Jobs'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: _buildListView(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _fetchData,
                    icon: const Icon(Icons.refresh, size: 24, color: Colors.white),
                    label: const Text(
                      'Fetch Data',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : () => _showAddDialog(_getCurrentItems()),
                    icon: const Icon(Icons.add, size: 24, color: Colors.white),
                    label: const Text(
                      'Add New',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getCurrentItems() {
    switch (_selectedIndex) {
      case 0:
        return teachers;
      case 1:
        return students;
      case 2:
        return jobs;
      default:
        return [];
    }
  }

  Widget _buildListView() {
    List<String> items = _getCurrentItems();
    String title = _getCurrentTitle();
    IconData icon = _getCurrentIcon();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.blueAccent, size: 32),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (_isLoading)
          const Center(child: CircularProgressIndicator())
        else
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text('No items found'))
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(items[index]),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _showEditDialog(items[index], items);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _showDeleteDialog(items[index], items);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
      ],
    );
  }

  String _getCurrentTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Teachers';
      case 1:
        return 'Students';
      case 2:
        return 'Jobs';
      default:
        return 'Dashboard';
    }
  }

  IconData _getCurrentIcon() {
    switch (_selectedIndex) {
      case 0:
        return Icons.person;
      case 1:
        return Icons.school;
      case 2:
        return Icons.work;
      default:
        return Icons.dashboard;
    }
  }
}
