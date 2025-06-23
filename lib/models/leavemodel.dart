class LeaveApplication {
  final String employeeName;
  final String employeeId;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String leaveType;
  final String reason;
  final String? attachmentPath;

  LeaveApplication({
    required this.employeeName,
    required this.employeeId,
    this.fromDate,
    this.toDate,
    required this.leaveType,
    required this.reason,
    this.attachmentPath,
  });
}
