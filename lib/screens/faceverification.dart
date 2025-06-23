import 'package:flutter/material.dart';
import 'package:miniproject/screens/faceregocationview.dart';

class FaceVerificationView extends StatelessWidget {
  final bool isPunchingIn;
  final VoidCallback? onVerified;

  const FaceVerificationView({
    super.key,
    required this.isPunchingIn,
    this.onVerified,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Face Verification",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Please capture your face",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 40),
                Image.asset(
                  'assets/images/face_icon.png',
                  height: 120,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final checkInTime = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FaceConfirmationView(
                            isPunchingIn: isPunchingIn,
                            onConfirmed: () {},
                          ),
                        ),
                      );

                      if (checkInTime != null) {
                        Navigator.pop(context, checkInTime);
                      }
                    },
                    child: const Text("Take Photo"),
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
