import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class LeaveFormViewModel extends ChangeNotifier {
  final nameController = TextEditingController(text: "Emel Binu"); // Autofill example
  final idController = TextEditingController(text: "EMP12345"); // Autofill example
  final reasonController = TextEditingController();

  DateTime? fromDate;
  DateTime? toDate;
  String leaveType = '';
  String? attachmentPath;

  void setFromDate(DateTime date) {
    fromDate = date;
    notifyListeners();
  }

  void setToDate(DateTime date) {
    toDate = date;
    notifyListeners();
  }

  void setLeaveType(String? type) {
    leaveType = type ?? '';
    notifyListeners();
  }

  Future<void> pickAttachment() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      attachmentPath = result.files.single.path;
      notifyListeners();
    }
  }

  void submitForm() {
    if (fromDate == null || toDate == null || leaveType.isEmpty || reasonController.text.trim().isEmpty) {
      debugPrint("Form not valid");
      return;
    }

    // Here you can push to Firebase or show a dialog
    debugPrint("Leave Submitted:\n"
        "Name: ${nameController.text}\n"
        "ID: ${idController.text}\n"
        "From: $fromDate\n"
        "To: $toDate\n"
        "Type: $leaveType\n"
        "Reason: ${reasonController.text}\n"
        "Attachment: $attachmentPath");
  }

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    reasonController.dispose();
    super.dispose();
  }
}
