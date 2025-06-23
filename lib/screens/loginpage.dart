import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniproject/screens/signuppage.dart';
import 'package:provider/provider.dart';

import '../utils/validator.dart';
import '../viewmodel/loginviewmodels.dart';
import 'forgetpassword.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void dispose() {
    Provider.of<LoginViewModel>(context, listen: false).disposeControllers();
    super.dispose();
  }

  void _login(LoginViewModel loginVM) async {
    if (loginVM.formKey.currentState!.validate()) {
      final result = await loginVM.login();

      if (result['success']) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomepageView()),
        );
      } else {
        _showErrorDialog(result['error'] ?? 'Login failed');
      }
    }
  }


  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Login Failed"),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginVM = Provider.of<LoginViewModel>(context);

    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildForm(loginVM),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        Positioned(top: -80, left: -100, child: _circle(Colors.blue)),
        Positioned(bottom: -80, right: -100, child: _circle(Colors.greenAccent)),
      ],
    );
  }

  Widget _circle(Color color) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(200),
      ),
    );
  }

  Widget _buildForm(LoginViewModel loginVM) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Form(
          key: loginVM.formKey,
          child: Column(
            children: [
              const Text('ZiyaAttend', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("Login", style: TextStyle(fontSize: 18, color: Colors.greenAccent)),
              const SizedBox(height: 16),
              TextFormField(
                controller: loginVM.emailController,
                decoration: _inputDecoration("Email"),
                keyboardType: TextInputType.emailAddress,
                validator: Validators.validateEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: loginVM.passwordController,
                obscureText: true,
                decoration: _inputDecoration("Enter a Password"),
                validator: Validators.validatePassword,
              ),
              const SizedBox(height: 24),
              _buildLoginButton(loginVM),
              const SizedBox(height: 8),
              _buildBottomRow(),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _buildLoginButton(LoginViewModel loginVM) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () => _login(loginVM),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: loginVM.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text("Login", style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }

  Widget _buildBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Forgetpassword())),
          child: const Text("Forgot Password?", style: TextStyle(color: Colors.black87)),
        ),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Signuppage())),
          child: const Text(
            "Signup",
            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
