import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> submitLeaveApplication({
    required String employeeName,
    required String employeeId,
    required DateTime fromDate,
    required DateTime toDate,
    required String leaveType,
    required String reason,
    String? attachment,
  }) async {
    await _firestore.collection('leaveApplications').add({
      'employeeName': employeeName,
      'employeeId': employeeId,
      'fromDate': fromDate.toIso8601String(),
      'toDate': toDate.toIso8601String(),
      'leaveType': leaveType,
      'reason': reason,
      'attachment': attachment,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
