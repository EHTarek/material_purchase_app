import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl({required this.connectionChecker});

  final InternetConnectionChecker connectionChecker;

  @override
  Future<bool> get isConnected async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    return await connectionChecker.hasConnection
        || connectivityResult.contains(ConnectivityResult.mobile)
        || connectivityResult.contains(ConnectivityResult.wifi)
        || connectivityResult.contains(ConnectivityResult.ethernet)
        || connectivityResult.contains(ConnectivityResult.vpn);
    // return await connectionChecker.hasConnection;
  }
}
