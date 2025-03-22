import 'package:flutter/material.dart';

class ChildDashboard extends StatelessWidget {
  const ChildDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Implement settings
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Today\'s Screen Time',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: 0.7,
                      backgroundColor: Colors.grey[200],
                    ),
                    const SizedBox(height: 8),
                    const Text('4h 12m / 6h'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'App Usage',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.apps),
                    title: Text('App ${index + 1}'),
                    subtitle: Text('${index + 1}h 30m'),
                    trailing: CircularProgressIndicator(
                      value: (index + 1) / 5,
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
}
