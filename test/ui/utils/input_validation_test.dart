import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/ui/utils/input_validation.dart';

void main() {
  late InputValidation inputValidation;

  setUp(() {
    inputValidation = InputValidation();
  });

  group('checkValidateUserName', () {
    test('should return UserNameValidateState.empty when username is null', () {
      //Arrange
      var username = null;
      // Act
      var result = inputValidation.checkValidateUserName(username);
      // Assert
      expect(result, UserNameValidateState.empty);
    });

    test('should return UserNameValidateState.empty when username is empty',
        () {
      //Arrange
      var username = "";
      // Act
      var result = inputValidation.checkValidateUserName(username);
      // Assert
      expect(result, UserNameValidateState.empty);
    });

    test('should return UserNameValidateState.valid when username is correct',
        () {
      //Arrange
      var username = "Ameery";
      // Act
      var result = inputValidation.checkValidateUserName(username);
      // Assert
      expect(result, UserNameValidateState.valid);
    });
  });

  group('checkValidatePassword', () {
    test('should return PasswordValidateState.empty when password is null', () {
      //Arrange
      var password = null;
      // Act
      var result = inputValidation.checkValidatePassword(password);
      // Assert
      expect(result, PasswordValidateState.empty);
    });

    test('should return PasswordValidateState.empty when password is empty', () {
      //Arrange
      var password = "";
      // Act
      var result = inputValidation.checkValidatePassword(password);
      // Assert
      expect(result, PasswordValidateState.empty);
    });

    test('should return PasswordValidateState.short when password is too short', () {
      //Arrange
      var password = "short";
      // Act
      var result = inputValidation.checkValidatePassword(password);
      // Assert
      expect(result, PasswordValidateState.short);
    });

    test('should return PasswordValidateState.valid when password is valid', () {
      //Arrange
      var password = "validPass123!";
      // Act
      var result = inputValidation.checkValidatePassword(password);
      // Assert
      expect(result, PasswordValidateState.valid);
    });
  });

  group('checkValidateTitleTodo', () {
    test('returns TitleTodoValidateState.empty when value is null', () {
      //Arrange
      var title = null;
      // Act
      var result = inputValidation.checkValidateTitleTodo(title);
      // Assert
      expect(result, TitleTodoValidateState.empty);
    });

    test('returns TitleTodoValidateState.empty when value is empty string', () {
      //Arrange
      var title = '';
      // Act
      var result = inputValidation.checkValidateTitleTodo(title);
      // Assert
      expect(result, TitleTodoValidateState.empty);
    });

    test('returns TitleTodoValidateState.short when value is more 4 spaces',
        () {
      //Arrange
      var title = '     ';
      // Act
      var result = inputValidation.checkValidateTitleTodo(title);
      // Assert
      expect(result, TitleTodoValidateState.short);
    });
    test(
        'returns TitleTodoValidateState.short when value is less than 4 characters',
        () {
      //Arrange
      var title = 'tas';
      // Act
      var result = inputValidation.checkValidateTitleTodo(title);
      // Assert
      expect(result, TitleTodoValidateState.short);
    });

    test('returns valid when value is 4 or more characters', () {
      //Arrange
      var title = 'task';
      // Act
      var result = inputValidation.checkValidateTitleTodo(title);
      // Assert
      expect(result, TitleTodoValidateState.valid);
    });
  });
}
