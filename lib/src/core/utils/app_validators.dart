class AppValidators {
  static String? Function(String?)? get usernameOrEmail => (value) {
        if (value!.isEmpty) {
          return 'Fill empty fields';
        } else if (value.contains('@') && !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
          return 'Invalid email format';
        }
        return null;
      };

  static String? Function(String?)? get password => (password) {
        if (password!.isEmpty) {
          return 'Fill empty fields';
        } else if (password.length < 8) {
          return 'Password should contain at least 8 symbols';
        } else if (password.length > 16) {
          return 'Password should contain at most 16 symbols';
        }
        return null;
      };

  static String? Function(String?)? get email => (email) {
        if (email!.isEmpty) {
          return 'Fill empty fields';
        } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
          return 'Invalid email format';
        }
        return null;
      };

  static String? Function(String?)? get name => (value) {
        if (value!.isEmpty) {
          return 'Fill empty fields';
        } else if (value.length < 3) {
          return 'field should contain at least 3 symbols';
        }
        return null;
      };
}
