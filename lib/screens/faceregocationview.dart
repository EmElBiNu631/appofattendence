import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miniproject/constants/appcolor.dart';
import 'package:miniproject/screens/homepage.dart';
import 'package:miniproject/screens/profile.dart';
import 'package:miniproject/screens/punchedin%20sucess.dart';
import 'package:miniproject/screens/puchedout.dart';
import 'package:provider/provider.dart';
import '../viewmodel/ProfilepageModel.dart';

class FaceConfirmationView extends StatefulWidget {
  final bool isPunchingIn;
  final VoidCallback onConfirmed;

  const FaceConfirmationView({
    super.key,
    required this.isPunchingIn,
    required this.onConfirmed,
  });

  @override
  State<FaceConfirmationView> createState() => _FaceConfirmationViewState();
}

class _FaceConfirmationViewState extends State<FaceConfirmationView> {
  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<DashboardViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 280,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Color(0xFF71C6F7)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                const Spacer(),
                const Text(
                  "Center your face",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Point your face right at the box,\nthen take a photo",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.black54),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.cameraswitch, size: 28),
                        onPressed: () {
                          // TODO: implement camera switch
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: ElevatedButton(
                          onPressed: isProcessing
                              ? null
                              : () {
                            setState(() => isProcessing = true);

                            final now = DateTime.now();
                            final formattedTime =
                            DateFormat('hh:mm a').format(now);
                            final checkinMessage =
                                "Checked in at $formattedTime";
                            final checkoutMessage =
                                "Checked out at $formattedTime";

                            // Perform punch action
                            if (widget.isPunchingIn) {
                              vm.punchIn();
                            } else {
                              vm.punchOut();
                            }

                            // Decide which success screen to show
                            final Widget successScreen = widget.isPunchingIn
                                ? PunchInSuccessView(time: formattedTime)
                                : PunchedOutSuccessView(time: formattedTime);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => successScreen),
                            ).then((_) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DashboardView(
                                    checkinMessage: checkinMessage,
                                    checkoutMessage: checkoutMessage,
                                  ),
                                ),
                              );
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: AppColors.blue,
                            padding: const EdgeInsets.all(24),
                            elevation: 6,
                          ),
                          child: const Icon(Icons.check, color: AppColors.white, size: 36),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.flash_on, size: 28),
                        onPressed: () {
                          // TODO: toggle flash
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
