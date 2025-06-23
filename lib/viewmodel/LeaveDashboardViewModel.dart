import 'package:flutter/material.dart';

class LeaveDashboardViewModel extends ChangeNotifier {
  int totalLeaves = 16;
  int approvalRate = 92;
  int pendingRequests = 1;
  int teamOnLeave = 2;

  void fetchLeaveData() {
    // Ideally: Fetch from API
    notifyListeners();
  }
}
