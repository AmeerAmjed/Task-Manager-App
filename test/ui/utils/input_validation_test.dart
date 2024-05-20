import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/ui/utils/input_validation.dart';

void main() {
  late InputValidation inputValidation;

  setUp(() {
    inputValidation = InputValidation();
  });

  group('checkValidateUserName', () {
    test('should return UserNameValidateState.empty when username is null', () {
      var username = null;

      var result = inputValidation.checkValidateUserName(username);

      expect(result, UserNameValidateState.empty);
    });

    test('should return UserNameValidateState.empty when username is empty',
        () {
      var username = "";
      var result = inputValidation.checkValidateUserName(username);

      expect(result, UserNameValidateState.empty);
    });

    test('should return UserNameValidateState.valid when username is correct',
        () {
      var username = "Ameery";
      var result = inputValidation.checkValidateUserName(username);

      expect(result, UserNameValidateState.valid);
    });
  });

  group('checkValidatePassword', () {
    test('should return PasswordValidateState.empty when password is null', () {
      var password = null;

      var result = inputValidation.checkValidatePassword(password);

      expect(result, PasswordValidateState.empty);
    });

    test('should return PasswordValidateState.empty when password is empty', () {
      var password = "";
      var result = inputValidation.checkValidatePassword(password);

      expect(result, PasswordValidateState.empty);
    });

    test('should return PasswordValidateState.short when password is too short', () {
      var password = "short";
      var result = inputValidation.checkValidatePassword(password);

      expect(result, PasswordValidateState.short);
    });

    test('should return PasswordValidateState.valid when password is valid', () {
      var password = "validPass123!";
      var result = inputValidation.checkValidatePassword(password);

      expect(result, PasswordValidateState.valid);
    });
  });
}
