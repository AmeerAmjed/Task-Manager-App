enum UserNameValidateState { empty, valid }


class InputValidation {
  UserNameValidateState checkValidateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return UserNameValidateState.empty;
    }
    return UserNameValidateState.valid;
  }

}
