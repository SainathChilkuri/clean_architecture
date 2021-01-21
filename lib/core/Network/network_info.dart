import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';

abstract class NetworkInfo {
Future<bool> get isConnected;
}
class NetworkInfoImpl extends NetworkInfo{
DataConnectionChecker dataConnectionChecker;
NetworkInfoImpl({
  @required this.dataConnectionChecker
});
  @override
  Future<bool> get isConnected => dataConnectionChecker.hasConnection;

}