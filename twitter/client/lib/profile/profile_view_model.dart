import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';

import '../queries.dart';

class ProfileViewModel {
  final BuildContext context;
  final HordaClientSystem system;

  ProfileViewModel(this.context) : system = HordaSystemProvider.of(context);

  EntityQueryDependencyBuilder<UserAccountQuery> get userAccountQuery {
    return context.query<UserAccountQuery>();
  }

  EntityQueryDependencyBuilder<UserProfileQuery> get userProfileQuery {
    return userAccountQuery.ref((q) => q.profile);
  }

  String get handle => userAccountQuery.value((q) => q.handle);

  int get followerCount => userAccountQuery.counter((q) => q.followerCount);

  int get followingCount => userAccountQuery.counter((q) => q.followingCount);

  DateTime get registeredAt => userAccountQuery.value((q) => q.registeredAt);

  String get displayName => userProfileQuery.value((q) => q.displayName);

  String get avatarUrl => userProfileQuery.value((q) => q.avatarUrl);

  String get bio => userProfileQuery.value((q) => q.bio);
}
