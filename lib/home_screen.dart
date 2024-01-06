import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network_connectivity_riverpod/connectivity_status_notifier.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  final List<ConnectivityStatus> status = <ConnectivityStatus>[];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var connectivity = ref.watch(connectivityStatusProvider);
    status.add(connectivity as ConnectivityStatus);
    return Scaffold(
        appBar: null,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
          child: ListView.builder(
            itemCount: status.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  status[index].msg(),
                  style: TextStyle(
                      fontWeight: index == status.length - 1
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
                subtitle: Text(index == status.length - 1 ? "current" : ""),
              );
            },
          ),
        ));
  }
}
