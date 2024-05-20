enum UserNameValidateState { empty, valid }

enum PasswordValidateState { empty, short, valid }

class InputValidation {
  UserNameValidateState checkValidateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return UserNameValidateState.empty;
    }
    return UserNameValidateState.valid;
  }

  PasswordValidateState checkValidatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return PasswordValidateState.empty;
    } else if (value.trim().length <= 7) {
      return PasswordValidateState.short;
    }
    return PasswordValidateState.valid;
  }
}
