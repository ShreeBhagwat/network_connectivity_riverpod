import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network_connectivity_riverpod/home_screen.dart';

void main() {
  runApp(ProviderScope(child: NetworkConnectivity()));
}

class NetworkConnectivity extends StatelessWidget {
  const NetworkConnectivity({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
