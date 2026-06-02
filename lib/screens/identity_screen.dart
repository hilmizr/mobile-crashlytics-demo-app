import 'package:flutter/material.dart';
import '../services/crash_service.dart';

/// This screen is the "Classroom Management" tool.
class IdentityScreen extends StatefulWidget {
  const IdentityScreen({super.key});

  @override
  State<IdentityScreen> createState() => _IdentityScreenState();
}

class _IdentityScreenState extends State<IdentityScreen> {
  final _idController = TextEditingController();
  bool _collectionEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Who Am I')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your student ID:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                hintText: 'e.g., hilmi_2025',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_idController.text.isNotEmpty) {
                    // USER IDENTIFIER: How each student finds their own crash
                    // in a dashboard shared by 30 people.
                    await CrashService.setUser(_idController.text);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Identity saved: ${_idController.text}')),
                      );
                    }
                  }
                },
                child: const Text('Save Identity'),
              ),
            ),
            const Divider(height: 64),
            SwitchListTile(
              title: const Text('Crash reporting enabled'),
              subtitle: const Text('The recorder\'s on/off switch'),
              value: _collectionEnabled,
              onChanged: (val) async {
                setState(() => _collectionEnabled = val);
                // COLLECTION ENABLED: How to turn the recorder on/off dynamically.
                await CrashService.toggleCollection(val);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }
}
