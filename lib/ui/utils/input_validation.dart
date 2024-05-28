enum UserNameValidateState { empty, valid }

enum PasswordValidateState { empty, short, valid }
enum TitleTodoValidateState { empty, short, valid }

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

  TitleTodoValidateState checkValidateTitleTodo(String? value) {
    if (value == null || value.isEmpty) {
      return TitleTodoValidateState.empty;
    } else if (value.trim().length < 4) {
      return TitleTodoValidateState.short;
    }
    return TitleTodoValidateState.valid;
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