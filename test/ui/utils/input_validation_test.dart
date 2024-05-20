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
}
