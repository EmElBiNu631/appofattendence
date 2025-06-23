import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/faceverification.dart';
import '../screens/leaveapplicationview.dart';
import '../screens/puchedout.dart';

class HomepageViewModel extends ChangeNotifier {

  bool isCheckedIn = false;
  bool hasPunchedOut =false;
  String userName = "Emel Binu";
  String role = "Flutter Developer";
  String worklocation = "Location";

  int presence = 18;
  int absence = 2;
  int leaves = 1;
  DateTime? checkInTime;

  void toggleCheckIn(DateTime time) {
    isCheckedIn = true;
    checkInTime = time;
    presence++;
    notifyListeners();
  }
  void punchIn(){
    isCheckedIn = true;
    hasPunchedOut = false;
    checkInTime = DateTime.now();
    notifyListeners();
  }
  void punchOut() {
    isCheckedIn = false;
    hasPunchedOut = true;
    checkInTime = DateTime.now();
    notifyListeners();
  }

  // Future<void> handlePunchOut(BuildContext context) async {
  //   final confirmed = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (_) =>  FaceVerificationView()),
  //   );
  //
  //   if (confirmed == true) {
  //     punchOut();
  //
  //
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (_) =>  PunchedOutSuccessView(time: '',)),
  //     );
  //   }
  // }


  void punchInWithLocation(String location) {
    isCheckedIn = true;
    hasPunchedOut = false;
    checkInTime = DateTime.now();
    worklocation = location;
    notifyListeners();
  }
  Future<void> handlePunchOut(BuildContext context) async {
    final shouldPunchOut = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Confirm Punch Out"),
          content: const Text("Are you sure you want to punch out?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
              child: const Text("Punch Out"),
            ),
          ],
        );
      },
    );

    if (shouldPunchOut == true) {
      punchOut();

      // Navigate to success page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const PunchedOutSuccessView(time: '05:20 PM'), // optionally pass actual time
        ),
      );
    }
  }
  void navigateToLeaves(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LeaveFormView()),
    );
  }
}


