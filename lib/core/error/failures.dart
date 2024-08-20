import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class MovieFailure extends Failure {
  const MovieFailure({required super.message});
}

// Clases específicas para algunos códigos de error comunes
class AuthenticationFailure extends MovieFailure {
  const AuthenticationFailure() : super(message: "Authentication failed.");
}

class SuspendedApiKeyFailure extends MovieFailure {
   const SuspendedApiKeyFailure() : super(message: "Your API key has been suspended.");
}

class ResourceNotFoundFailure extends MovieFailure {
  const ResourceNotFoundFailure() : super(message: "The resource was not found.");
}

class InternalServerErrorFailure extends MovieFailure {
  const InternalServerErrorFailure() : super(message: "Internal server error occurred.");
}

class ServiceOfflineFailure extends MovieFailure {
  const ServiceOfflineFailure() : super(message: "The service is temporarily offline.");
}

class InvalidApiKeyFailure extends MovieFailure {
  const InvalidApiKeyFailure() : super(message: "Invalid API key.");
}

class DuplicateEntryFailure extends MovieFailure {
  const DuplicateEntryFailure() : super(message: "The data you tried to submit already exists.");
}

class ValidationFailure extends MovieFailure {
  const ValidationFailure() : super(message: "Validation failed.");
}

class InvalidPageFailure extends MovieFailure {
  const InvalidPageFailure() : super(message: "Invalid page: Pages start at 1 and max at 500.");
}

class InvalidDateFailure extends MovieFailure {
  const InvalidDateFailure() : super(message: "Invalid date: Format needs to be YYYY-MM-DD.");
}

class RequestTimeoutFailure extends MovieFailure {
  const RequestTimeoutFailure() : super(message: "Your request to the backend server timed out.");
}

class RateLimitExceededFailure extends MovieFailure {
  const RateLimitExceededFailure() : super(message: "Your request count is over the allowed limit.");
}

class InvalidCredentialsFailure extends MovieFailure {
  const InvalidCredentialsFailure() : super(message: "Invalid username and/or password.");
}

class ConnectionFailure extends MovieFailure {
  const ConnectionFailure() : super(message: "Failed to connect to the server.");
}

class UnknownErrorFailure extends MovieFailure {
  const UnknownErrorFailure({required super.message});
}