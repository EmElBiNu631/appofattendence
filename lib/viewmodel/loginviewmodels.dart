import 'package:flutter/material.dart';
import '../services/authservices.dart';

class LoginViewModel with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool isLoading = false;
  String error = '';

  Future<Map<String, dynamic>> login() async {
    isLoading = true;
    notifyListeners();

    final result = await _authService.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    isLoading = false;
    notifyListeners();

    return result;
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }
}
