import 'package:flutter/material.dart';
import '../services/crash_service.dart';
import '../widgets/lab_button.dart';

/// The Teaching Surface: A simple board of buttons.
/// Each button maps to exactly one Crashlytics concept.
class LabScreen extends StatelessWidget {
  const LabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crash Lab')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const _SectionHeader(title: 'FATAL (app dies)'),
          // The "classic" crash: pull the fire alarm to see if it works.
          LabButton(
            label: 'Force native crash (crash())',
            color: Colors.red.shade50,
            onPressed: () => CrashService.forceCrash(),
          ),
          // A Dart exception that isn't caught. The "nets" in main.dart will catch this.
          LabButton(
            label: 'Throw uncaught error',
            color: Colors.red.shade50,
            onPressed: () => CrashService.throwUncaught(),
          ),
          const SizedBox(height: 24),
          const _SectionHeader(title: 'NON-FATAL (app survives)'),
          // Use this for bugs that are annoying but don't kill the app.
          LabButton(
            label: 'Record handled error',
            color: Colors.orange.shade50,
            onPressed: () {
              try {
                throw StateError('This is a recoverable hiccup');
              } catch (e, s) {
                CrashService.recordNonFatal(e, s);
              }
            },
          ),
          const SizedBox(height: 24),
          const _SectionHeader(title: 'ADD CONTEXT'),
          // Breadcrumbs: trail of notes leading to the crash.
          LabButton(
            label: 'Log a breadcrumb',
            color: Colors.blue.shade50,
            onPressed: () => CrashService.logBreadcrumb('User tapped a breadcrumb button'),
          ),
          // Custom Key: like a sticky note attached to the report.
          LabButton(
            label: 'Set a custom key',
            color: Colors.blue.shade50,
            onPressed: () => CrashService.setCustomKey('last_lab_action', 'clicked_key_button'),
          ),
          const SizedBox(height: 32),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Teaching point: These buttons create "bare" reports. '
                'Go to the "Order" tab to see how to make reports useful.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
