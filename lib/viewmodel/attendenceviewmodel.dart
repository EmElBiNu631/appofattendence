import 'package:flutter/material.dart';

class AttendanceCalendarViewModel extends ChangeNotifier {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  final Map<DateTime, String> attendanceMap = {};

  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay = selected;
    focusedDay = focused;
    notifyListeners();
  }

  void markAttendance(DateTime date, String status) {
    attendanceMap[DateTime.utc(date.year, date.month, date.day)] = status;
    notifyListeners();
  }

  String? getAttendanceStatus(DateTime date) {
    return attendanceMap[DateTime.utc(date.year, date.month, date.day)];
  }
}
