import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horda_client/horda_client.dart';

import 'compose_tweet/compose_tweet_page.dart';
import 'explore/explore_page.dart';
import 'home/home_page.dart';
import 'profile/blocked_users_page.dart';
import 'profile/edit_profile_page.dart';
import 'profile/followers_page.dart';
import 'profile/following_page.dart';
import 'profile/profile_page.dart';
import 'shared/me_query_shell.dart';
import 'sign_in/sign_in_page.dart';
import 'sign_up/sign_up_page.dart';
import 'tweet_details/tweet_details_page.dart';

var gIsSigningUp = false;

final kRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return MeQueryShell(child: child);
      },
      routes: <RouteBase>[
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
                      routes: [
                        GoRoute(
                          path: 'followers',
                          builder: (BuildContext context, GoRouterState state) {
                            final userId = state.pathParameters['userId']!;
                            return FollowersPage(userId: userId);
                          },
                        ),
                        GoRoute(
                          path: 'following',
                          builder: (BuildContext context, GoRouterState state) {
                            final userId = state.pathParameters['userId']!;
                            return FollowingPage(userId: userId);
                          },
                        ),
                        GoRoute(
                          path: 'blocked_users',
                          builder: (BuildContext context, GoRouterState state) {
                            final userId = state.pathParameters['userId']!;
                            return BlockedUsersPage(userId: userId);
                          },
                        ),
                        GoRoute(
                          path: 'edit',
                          builder: (BuildContext context, GoRouterState state) {
                            final userId = state.pathParameters['userId']!;
                            return EditProfilePage(userId: userId);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                GoRoute(
                  path: 'profile/:userId',
                  builder: (BuildContext context, GoRouterState state) {
                    final userId = state.pathParameters['userId']!;
                    return ProfilePage(userId: userId);
                  },
                  routes: [
                    GoRoute(
                      path: 'followers',
                      builder: (BuildContext context, GoRouterState state) {
                        final userId = state.pathParameters['userId']!;
                        return FollowersPage(userId: userId);
                      },
                    ),
                    GoRoute(
                      path: 'following',
                      builder: (BuildContext context, GoRouterState state) {
                        final userId = state.pathParameters['userId']!;
                        return FollowingPage(userId: userId);
                      },
                    ),
                    GoRoute(
                      path: 'blocked_users',
                      builder: (BuildContext context, GoRouterState state) {
                        final userId = state.pathParameters['userId']!;
                        return BlockedUsersPage(userId: userId);
                      },
                    ),
                    GoRoute(
                      path: 'edit',
                      builder: (BuildContext context, GoRouterState state) {
                        final userId = state.pathParameters['userId']!;
                        return EditProfilePage(userId: userId);
                      },
                    ),
                  ],
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
                  routes: [
                    GoRoute(
                      path: 'followers',
                      builder: (BuildContext context, GoRouterState state) {
                        final userId = state.pathParameters['userId']!;
                        return FollowersPage(userId: userId);
                      },
                    ),
                    GoRoute(
                      path: 'following',
                      builder: (BuildContext context, GoRouterState state) {
                        final userId = state.pathParameters['userId']!;
                        return FollowingPage(userId: userId);
                      },
                    ),
                    GoRoute(
                      path: 'blocked_users',
                      builder: (BuildContext context, GoRouterState state) {
                        final userId = state.pathParameters['userId']!;
                        return BlockedUsersPage(userId: userId);
                      },
                    ),
                    GoRoute(
                      path: 'edit',
                      builder: (BuildContext context, GoRouterState state) {
                        final userId = state.pathParameters['userId']!;
                        return EditProfilePage(userId: userId);
                      },
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              path: 'profile/:userId',
              builder: (BuildContext context, GoRouterState state) {
                final userId = state.pathParameters['userId']!;
                return ProfilePage(userId: userId);
              },
              routes: [
                GoRoute(
                  path: 'followers',
                  builder: (BuildContext context, GoRouterState state) {
                    final userId = state.pathParameters['userId']!;
                    return FollowersPage(userId: userId);
                  },
                ),
                GoRoute(
                  path: 'following',
                  builder: (BuildContext context, GoRouterState state) {
                    final userId = state.pathParameters['userId']!;
                    return FollowingPage(userId: userId);
                  },
                ),
                GoRoute(
                  path: 'blocked_users',
                  builder: (BuildContext context, GoRouterState state) {
                    final userId = state.pathParameters['userId']!;
                    return BlockedUsersPage(userId: userId);
                  },
                ),
                GoRoute(
                  path: 'edit',
                  builder: (BuildContext context, GoRouterState state) {
                    final userId = state.pathParameters['userId']!;
                    return EditProfilePage(userId: userId);
                  },
                ),
              ],
            ),
          ],
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
        if (context.hordaAuthState is AuthStateLoggedIn && !gIsSigningUp) {
          return '/';
        }

        return null;
      },
    ),
  ],
  initialLocation: '/signin',
);
