import 'validators.dart';

class FormValidator {
  final Map<String, ValidationResult> _validationResults = {};

  // Validate single field
  ValidationResult validateField(
    String fieldName,
    String? value,
    ValidationResult Function(String?) validator,
  ) {
    final result = validator(value);
    _validationResults[fieldName] = result;
    return result;
  }

  // Get validation result for a field
  ValidationResult? getFieldResult(String fieldName) {
    return _validationResults[fieldName];
  }

  // Get error message for a field
  String? getFieldError(String fieldName) {
    return _validationResults[fieldName]?.error;
  }

  // Check if a field is valid
  bool isFieldValid(String fieldName) {
    return _validationResults[fieldName]?.isValid ?? false;
  }

  // Check if all validated fields are valid
  bool get isFormValid {
    return _validationResults.values.every((result) => result.isValid);
  }

  // Get all field errors
  Map<String, String> get fieldErrors {
    final errors = <String, String>{};
    _validationResults.forEach((field, result) {
      if (!result.isValid && result.error != null) {
        errors[field] = result.error!;
      }
    });
    return errors;
  }

  // Clear validation results
  void clear() {
    _validationResults.clear();
  }

  // Clear validation result for a specific field
  void clearField(String fieldName) {
    _validationResults.remove(fieldName);
  }

  // Validate login form
  bool validateLoginForm(String? email, String? password) {
    validateField('email', email, Validators.validateEmail);
    validateField(
      'password',
      password,
      (value) => Validators.validateRequired(value, 'Password'),
    );
    return isFormValid;
  }

  // Validate registration form
  bool validateRegistrationForm({
    required String? email,
    required String? password,
    required String? confirmPassword,
    required String? username,
    String? phone,
  }) {
    validateField('email', email, Validators.validateEmail);
    validateField('password', password, Validators.validatePassword);
    validateField(
      'confirmPassword',
      confirmPassword,
      (value) => Validators.validateConfirmPassword(password, value),
    );
    validateField('username', username, Validators.validateUsername);

    if (phone != null && phone.isNotEmpty) {
      validateField('phone', phone, Validators.validatePhone);
    }

    return isFormValid;
  }

  // Validate profile form
  bool validateProfileForm({required String? username, String? phone}) {
    validateField('username', username, Validators.validateUsername);

    if (phone != null && phone.isNotEmpty) {
      validateField('phone', phone, Validators.validatePhone);
    }

    return isFormValid;
  }

  // Validate change password form
  bool validateChangePasswordForm({
    required String? currentPassword,
    required String? newPassword,
    required String? confirmNewPassword,
  }) {
    validateField(
      'currentPassword',
      currentPassword,
      (value) => Validators.validateRequired(value, 'Current password'),
    );
    validateField('newPassword', newPassword, Validators.validatePassword);
    validateField(
      'confirmNewPassword',
      confirmNewPassword,
      (value) => Validators.validateConfirmPassword(newPassword, value),
    );

    return isFormValid;
  }
}
