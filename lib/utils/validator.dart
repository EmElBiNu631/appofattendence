class Validators {
  static String? validateName(String? value) =>
      value == null || value.isEmpty ? 'Please enter your name' : null;

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  static String? validateMobile(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your mobile number';
    if (!RegExp(r'^\d{10}$').hasMatch(value)) return 'Enter a valid 10-digit mobile number';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  static String? validateConfirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != original) return 'Passwords do not match';
    return null;
  }
}
