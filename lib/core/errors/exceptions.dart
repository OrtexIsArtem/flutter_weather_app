/// Exception representing a server-related error.
class ServerException implements Exception {
  final String? message;

  ServerException([this.message]);
}

/// Exception representing a cache-related error.
class CacheException implements Exception {
  final String? message;

  CacheException([this.message]);
}

/// Exception representing a connection-related error.
class ConnectionException implements Exception {}
