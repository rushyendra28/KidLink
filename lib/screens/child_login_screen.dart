import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'child_dashboard.dart';

class ChildLoginScreen extends StatefulWidget {
  const ChildLoginScreen({super.key});

  @override
  State<ChildLoginScreen> createState() => _ChildLoginScreenState();
}

class _ChildLoginScreenState extends State<ChildLoginScreen> {
  final _nameController = TextEditingController();
  String _generatedCode = '';

  void _generateCode() {
    setState(() {
      _generatedCode = '123456'; // Placeholder code
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Child Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Your Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateCode,
              child: const Text('Generate QR Code'),
            ),
            if (_generatedCode.isNotEmpty) ...[
              const SizedBox(height: 20),
              QrImageView(
                data: _generatedCode,
                version: QrVersions.auto,
                size: 200.0,
              ),
              const SizedBox(height: 10),
              Text(
                'Scan this QR code from parent\'s device',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChildDashboard(),
                    ),
                  );
                },
                icon: const Icon(Icons.dashboard),
                label: const Text('Go to Dashboard'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
