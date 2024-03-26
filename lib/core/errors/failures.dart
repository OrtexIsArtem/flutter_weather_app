import 'package:equatable/equatable.dart';

/// Abstract base class for failures.
abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

/// Failure representing a server-related error.
class ServerFailure extends Failure {}

/// Failure representing a cache-related error.
class CacheFailure extends Failure {}

/// Failure representing a connection-related error.
class ConnectionFailure extends Failure {}
