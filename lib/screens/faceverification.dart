import 'package:flutter/material.dart';
import 'package:miniproject/screens/faceregocationview.dart';

class FaceVerificationView extends StatelessWidget {
  final bool isPunchingIn;
  final VoidCallback? onVerified;
  const FaceVerificationView({super.key,  this.onVerified, required this.isPunchingIn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(
                  "Face Verification",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                 SizedBox(height: 8),
                 Text(
                  "Please capture your face",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                 SizedBox(height: 40),
                Image.asset(
                  'assets/images/face_icon.png',
                  height: 120,
                ),
                 SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final checkInTime = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => FaceConfirmationView(isPunchingIn: true, onConfirmed: () {  },)),
                      );

                      if (checkInTime != null) {
                        Navigator.pop(context, checkInTime); // send time back to home page
                      }
                    },
                    child:Text("Take Photo")
                  ),

                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
