/// Pure, synchronous input validation rules.
///
/// Validators live in the core layer because they are shared by the UI
/// (Form validators) and by the presentation controllers. They never touch
/// Flutter widgets, which keeps them trivially unit-testable.
abstract final class Validators {
  static final RegExp _email = RegExp(
    r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
  );
  static final RegExp _phone = RegExp(r'^[6-9]\d{9}$');
  static final RegExp _otp = RegExp(r'^\d{6}$');
  static final RegExp _name = RegExp(r"^[A-Za-z][A-Za-z\s.'-]{1,48}$");

  static String? email(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Please enter your email';
    if (!_email.hasMatch(v)) return 'Enter a valid email address';
    return null;
  }

  static String? phone(String? value) {
    var digits = (value ?? '').replaceAll(RegExp(r'\D'), '');
    // Accept common prefixes: +91 / 91 and a leading trunk 0.
    if (digits.length == 12 && digits.startsWith('91')) {
      digits = digits.substring(2);
    } else if (digits.length == 11 && digits.startsWith('0')) {
      digits = digits.substring(1);
    }
    if (digits.isEmpty) return 'Please enter your mobile number';
    if (!_phone.hasMatch(digits)) return 'Enter a valid 10-digit mobile number';
    return null;
  }

  static String? password(String? value) {
    final v = value ?? '';
    if (v.isEmpty) return 'Please enter a password';
    if (v.length < 6) return 'Password must be at least 6 characters';
    if (!v.contains(RegExp(r'[A-Za-z]')) || !v.contains(RegExp(r'\d'))) {
      return 'Use at least one letter and one number';
    }
    return null;
  }

  static String? name(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'This field is required';
    if (!_name.hasMatch(v)) return 'Enter a valid name (letters only)';
    return null;
  }

  static String? otp(String? value) {
    final v = value?.trim() ?? '';
    if (!_otp.hasMatch(v)) return 'Enter the 6-digit code';
    return null;
  }

  static String? required(String? value, {String label = 'This field'}) {
    if (value == null || value.trim().isEmpty) return '$label is required';
    return null;
  }
}
