import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';

import 'auth.dart';
import 'config.dart';
import 'firebase_options.dart';
import 'logger.dart';
import 'router.dart';

void main() async {
  AppLogger.init();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // final idToken = await kAuthService.getIdToken();
  // await kAuthService.logout();

  // ConnectionConfig conn;
  // if (idToken == null) {
  //   conn = IncognitoConfig(url: kUrl, apiKey: kApiKey);
  // } else {
  //   conn = LoggedInConfig(url: kUrl, apiKey: kApiKey);
  // }

  final conn = NoAuthConfig(url: kUrl, apiKey: kApiKey);

  final system = HordaClientSystem(conn, NoAuth());

  system.start();

  runApp(HordaSystemProvider(system: system, child: TwitterClient()));
}

class TwitterClient extends StatelessWidget {
  const TwitterClient({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Twitter Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: kRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}

class NoAuth implements AuthProvider {
  @override
  Future<String?> getIdToken() async {
    final userId = await kAuthService.getUserId();
    if (userId == null) {
      return '';
    }

    return userId;
  }
}

class NoAuthConfig extends IncognitoConfig {
  NoAuthConfig({required super.url, required super.apiKey});

  @override
  Map<String, dynamic> get httpHeaders => {
    ...super.httpHeaders,
    'isScriptConnection': true,
  };
}
