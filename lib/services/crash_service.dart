import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// The "Remote Control" for Crashlytics.
/// Instead of writing Firebase code everywhere, we put it all in this one file.
/// Students: Open this file to see every tool Crashlytics gives you.
class CrashService {
  static final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  // FATAL: The "Pull the Fire Alarm" buttons.
  // Use these to verify that Crashlytics is actually connected.
  static void forceCrash() => _crashlytics.crash();

  static void throwUncaught() {
    throw Exception('Manual fatal error from the Lab');
  }

  // NON-FATAL
  // Use this for errors you catch with try/catch that you still want to know about.
  static void recordNonFatal(dynamic error, StackTrace stack) {
    _crashlytics.recordError(error, stack, fatal: false);
  }

  // CONTEXT: The "Breadcrumbs".
  // These don't crash the app. They add notes to the report so you can
  // understand what the user was doing *before* the crash happened.
  static void logBreadcrumb(String message) {
    _crashlytics.log(message);
  }

  static Future<void> setCustomKey(String key, dynamic value) async {
    await _crashlytics.setCustomKey(key, value);
  }

  // IDENTITY
  static Future<void> setUser(String id) async {
    await _crashlytics.setUserIdentifier(id);
  }

  // CONTROL
  // Use this to turn the recorder on or off dynamically.
  static Future<void> toggleCollection(bool enabled) async {
    await _crashlytics.setCrashlyticsCollectionEnabled(enabled);
  }
}
