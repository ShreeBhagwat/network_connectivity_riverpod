import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectivityStatus {
  uknown,
  connected,
  disconnected;

  String msg() {
    switch (this) {
      case ConnectivityStatus.uknown:
        return "Conectivity status: <uknown>\n[${DateTime.now()}]";
      case ConnectivityStatus.connected:
        return "Conectivity status: <connected>\n[${DateTime.now()}]";
      case ConnectivityStatus.disconnected:
        return "Conectivity status: <disconnected>\n[${DateTime.now()}]";
    }
  }
}

extension ConnectivityResultX on ConnectivityResult {
  ConnectivityStatus get connectivityStatus {
    switch (this) {
      case ConnectivityResult.none:
        return ConnectivityStatus.disconnected;
      default:
        return ConnectivityStatus.connected;
    }
  }
}

class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {
  ConnectivityStatusNotifier() : super(ConnectivityStatus.uknown) {
    init();
  }

  Future<void> init() async {
    final Connectivity connectivity = Connectivity();
    await checkInitialConnection(connectivity);
    subscribeToTheConnectionChange(connectivity);
  }

  Future<void> checkInitialConnection(Connectivity connectivity) async {
    var current = await connectivity.checkConnectivity();
    state = current.connectivityStatus;
  }

  void subscribeToTheConnectionChange(Connectivity connectivity) {
    connectivity.onConnectivityChanged.listen((result) {
      state = result.connectivityStatus;
    });
  }
}

final connectivityStatusProvider = StateNotifierProvider((ref) {
  return ConnectivityStatusNotifier();
});
