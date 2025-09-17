import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horda_client/horda_client.dart';

import 'compose_tweet/compose_tweet_page.dart';
import 'explore/explore_page.dart';
import 'home/home_page.dart';
import 'profile/profile_page.dart';
import 'sign_in/sign_in_page.dart';
import 'sign_up/sign_up_page.dart';
import 'tweet_details/tweet_details_page.dart';

final kRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'explore',
          builder: (BuildContext context, GoRouterState state) {
            return const ExplorePage();
          },
          routes: [
            GoRoute(
              path: 'tweet/:tweetId',
              builder: (BuildContext context, GoRouterState state) {
                final tweetId = state.pathParameters['tweetId']!;
                return TweetDetailsPage(tweetId: tweetId);
              },
              routes: [
                GoRoute(
                  path: 'profile/:userId',
                  builder: (BuildContext context, GoRouterState state) {
                    final userId = state.pathParameters['userId']!;
                    return ProfilePage(userId: userId);
                  },
                ),
              ],
            ),
            GoRoute(
              path: 'profile/:userId',
              builder: (BuildContext context, GoRouterState state) {
                final userId = state.pathParameters['userId']!;
                return ProfilePage(userId: userId);
              },
            ),
          ],
        ),
        GoRoute(
          path: 'compose_tweet',
          builder: (BuildContext context, GoRouterState state) {
            return const ComposeTweetPage();
          },
        ),
        GoRoute(
          path: 'tweet/:tweetId',
          builder: (BuildContext context, GoRouterState state) {
            final tweetId = state.pathParameters['tweetId']!;
            return TweetDetailsPage(tweetId: tweetId);
          },
          routes: [
            GoRoute(
              path: 'profile/:userId',
              builder: (BuildContext context, GoRouterState state) {
                final userId = state.pathParameters['userId']!;
                return ProfilePage(userId: userId);
              },
            ),
          ],
        ),
        GoRoute(
          path: 'profile/:userId',
          builder: (BuildContext context, GoRouterState state) {
            final userId = state.pathParameters['userId']!;
            return ProfilePage(userId: userId);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/signin',
      builder: (BuildContext context, GoRouterState state) {
        return const SignInPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'signup',
          builder: (BuildContext context, GoRouterState state) {
            return const SignUpPage();
          },
        ),
      ],
      redirect: (BuildContext context, GoRouterState state) {
        if (context.hordaAuthState is AuthStateLoggedIn) {
          return '/';
        }

        return null;
      },
    ),
  ],
  initialLocation: '/signin',
);
