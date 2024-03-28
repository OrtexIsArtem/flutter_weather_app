import 'package:equatable/equatable.dart';

/// Abstract base class for failures.
abstract class Failure extends Equatable {
  const Failure([this.message]);

  final String? message;

  @override
  List<Object?> get props => [message];
}

/// Failure representing a server-related error.
class ServerFailure extends Failure {
  const ServerFailure([super.message]);
}

/// Failure representing a cache-related error.
class CacheFailure extends Failure {
  const CacheFailure([super.message]);
}

/// Failure representing a connection-related error.
class ConnectionFailure extends Failure {
  const ConnectionFailure([super.message]);
}
