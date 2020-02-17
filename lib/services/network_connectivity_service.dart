import 'package:flutter_repository_example/services/inetwork_connectivity_service.dart';

class NetworkConnectivityService implements INetworkConnectivityService {
  @override
  bool isConnected() {
    return true;
  }
}
