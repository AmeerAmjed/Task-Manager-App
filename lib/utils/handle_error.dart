import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String message;

  const ServerException({required this.message});

  @override
  List<Object?> get props => [message];
}

class FetchDataException extends ServerException {
  const FetchDataException() : super(message: "error during communication");
}

class BadRequestException extends ServerException {
  final String message;

  const BadRequestException({this.message = "bad request"})
      : super(message: message);
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException() : super(message: "Unauthorized");
}

class NotFoundException extends ServerException {
  const NotFoundException() : super(message: "Not Found");
}

class InternalServerException extends ServerException {
  const InternalServerException() : super(message: "Internal Server error");
}

class NoInternetConnectionException extends ServerException {
  const NoInternetConnectionException()
      : super(message: "No Internet Connection");
}
