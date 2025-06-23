import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/taskmodel.dart';

class DashboardViewModel extends ChangeNotifier {
  int sortOption = 0;
  String userName = 'Loading...';

  DashboardViewModel() {
    _fetchUserNameFromFirestore();
  }

  Future<void> _fetchUserNameFromFirestore() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
        if (doc.exists) {
          userName = doc.data()?['name'] ?? 'Users';
        } else {
          userName = 'Users';
        }
      } else {
        userName = 'Guest';
      }
    } catch (e) {
      userName = 'Error';
      print('Error fetching user name: $e');
    }

    notifyListeners();
  }
  void punchOutWithLocation(String location) {
    // You can also log this to Firebase if needed
    print("User punched out from: $location");

    isCheckedIn = false;
    notifyListeners();
  }

  void _loadUserName() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final doc = await FirebaseFirestore.instance.collection('Users').doc(currentUser.uid).get();
        if (doc.exists) {
          userName = doc.data()?['name'] ?? 'Users';
          notifyListeners();
        } else {
          userName = 'User';
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint('Error fetching user name from Firestore: $e');
    }
  }


  List<bool> taskTabs = [true, false, false];

  List<TaskModel> tasks = [
    TaskModel(
      title: 'UI/UX Design Implementation',
      description: '',
      project: 'Design Sprint',
      deadline: '12-06-2025',
      status: TaskStatus.notStarted,
      priority: TaskPriority.high,
      progress: 0.0,
      dueDate: DateTime(2025, 6, 12),
    ),
    TaskModel(
      title: 'Responsive Design',
      description: '',
      project: 'Frontend Revamp',
      deadline: '14-06-2025',
      status: TaskStatus.inProgress,
      priority: TaskPriority.medium,
      progress: 0.3,
      dueDate: DateTime(2025, 6, 14),
    ),
    TaskModel(
      title: 'Back-end Development',
      description: '',
      project: 'Backend APIs',
      deadline: '16-06-2025',
      status: TaskStatus.notStarted,
      priority: TaskPriority.low,
      progress: 0.0,
      dueDate: DateTime(2025, 6, 16),
    ),
    TaskModel(
      title: 'Server-Side Logic',
      description: '',
      project: 'API Integration',
      deadline: '18-06-2025',
      status: TaskStatus.completed,
      priority: TaskPriority.high,
      progress: 1.0,
      dueDate: DateTime(2025, 6, 18),
    ),
  ];

  List<TaskModel> get filteredTasks {
    List<TaskModel> filtered = List.from(tasks);

    if (taskTabs[0]) {
      filtered = filtered.where((t) => t.status != TaskStatus.completed).toList();
    } else if (taskTabs[2]) {
      filtered = filtered.where((t) => t.dueDate.isAfter(DateTime.now())).toList();
    }

    if (sortOption == 0) {
      filtered.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    } else {
      filtered.sort((a, b) => a.project.compareTo(b.project));
    }

    return filtered;
  }

  void setTaskTab(int index) {
    for (int i = 0; i < taskTabs.length; i++) {
      taskTabs[i] = i == index;
    }
    notifyListeners();
  }
  void setSortOption(int? value) {
    if (value != null && value != sortOption) {
      sortOption = value;
      notifyListeners();
    }
  }

  int currentTab = 3;
  void setTab(int index) {
    currentTab = index;
    notifyListeners();
  }

  bool isCheckedIn = true;

  void checkOut() {
    isCheckedIn = false;
    notifyListeners();
  }

  void punchIn() {
    isCheckedIn = true;
    notifyListeners();
  }

  void punchOut() {
    isCheckedIn = false;
    notifyListeners();
  }
}
