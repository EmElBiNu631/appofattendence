import 'package:flutter/material.dart';
import 'homepage.dart';

class PunchedOutSuccessView extends StatefulWidget {
  final String time;

  const PunchedOutSuccessView({super.key, required this.time});

  @override
  State<PunchedOutSuccessView> createState() => _PunchedOutSuccessViewState();
}

class _PunchedOutSuccessViewState extends State<PunchedOutSuccessView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) =>  HomepageView()),
            (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.red],
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
                backgroundColor: Colors.red,
                child: Icon(Icons.check, size: 40, color: Colors.white),
              ),
              const SizedBox(height: 24),
              Text(
                'Punched Out Successfully at\n${widget.time}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
