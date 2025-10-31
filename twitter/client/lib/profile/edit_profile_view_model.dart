import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';
import 'package:twitter_server/twitter_server.dart';

import '../queries.dart';

class EditProfileViewModel {
  final BuildContext context;

  EditProfileViewModel(this.context);

  EntityQueryDependencyBuilder<UserAccountQuery> get userAccountQuery {
    return context.query<UserAccountQuery>();
  }

  EntityQueryDependencyBuilder<UserProfileQuery> get userProfileQuery {
    return userAccountQuery.ref((q) => q.profile);
  }

  String get profileId => userProfileQuery.id();
  String get displayName => userProfileQuery.value((q) => q.displayName);
  String get bio => userProfileQuery.value((q) => q.bio);
  String get avatarUrl => userProfileQuery.value((q) => q.avatarUrl);

  Future<void> updateProfile({
    required String displayName,
    required String bio,
    String? avatarBase64,
  }) async {
    final result = await context.runProcess(
      ClientUpdateUserProfileRequested(
        profileId: profileId,
        displayName: displayName,
        bio: bio,
        avatarBase64: avatarBase64,
      ),
    );

    if (result.isError) {
      throw Exception(result.value ?? 'Failed to update profile.');
    }
  }
}
