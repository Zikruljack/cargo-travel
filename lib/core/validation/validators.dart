import '../constants/app_constants.dart';

class ValidationResult {
  final bool isValid;
  final String? error;

  const ValidationResult.valid() : isValid = true, error = null;
  const ValidationResult.invalid(this.error) : isValid = false;
}

class Validators {
  // Email validation
  static ValidationResult validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return const ValidationResult.invalid('Email is required');
    }

    if (!RegExp(AppConstants.emailPattern).hasMatch(email)) {
      return const ValidationResult.invalid(
        'Please enter a valid email address',
      );
    }

    return const ValidationResult.valid();
  }

  // Password validation
  static ValidationResult validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return const ValidationResult.invalid('Password is required');
    }

    if (password.length < AppConstants.minPasswordLength) {
      return ValidationResult.invalid(
        'Password must be at least ${AppConstants.minPasswordLength} characters',
      );
    }

    if (password.length > AppConstants.maxPasswordLength) {
      return ValidationResult.invalid(
        'Password must not exceed ${AppConstants.maxPasswordLength} characters',
      );
    }

    if (!RegExp(AppConstants.passwordPattern).hasMatch(password)) {
      return const ValidationResult.invalid(
        'Password must contain uppercase, lowercase, number, and special character',
      );
    }

    return const ValidationResult.valid();
  }

  // Phone number validation
  static ValidationResult validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return const ValidationResult.invalid('Phone number is required');
    }

    if (!RegExp(AppConstants.phonePattern).hasMatch(phone)) {
      return const ValidationResult.invalid(
        'Please enter a valid phone number',
      );
    }

    return const ValidationResult.valid();
  }

  // Required field validation
  static ValidationResult validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return ValidationResult.invalid('$fieldName is required');
    }

    return const ValidationResult.valid();
  }

  // Username validation
  static ValidationResult validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return const ValidationResult.invalid('Username is required');
    }

    if (username.length < AppConstants.minUsernameLength) {
      return ValidationResult.invalid(
        'Username must be at least ${AppConstants.minUsernameLength} characters',
      );
    }

    if (username.length > AppConstants.maxUsernameLength) {
      return ValidationResult.invalid(
        'Username must not exceed ${AppConstants.maxUsernameLength} characters',
      );
    }

    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username)) {
      return const ValidationResult.invalid(
        'Username can only contain letters, numbers, and underscores',
      );
    }

    return const ValidationResult.valid();
  }

  // Confirm password validation
  static ValidationResult validateConfirmPassword(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return const ValidationResult.invalid('Please confirm your password');
    }

    if (password != confirmPassword) {
      return const ValidationResult.invalid('Passwords do not match');
    }

    return const ValidationResult.valid();
  }

  // Length validation
  static ValidationResult validateLength(
    String? value,
    int minLength,
    int maxLength,
    String fieldName,
  ) {
    if (value == null || value.isEmpty) {
      return ValidationResult.invalid('$fieldName is required');
    }

    if (value.length < minLength) {
      return ValidationResult.invalid(
        '$fieldName must be at least $minLength characters',
      );
    }

    if (value.length > maxLength) {
      return ValidationResult.invalid(
        '$fieldName must not exceed $maxLength characters',
      );
    }

    return const ValidationResult.valid();
  }

  // Numeric validation
  static ValidationResult validateNumeric(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return ValidationResult.invalid('$fieldName is required');
    }

    if (double.tryParse(value) == null) {
      return ValidationResult.invalid('$fieldName must be a valid number');
    }

    return const ValidationResult.valid();
  }

  // Positive number validation
  static ValidationResult validatePositiveNumber(
    String? value,
    String fieldName,
  ) {
    final numericResult = validateNumeric(value, fieldName);
    if (!numericResult.isValid) {
      return numericResult;
    }

    final number = double.parse(value!);
    if (number <= 0) {
      return ValidationResult.invalid('$fieldName must be greater than 0');
    }

    return const ValidationResult.valid();
  }
}
