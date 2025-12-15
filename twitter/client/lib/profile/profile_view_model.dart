import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';
import 'package:twitter_server/twitter_server.dart';

import '../queries.dart';

class ProfileViewModel {
  final BuildContext context;

  ProfileViewModel(this.context);

  EntityQueryDependencyBuilder<UserAccountQuery> get userAccountQuery {
    return context.query<UserAccountQuery>();
  }

  EntityQueryDependencyBuilder<UserProfileQuery> get userProfileQuery {
    return userAccountQuery.ref((q) => q.profile);
  }

  String get handle => userAccountQuery.value((q) => q.handle);

  int get followerCount => userAccountQuery.counter((q) => q.followerCount);

  int get followingCount => userAccountQuery.counter((q) => q.followingCount);

  int get blockedUsersCount => userAccountQuery.counter((q) => q.blockedCount);

  DateTime get registeredAt => userAccountQuery.value((q) => q.registeredAt);

  String get displayName => userProfileQuery.value((q) => q.displayName);

  String get avatarUrl => userProfileQuery.value((q) => q.avatarUrl);

  String get bio => userProfileQuery.value((q) => q.bio);

  bool get isNotCurrentUser {
    final currentUserId = context.hordaAuthUserId;
    return currentUserId != userAccountQuery.id();
  }

  bool get isFollowing {
    final currentUserId = context.hordaAuthUserId;
    if (currentUserId == null) return false;

    final followingUsers = context
        .query<MeQuery>()
        .listItems(
          (q) => q.following,
        )
        .map((item) => item.value);

    return followingUsers.contains(userAccountQuery.id());
  }

  bool get isBlocked {
    final currentUserId = context.hordaAuthUserId;
    if (currentUserId == null) return false;

    final blockedUsers = context
        .query<MeQuery>()
        .listItems(
          (q) => q.blockedUsers,
        )
        .map((item) => item.value);

    return blockedUsers.contains(userAccountQuery.id());
  }

  Future<void> toggleFollow() async {
    final result = await context.runProcess(
      ToggleUserFollowRequested(userAccountQuery.id()),
    );

    if (result.isError) {
      throw Exception(result.value ?? 'Failed to toggle follow status.');
    }
  }

  Future<void> toggleBlock() async {
    final result = await context.runProcess(
      ToggleUserBlockRequested(userAccountQuery.id()),
    );

    if (result.isError) {
      throw Exception(result.value ?? 'Failed to toggle block status.');
    }
  }
}
