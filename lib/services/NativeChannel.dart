import 'package:flutter/services.dart';

class NativeChannel {
  static const platform = MethodChannel('com.example.assignment2/navigation');

  static Future<void> openProfile() async {
    try {
      await platform.invokeMethod('openProfile');
    } catch (e) {
      print("Error: $e");
    }
  }

  static Future<void> openCalendar() async {
    try {
      await platform.invokeMethod('calendar');
    } catch (e) {
      print("Error: $e");
    }
  }
}