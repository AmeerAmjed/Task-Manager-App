enum UserNameValidateState { empty, valid }

enum PasswordValidateState { empty, short, valid }

mixin class InputValidation {
  UserNameValidateState checkValidateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return UserNameValidateState.empty;
    }
    return UserNameValidateState.valid;
  }

  PasswordValidateState checkValidatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return PasswordValidateState.empty;
    } else if (value.trim().length < 7) {
      return PasswordValidateState.short;
    }
    return PasswordValidateState.valid;
  }
}

extension PasswordValidateStateExtension on PasswordValidateState {
  String? get message {
    switch (this) {
      case PasswordValidateState.empty:
        return "Password is required";
      case PasswordValidateState.short:
        return "Password must be at least 8 characters long";
      case PasswordValidateState.valid:
        return null;
    }
  }
}

extension UserNameValidateStateExtension on UserNameValidateState {
  String? get message {
    switch (this) {
      case UserNameValidateState.empty:
        return "Username is required";
      case UserNameValidateState.valid:
        return null;
    }
  }
}