import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horda_client/horda_client.dart';
import 'package:twitter_client/tweet_details/tweet_details_page.dart';

import 'home/home_page.dart';
import 'sign_in/sign_in_page.dart'; // Import SignInPage
import 'sign_up/sign_up_page.dart';

void main() {
  final projectId = 'YOUR_PROJECT_ID';
  final apiKey = 'YOUR_API_KEY';

  final url = 'wss://api.horda.ai/\$projectId/client';

  final conn = NoAuthConfig(url: url, apiKey: apiKey);
  final system = HordaClientSystem(conn, NoAuth());

  system.start();

  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: '/signup',
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpPage();
        },
      ),
      GoRoute( // New route for sign-in
        path: '/signin',
        builder: (BuildContext context, GoRouterState state) {
          return const SignInPage();
        },
      ),
      GoRoute(
        path: '/tweet/:tweetId',
        builder: (BuildContext context, GoRouterState state) {
          final tweetId = state.pathParameters['tweetId']!;
          return TweetDetailsPage(tweetId: tweetId);
        },
      ),
      GoRoute(
        path: '/profile/:userId',
        builder: (BuildContext context, GoRouterState state) {
          final userId = state.pathParameters['userId']!;
          return ProfilePage(userId: userId);
        },
      ),
      GoRoute(
        path: '/explore',
        builder: (BuildContext context, GoRouterState state) {
          return const ExplorePage();
        },
      ),
      GoRoute(
        path: '/compose_tweet',
        builder: (BuildContext context, GoRouterState state) {
          return const ComposeTweetPage();
        },
      ),
    ],
    initialLocation: '/signin', // Set initial route to signin for testing
  );

  runApp(
    HordaSystemProvider(
      system: system,
      child: MyApp(router: _router),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Twitter Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class NoAuth implements AuthProvider {
  @override
  Future<String?> getIdToken() async {
    return 'token';
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