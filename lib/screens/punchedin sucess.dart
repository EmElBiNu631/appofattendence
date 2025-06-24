import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miniproject/screens/profile.dart';
import 'package:provider/provider.dart';

import '../constants/appcolor.dart';
import '../viewmodel/ProfilepageModel.dart';

class PunchInSuccessView extends StatefulWidget {
  final String time;

  const PunchInSuccessView({super.key, required this.time});

  @override
  State<PunchInSuccessView> createState() => _PunchInSuccessViewState();
}

class _PunchInSuccessViewState extends State<PunchInSuccessView> {
  late String checkinMessage;
  late String checkoutMessage;

  @override
  void initState() {
    super.initState();

    final currentFormattedTime = DateFormat('hh:mm a').format(DateTime.now());
    checkinMessage = "Checked in at $currentFormattedTime";
    checkoutMessage = "Checked out at $currentFormattedTime";

    // Wait 2 seconds, then navigate to ProfilePageContent
    Future.delayed(const Duration(seconds: 2), () {
      final existingVm = Provider.of<DashboardViewModel>(context, listen: false);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: existingVm,
            child: DashboardView(
              checkinMessage: checkinMessage,
              checkoutMessage: checkoutMessage,
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.white, Color(0xFF98E66D)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.success,
                child: Icon(Icons.check, size: 40, color: AppColors.white),
              ),
              const SizedBox(height: 24),
              Text(
                'Punched In Successfully at\n${widget.time}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: AppColors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
