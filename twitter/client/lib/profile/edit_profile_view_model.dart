import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';
import 'package:twitter_server/twitter_server.dart';

import '../queries.dart';

class EditProfileViewModel {
  final BuildContext context;
  final HordaClientSystem _hordaSystem;

  EditProfileViewModel(this.context)
      : _hordaSystem = HordaSystemProvider.of(context);

  EntityQueryDependencyBuilder<UserAccountQuery> get userAccountQuery {
    return context.query<UserAccountQuery>();
  }

  EntityQueryDependencyBuilder<UserProfileQuery> get userProfileQuery {
    return userAccountQuery.ref((q) => q.profile);
  }

  String get displayName => userProfileQuery.value((q) => q.displayName);
  String get bio => userProfileQuery.value((q) => q.bio);
  String get avatarUrl => userProfileQuery.value((q) => q.avatarUrl);

  Future<void> updateProfile({
    required String displayName,
    required String bio,
    String? avatarBase64,
  }) async {
    final result = await _hordaSystem.dispatchEvent(
      ClientUpdateUserProfileRequested(
        userId: userAccountQuery.id(),
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