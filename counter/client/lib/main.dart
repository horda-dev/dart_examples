import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';

import 'logger.dart';
import 'pages/counter_details/page.dart';
import 'pages/counter_list/page.dart';

void main() {
  AppLogger.init();

  final projectId = 'd2sqf8kgc98s73838big';
  final apiKey =
      'sk-client-UPSq-BgHNnDZVGdnaIsB8rPzTL4kpQnNJeTyTr7YZVcjdpDu-ArIbDOe1K-Ppi5wWuwk3bp3wmZUwA_pwng_zg';

  final url = 'wss://api.horda.dev/runtime/client/$projectId';
  // final url = 'ws://localhost:8080/client'; // For local development
  // final url = 'ws://10.0.2.2:8080/client'; // For local development with Android emulator

  final system = HordaClientSystem(url: url, apiKey: apiKey);

  system.start();

  runApp(HordaSystemProvider(system: system, child: const CounterClient()));
}

class CounterClient extends StatelessWidget {
  const CounterClient({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const CounterListPage(),
        '/counter': (context) => const CounterDetailsPage(),
      },
    );
  }
}
