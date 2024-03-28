import 'package:internet_connection_checker/internet_connection_checker.dart';

/// A contract for checking network connectivity status.
abstract interface class NetworkInfo {
  Future<bool> get isConnected;
}

/// Implementation of the [NetworkInfo] contract using [InternetConnectionChecker].
class NetworkInfoImpl implements NetworkInfo {
  /// Creates a [NetworkInfoImpl] instance with the provided [connectionChecker].
  const NetworkInfoImpl(this.connectionChecker);

  final InternetConnectionChecker connectionChecker;

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

}
