// lib/core/constants/api_constants.dart
//
// Central place for backend connection details. When we later build for
// real Android devices/emulators, 'localhost' won't reach your computer —
// we'll switch this per-platform then. For Web and Linux Desktop (what
// we're testing with now), localhost works exactly as expected.

class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'http://localhost:4000/api/v1';
  static const String socketUrl = 'http://localhost:4000';
}
