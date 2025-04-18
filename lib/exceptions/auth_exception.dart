class AuthException implements Exception {
  static const Map<String, String> errorMessages = {
    'EMAIL_EXISTS': 'This email address is already in use.',
    'OPERATION_NOT_ALLOWED': 'Password sign-in is disabled for this project.',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Too many attempts. Try again later.',
    'EMAIL_NOT_FOUND': 'Email address not found.',
    'INVALID_PASSWORD': 'Invalid login credentials.',
    'INVALID_LOGIN_CREDENTIALS': 'Invalid login credentials.',
    'USER_DISABLED': 'User account has been disabled.',
  };
  final String key;
  AuthException(this.key);

  @override
  String toString() {
    if (errorMessages.containsKey(key)) {
      return errorMessages[key]!;
    }
    return 'An unknown error occurred.';
  }
}