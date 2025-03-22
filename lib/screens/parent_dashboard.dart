import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'parent_profile_screen.dart';

class ParentDashboard extends StatefulWidget {
  const ParentDashboard({super.key});

  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  // Placeholder list of children - replace with actual data later
  List<int> children = [0, 1];

  void _deleteChild(int index) {
    setState(() {
      children.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parent Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddChildDialog(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ParentProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Children',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: children.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ExpansionTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text('Child ${children[index] + 1}'),
                      subtitle: const Text('4h 12m screen time today'),
                      children: [
                        ListTile(
                          title: const Text('Daily Limit'),
                          trailing: SizedBox(
                            width: 120,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('6h'),
                                Expanded(
                                  child: IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      // TODO: Implement edit limit
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const ListTile(
                          title: Text('Most Used Apps'),
                          subtitle: Text('YouTube (2h), Games (1h)'),
                        ),
                        ButtonBar(
                          children: [
                            TextButton(
                              onPressed: () {
                                // TODO: View detailed stats
                              },
                              child: const Text('View Details'),
                            ),
                            TextButton(
                              onPressed: () {
                                // TODO: Manage restrictions
                              },
                              child: const Text('Manage Restrictions'),
                            ),
                            TextButton(
                              onPressed: () {
                                _showDeleteConfirmation(context, index);
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                              child: const Text('Remove Child'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddChildDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Child'),
        content: SizedBox(
          height: 300,
          width: 300,
          child: MobileScanner(
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                final code = barcode.rawValue;
                if (code != null) {
                  Navigator.pop(context);
                  _linkChild(code);
                }
              }
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _linkChild(String code) async {
    try {
      // For now, just add a new child to the list
      setState(() {
        children.add(children.length);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Child added successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add child: $e')),
      );
    }
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Child'),
        content: Text('Are you sure you want to remove Child ${children[index] + 1} from your dashboard?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteChild(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Child ${children[index] + 1} removed'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
