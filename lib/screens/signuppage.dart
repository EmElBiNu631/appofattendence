import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/validator.dart';
import '../viewmodel/signupviewmodels.dart';
import 'loginpage.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  late SignupViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = SignupViewModel();
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    viewModel.nameController.dispose();
    viewModel.emailController.dispose();
    viewModel.mobileController.dispose();
    viewModel.passwordController.dispose();
    viewModel.confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        body: Stack(
          children: [
            _buildBackground(),
            _buildForm(context),
          ],
        ),
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

  Widget _buildForm(BuildContext context) {
    final viewModel = Provider.of<SignupViewModel>(context);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Form(
          key: viewModel.formKey,
          child: Column(
            children: [
              const Text('ZiyaAttend', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Create An Account', style: TextStyle(fontSize: 18, color: Colors.greenAccent)),
              const SizedBox(height: 32),
              _buildTextField(viewModel.nameController, 'Name', Validators.validateName),
              _buildTextField(viewModel.emailController, 'Email', Validators.validateEmail, inputType: TextInputType.emailAddress),
              _buildTextField(viewModel.mobileController, 'Mobile Number', Validators.validateMobile, inputType: TextInputType.phone),
              _buildTextField(viewModel.passwordController, 'Password', Validators.validatePassword, obscure: true),
              _buildTextField(
                viewModel.confirmPasswordController,
                'Confirm Password',
                    (value) => Validators.validateConfirmPassword(value, viewModel.passwordController.text),
                obscure: true,
              ),
              const SizedBox(height: 24),
              _buildSignupButton(context, viewModel),
              const SizedBox(height: 16),
              _buildLoginRedirect(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String hint,
      String? Function(String?) validator, {
        bool obscure = false,
        TextInputType inputType = TextInputType.text,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscure,
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildSignupButton(BuildContext context, SignupViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          if (viewModel.formKey.currentState!.validate()) {
            String? error = await viewModel.signUp(
              name: viewModel.nameController.text.trim(),
              email: viewModel.emailController.text.trim(),
              mobile: viewModel.mobileController.text.trim(),
              password: viewModel.passwordController.text.trim(),
              confirmPassword: viewModel.confirmPasswordController.text.trim(),
            );
            if (error == null) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signup successful')));
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text('Signup', style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }

  Widget _buildLoginRedirect(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account? "),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage())),
          child: const Text("Login", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
