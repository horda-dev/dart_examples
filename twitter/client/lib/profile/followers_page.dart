import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horda_client/horda_client.dart';

import '../queries.dart';
import '../shared/author_user_view_model.dart';

class FollowersPage extends StatelessWidget {
  final String userId;

  const FollowersPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Followers'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: context.entityQuery(
        entityId: userId,
        query: UserFollowersQuery(),
        loading: const Center(child: CircularProgressIndicator()),
        error: const Center(child: Text('Failed to load followers')),
        child: Builder(
          builder: (context) {
            final followersLength = context
                .query<UserFollowersQuery>()
                .listLength((q) => q.followers);

            if (followersLength == 0) {
              return const Center(
                child: Text('No followers yet.'),
              );
            }

            return ListView.builder(
              itemCount: followersLength,
              itemBuilder: (context, index) {
                final followerQuery = context
                    .query<UserFollowersQuery>()
                    .listItem((q) => q.followers, index);
                final follower = AuthorUserViewModel(followerQuery);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(follower.avatarUrl),
                  ),
                  title: Text(follower.displayName),
                  subtitle: Text('@${follower.handle}'),
                  onTap: () {
                    context.go('/profile/${follower.id}');
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
