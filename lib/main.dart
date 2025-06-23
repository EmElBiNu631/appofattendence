import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniproject/screens/homepage.dart';
import 'package:miniproject/screens/signuppage.dart';
import 'package:miniproject/viewmodel/ProfilepageModel.dart';
import 'package:miniproject/viewmodel/forgetviewmodel.dart';
import 'package:miniproject/viewmodel/homepageviewmodels.dart';
import 'package:miniproject/viewmodel/leaveviewmodel.dart';
import 'package:miniproject/viewmodel/loginviewmodels.dart';
import 'package:miniproject/viewmodel/signupviewmodels.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var userName;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignupViewModel()),
        ChangeNotifierProvider(create: (_) => ForgetPasswordViewModel()),
        ChangeNotifierProvider(create: (_) => HomepageViewModel()),
        ChangeNotifierProvider(create: (_) => DashboardViewModel()),
        ChangeNotifierProvider(create: (_) => LeaveFormViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home:  Signuppage(),
    );
  }
}
